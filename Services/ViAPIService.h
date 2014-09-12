//
//  ViAPIService.h
//  Visionscapers core library
//
//  Created by Freddy Snijder on 02/04/14.
//  Copyright (c) 2014 Visionscapers. All rights reserved.
//

#import <Foundation/Foundation.h>


//Could use a seperate success & failure callback, this is more compact
typedef void(^ViAPIReadyCb)(NSDictionary* data, NSError* error);


@protocol ViAPIService <NSObject>

-(BOOL)getResource:(NSString*)resourcePath onReady:(ViAPIReadyCb)readyCb;


@optional  // SOME DAY ...

-(BOOL)postData:(NSDictionary*)data forResource:(NSString*)resourcePath onReady:(ViAPIReadyCb)readyCb;
-(BOOL)putData:(NSDictionary*)data forResource:(NSString*)resourcePath onReady:(ViAPIReadyCb)readyCb;

-(BOOL)deleteResource:(NSString*)resourcePath onReady:(ViAPIReadyCb)readyCb;

@end

