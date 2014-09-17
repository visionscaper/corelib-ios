//
//  ViNotifierService.m
//  EZSupport
//
//  Created by Freddy Snijder on 18/09/14.
//  Copyright (c) 2014 Visionscapers. All rights reserved.
//

#import "ViNotifierService.h"

@implementation ViNotifierService

-(id)init
{
    self = [super init];
    
    if (self) {
        _listeners  = [NSMutableArray arrayWithCapacity:1];
        _isValid    = YES;
    }
    
    return self;
}

-(BOOL)add:(id)listener {
    if (!listener) {
        _LOG_ERROR(@"%@", @"Given listener is invalid, unable to add it.");
        return NO;
    }
    
    [_listeners addObject:listener];
    
    return YES;
}

-(BOOL)remove:(id)listener {
    if (!listener) {
        _LOG_WARN(@"%@", @"Given listener is invalid, unable to remove it.");
        return NO;
    }
    
    [_listeners removeObject:listener];
    
    return YES;
}


@end
