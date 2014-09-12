//
//  ViController.m
//  Visionscapers core library
//
//  Created by Freddy Snijder on 26/03/14.
//  Copyright (c) 2014 Visionscapers. All rights reserved.
//

#import "ViController.h"

@interface ViController ()

@end

@implementation ViController

- (BOOL)setModel:(ViModel*)model {
    _model = model;
    
    return !!_model;
}

- (void)modelUpdated {
    NSLog(@"[Warning] Controller did not implement modelUpdated method");
}

@end
