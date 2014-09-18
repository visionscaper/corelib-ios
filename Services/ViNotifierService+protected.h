//
//  ViNotifierService+protected.h
//  EZSupport
//
//  Created by Freddy Snijder on 18/09/14.
//  Copyright (c) 2014 Visionscapers. All rights reserved.
//
#import "ViNotifierService.h"

@interface ViNotifierService (Protected)

//notificationName must coincide with one of the EZSSDPServiceListener methods
-(void)_notifyListenersOf:(NSString*)notificationName withData:(id)data;

@end
