//
//  ViNotifierService+protected.m
//  EZSupport
//
//  Created by Freddy Snijder on 18/09/14.
//  Copyright (c) 2014 Visionscapers. All rights reserved.
//

#import "ViNotifierService+protected.h"

@implementation ViNotifierService (Protected)

-(void)_notifyListenersOf:(NSString*)notificationName withData:(id)data {
    
    SEL notificationMethod = NSSelectorFromString(notificationName);
    if (!notificationMethod) {
        _LOG_ERROR(@"Unable to find notification method %@, will not notify listeners", notificationName);
        return;
    }
    
    IMP imp                     = nil;
    void (*func)(id, SEL, id)   = NULL;
    BOOL errorOccurred          = NO;
    for (int i = 0; i < [_listeners count]; i++) {
        if ([_listeners[i] respondsToSelector:notificationMethod]) {
            imp     = [_listeners[i] methodForSelector:notificationMethod];
            func    = (void *)imp;
            
            func(_listeners[i], notificationMethod, data);
        } else {
            errorOccurred = YES;
        }
    }
    
    if (errorOccurred) {
        _LOG_ERROR(@"Notfication method %@ not available at the listeners", notificationName);
    }
}

@end
