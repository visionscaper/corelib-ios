//
//  UIViewController+ModelInteraction.m
//  Visionscapers core library
//
//  Extending UIViewController with functionalities to interact with models
//
//  Created by Freddy Snijder on 26/03/14.
//  Copyright (c) 2014 Visionscapers. All rights reserved.
//

#import "UIViewController+ModelInteraction.h"

static __weak ViModel *_model = nil;

@implementation UIViewController (ModelInteraction)

- (BOOL)setModel:(ViModel*)model {
    _model = model;
    
    if (_model) {
        [self _didSetModel];
    }
    
    return !!_model;
}

- (void)_didSetModel {
    _LOG_INFO(@"%@", @"Controller did not implement _didSetModel method");
}

- (ViModel*)getModel {
    return _model;
}

- (void)modelUpdated {
    _LOG_WARN(@"%@", @"Controller did not implement modelUpdated method");
}

@end
