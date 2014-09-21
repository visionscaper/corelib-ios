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

    //Dispatch such that notifer doesn't have to wait
    NSArray* __weak theListeners = _listeners;
    dispatch_async(dispatch_get_main_queue(), ^{
        if (!theListeners) {
            return;
        }
        
        IMP imp                     = nil;
        void (*func)(id, SEL, id)   = NULL;
        BOOL errorOccurred          = NO;
        NSUInteger numListeners     = [theListeners count];
        for (int i = 0; i < numListeners; i++) {
            if ([theListeners[i] respondsToSelector:notificationMethod]) {
                imp     = [theListeners[i] methodForSelector:notificationMethod];
                func    = (void *)imp;
                
                func(theListeners[i], notificationMethod, data);
            } else {
                errorOccurred = YES;
            }
        }
        
        if (errorOccurred) {
            _LOG_ERROR(@"Notfication method %@ not available at the listeners", notificationName);
        }
    });
}

@end
