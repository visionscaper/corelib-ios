//
//  UIViewController+ModelInteraction.h
//  Visionscapers core library
//
//  Extending UIViewController with functionalities to interact with models
//
//  Created by Freddy Snijder on 26/03/14.
//  Copyright (c) 2014 Visionscapers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViModel.h"

@interface UIViewController (ModelInteraction)

- (BOOL)setModel:(ViModel*)model;
- (void)_didSetModel;

- (ViModel*)getModel;

- (void)modelUpdated;

@end
