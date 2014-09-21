//
//  ViModel.h
//  Visionscapers core library
//
//  Created by Freddy Snijder on 24/03/14.
//  Copyright (c) 2014 Visionscapers. All rights reserved.
//

#import "ViBase.h"

@interface ViModel : ViBase {
    
    @protected
    
    //We don't own the controller
    UIViewController* __weak _controller;
    
}

//Readonly access to controller
@property (readonly) UIViewController* controller;

- (BOOL)registerController:(UIViewController*)controller;

@end
