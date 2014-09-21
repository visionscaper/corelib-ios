//
//  ViModel+Protected.h
//  EZSupport
//
//  Created by Freddy Snijder on 18/09/14.
//  Copyright (c) 2014 Visionscapers. All rights reserved.
//

#import "ViModel.h"

#define VI_DEFAULT_THROTTLED_EXECUTION_DELAY 350 //Milliseconds

@interface ViModel (Protected)

- (void)_notifyController;

- (NSRecursiveLock*)_getLock;
- (NSMutableDictionary*)_getThrottleTable;


/********** THROTTLING METHODS **********/

//method is assumed to return void
- (BOOL)_throttle:(NSString*)methodName;

- (BOOL)_throttle:(NSString*)methodName executeWith:(id)data;

//delayTime in milliseconds
- (BOOL)_throttle:(NSString*)methodName withExecutionDelay:(int)delayTime;
- (BOOL)_throttle:(NSString*)methodName executeWith:(id)data withExecutionDelay:(int)delayTime;

@end
