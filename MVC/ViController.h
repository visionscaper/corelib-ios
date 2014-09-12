//
//  ViController.h
//  Visionscapers core library
//
//  Created by Freddy Snijder on 26/03/14.
//  Copyright (c) 2014 Visionscapers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViModel.h"

@class ViModel;

@interface ViController : UIViewController {
    @protected
    ViModel* __weak _model;
}

- (BOOL)setModel:(ViModel*)model;

- (void)modelUpdated;

@end
