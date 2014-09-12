//
//  ViSimpleAPIService.m
//  Visionscapers core library
//
//  Created by Freddy Snijder on 24/03/14.
//  Copyright (c) 2014 Visionscapers. All rights reserved.
//

#import "ViSimpleAPIService.h"

@interface ViSimpleAPIService ()  {
    
    NSURL*                  _APIBaseURL;
    
    //Reusing this request
    NSMutableURLRequest*    _request;
    
    NSMutableData*          _receivedData;
    
    ViAPIReadyCb            _readyCb;
    
    BOOL                    _busyWithRequest;
    
}

-(void)_createRequestWith:(NSString*)username password:(NSString*)password;
-(NSString*)_authorizationHeaderFor:(NSString*)username password:(NSString*)password;

-(BOOL)_JSONParseReceivedData:(NSDictionary* __autoreleasing *)pDict withError:(NSError* __autoreleasing *)pErr;

@end

@implementation ViSimpleAPIService

-(id)initWithAPIURL:(NSString*)APIBaseURL
        APIUsername:(NSString*)username
        APIPassword:(NSString*)password
{
    self = [super init];
    
    if (self) {
        
        //I just like to explicitly initialize the instance variables
        _isValid            = NO;
        _readyCb            = nil;
        _busyWithRequest    = NO;
        _receivedData       = nil;
        _request            = nil;
        _APIBaseURL         = nil;
        
        if (APIBaseURL) {
            _APIBaseURL = [NSURL URLWithString:APIBaseURL];
            [self _createRequestWith:username password:password];
            
            _isValid = YES;
        } else {
            NSLog(@"Error : no valid APIBaseURL available, the API service will not function...");
        }
    }
    
    return self;
}

/*********************************
 *
 * PUBLIC METHODS
 *
 *********************************/

-(BOOL) getResource:(NSString*)resourcePath onReady:(ViAPIReadyCb)readyCb {
    
    NSString* message;
    NSError* err;
    
    if (!_isValid) {
        message = [NSString stringWithFormat:@"API Service is invalid, will not get resource %@", resourcePath, nil];
        NSLog(@"[Error] : %@", message);
        
        err = [Vi errorWithMessage:message];
        if (readyCb) {
            readyCb(nil, err);
            return NO;
        }
    }
    
    if (_busyWithRequest) {
        message = [NSString stringWithFormat:@"API Service is busy, concurrent requests not supported; " \
                                              "will not get resource %@", resourcePath, nil];
        NSLog(@"[Error] : %@", message);

        err = [Vi errorWithMessage:message];
        
        if (readyCb) {
            readyCb(nil, err);
            return NO;
        }
    }

    if (!resourcePath) {
        message = [NSString stringWithFormat:@"No valid resourcePath given; will not get resource", nil];
        NSLog(@"[Error] : %@", message);

        err = [Vi errorWithMessage:message];
        
        if (readyCb) {
            readyCb(nil, err);
            return NO;
        }
    }

    _receivedData   = [NSMutableData dataWithCapacity: 0];
    _readyCb        = readyCb;
    
    [_request setURL:[NSURL URLWithString:resourcePath relativeToURL:_APIBaseURL]];
    
    NSURLConnection *connection=[[NSURLConnection alloc] initWithRequest:_request delegate:self];
    if (!connection) {
        _receivedData = nil;

        message = [NSString stringWithFormat:@"Connection failed, unable to get resource; " \
                                              "will not get resource %@", resourcePath, nil];
        NSLog(@"[Error] : %@", message);

        err = [Vi errorWithMessage:message];
        if (readyCb) {
            readyCb(nil, err);
            return NO;
        }
    }
    
    return YES;
}

/*********************************
 *
 * END PUBLIC METHODS
 *
 *********************************/


/*********************************
 *
 * DELEGATE METHODS
 *
 *********************************/

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_receivedData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"Received response :/n%@", [response description]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSError* err;
    NSDictionary* data;
    
    [self _JSONParseReceivedData:&data withError:&err];
    
    if (_readyCb) {
        _readyCb(data, err);
    }
    
    [_receivedData setLength:0];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    if (_readyCb) {
        _readyCb(nil, error);
    }
    
    [_receivedData setLength:0];
}

/*********************************
 *
 * END DELEGATE METHODS
 *
 *********************************/


/*********************************
 *
 * PRIVATE METHODS
 *
 *********************************/

-(void)_createRequestWith:(NSString*)username password:(NSString*)password {
    _request = [[NSMutableURLRequest alloc] init];
    
    NSString* authorizationHeader = [self _authorizationHeaderFor:username password:password];
    
    if (authorizationHeader) {
        [_request addValue:authorizationHeader forHTTPHeaderField:@"Authorization"];
    } else {
        NSLog(@"Error : unable to create valid authorization header, API requests will not authenticate.");
    }
}

-(NSString*)_authorizationHeaderFor:(NSString*)username password:(NSString*)password {
    NSString* authorizationHeader = nil;
    
    if (!username || !password) {
        NSLog(@"%@", [NSString stringWithFormat:@"Error : invalid username (%@) or password, \
                                                  unable to create authorization header", username, nil]);
        
        return authorizationHeader;
    }
    
    
    NSString* rawAuthString     = [NSString stringWithFormat:@"%@:%@", username, password, nil];
    NSData* rawAuthData         = [NSData dataWithBytes:[rawAuthString UTF8String]
                                                 length:[rawAuthString lengthOfBytesUsingEncoding:NSUTF8StringEncoding]];
    
    NSString* base64AuthString  = [rawAuthData base64EncodedStringWithOptions:kNilOptions];
    
    authorizationHeader = [NSString stringWithFormat:@"Basic %@", base64AuthString, nil];
    return authorizationHeader;
}

-(BOOL)_JSONParseReceivedData:(NSDictionary* __autoreleasing *)pDict withError:(NSError* __autoreleasing *)pErr {
    NSString* message;
    BOOL success = NO;
    
    if (!_receivedData) {
        message = @"No valid received data, nothing to JSON parse.";
        NSLog(@"[Error] : %@", message);

        *pErr = [Vi errorWithMessage:message];
        return success;
    }
    
    id object = [NSJSONSerialization
                 JSONObjectWithData:_receivedData
                 options:0
                 error:pErr];
    
    if (*pErr) {
        message = @"A problem occurred JSON parsing the received data";
        NSLog(@"[Error] : %@", message);
        
        return success;
    }

    success = YES;

    if([object isKindOfClass:[NSDictionary class]]) {
        *pDict = object;
    } else {
        message = @"Received data is not a dictionary, wrapping in to a " \
                   "dictionary with field \'data\'";
        NSLog(@"[Info] : %@", message);

        *pDict = @{
                   @"data" : object
                  };
    }
    
    
    return success;    
}


/*********************************
 *
 * END PRIVATE METHODS
 *
 *********************************/

@end
