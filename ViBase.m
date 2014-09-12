//
//  Vi.m
//  Visionscapers core library
//
//  Created by Freddy Snijder on 02/04/14.
//  Copyright (c) 2014 Visionscapers. All rights reserved.
//

#import "ViBase.h"

@implementation ViBase

-(id)init {
    
    self = [super init];
    if (self) {
        _isValid = NO;
    }
    
    return self;
}

/*********************************
 *
 * CLASS METHODS
 *
 *********************************/

//Normally would also add a method that allows to set the error code
+(NSError*)errorWithMessage:(NSString*)errMessage {
    
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:errMessage, @"message", nil];
    
    NSError* err = [NSError errorWithDomain:@"Visionscapers.Core" code:(NSInteger)-1 userInfo:userInfo];
    
    return err;
}

/*********************************
 *
 * END CLASS METHODS
 *
 *********************************/


@end
