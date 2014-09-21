//
//  ViModel+Protected.m
//  EZSupport
//
//  Created by Freddy Snijder on 18/09/14.
//  Copyright (c) 2014 Visionscapers. All rights reserved.
//

#import "ViModel+Protected.h"
#import "UIViewController+ModelInteraction.h"

static NSMutableDictionary* _throttleTable;
static NSRecursiveLock*     _lock;

@implementation ViModel (Protected)

-(id)init {
    self = [super init];
    
    if (self) {
        _isValid        = YES;
        
        _throttleTable  = [[NSMutableDictionary alloc] initWithCapacity:1];
        _lock           = [[NSRecursiveLock alloc] init];
    }
    
    return self;
}

- (NSRecursiveLock*)_getLock {
    return _lock;
}

- (NSMutableDictionary*)_getThrottleTable {
    return _throttleTable;
}

- (void)_notifyController {
    
    if (_controller) {
        [_controller modelUpdated];
    }
    
}

- (BOOL)_throttle:(NSString*)methodName {
    return [self _throttle:methodName executeWith:nil withExecutionDelay:VI_DEFAULT_THROTTLED_EXECUTION_DELAY];
}

- (BOOL)_throttle:(NSString*)methodName executeWith:(id)data {
    return [self _throttle:methodName executeWith:data withExecutionDelay:VI_DEFAULT_THROTTLED_EXECUTION_DELAY];
}

//delayTime in milliseconds
- (BOOL)_throttle:(NSString*)methodName withExecutionDelay:(int)delayTime {
    return [self _throttle:methodName executeWith:nil withExecutionDelay:delayTime];
}

//delayTime in milliseconds
- (BOOL)_throttle:(NSString*)methodName executeWith:(id)data withExecutionDelay:(int)delayTime {
    BOOL success = NO;
    
    if (!methodName) {
        _LOG_ERROR(@"%@", @"No valid method name provided, will not throttle");
        return success;
    }
    
    SEL method = NSSelectorFromString(methodName);
    if (![self respondsToSelector:method]) {
        _LOG_ERROR(@"Unable to find method %@, will not throttle its execution", methodName);
        return success;
    }
    
    ViModel* __weak myself = self;
    //dispatch to main thread because else we might not be able to invalidate timers
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if (!myself) {
            return;
        }
    
        [[myself _getLock] lock];
        
        NSMutableDictionary* throttleTable  = [myself _getThrottleTable];
        
        NSTimer* throttleTimer              = [throttleTable objectForKey:methodName];
        if (throttleTimer) {
            [throttleTable removeObjectForKey:methodName];
            
            if ([throttleTimer isValid]) {
                //Already throttling
                _LOG_DEBUG(@"Already throttling the execution of %@, rescheduling ...", methodName);
                
                [throttleTimer invalidate];
                throttleTimer = nil;
            }
        }
        
        throttleTimer = [NSTimer scheduledTimerWithTimeInterval:((NSTimeInterval)delayTime)/1000.0
                                                         target:self
                                                       selector:method
                                                       userInfo:data
                                                        repeats:NO];
        //Using throttleTable as a quick lookup list
        [throttleTable setObject:throttleTimer forKey:methodName];
        
        
        [[myself _getLock] unlock];
        
    });

    success = YES;
    return success;
}


@end
