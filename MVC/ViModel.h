//
//  ViModel.h
//  Visionscapers core library
//
//  Created by Freddy Snijder on 24/03/14.
//  Copyright (c) 2014 Visionscapers. All rights reserved.
//

#import "ViBase.h"
#import "ViController.h"

@class ViController;

@interface ViModel : ViBase {
    
    @protected
    
    //We don't own the controller
    ViController* __weak _controller;
    
}

//Readonly access to controller
@property (readonly) ViController* controller;

- (BOOL)registerController:(ViController*)controller;

- (void)_notifyController;

@end
