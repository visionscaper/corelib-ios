//
//  ViSimpleAPIService.h
//  Visionscapers core library
//
//  Simple API service assuming basic access authentication
//
//  ***************   IMPORTANT NOTE   ****************
//  This implementation does not allow for concurrent
//  request handling!
//  *************** END IMPORTANT NOTE ****************
//
//  Created by Freddy Snijder on 24/03/14.
//  Copyright (c) 2014 Visionscapers. All rights reserved.
//

#import "ViBase.h"
#import "ViAPIService.h"

@interface ViSimpleAPIService : ViBase <ViAPIService, NSURLConnectionDataDelegate>

-(id)initWithAPIURL:(NSString*)APIBaseURL
        APIUsername:(NSString*)username
        APIPassword:(NSString*)password;

@end
