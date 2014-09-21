//
//  ViModel.m
//  Visionscapers core library
//
//  Created by Freddy Snijder on 24/03/14.
//  Copyright (c) 2014 Visionscapers. All rights reserved.
//

#import "ViModel.h"
#import "ViModel+Protected.h"
#import "UIViewController+ModelInteraction.h"

@implementation ViModel

@synthesize controller = _controller;

- (BOOL)registerController:(UIViewController*)controller {
    BOOL success = YES;
    
    if (controller) {
        _controller = controller;
        if (![_controller setModel:self]) {
            NSLog(@"[Error] : problem setting model for controller");
            success = NO;            
        }
    } else {
        NSLog(@"[Error] : given controller is not valid, will not register");
        success = NO;
    }
    
    return success;
}

@end
