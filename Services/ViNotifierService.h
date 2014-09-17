//
//  ViNotifierService.h
//  EZSupport
//
//  Created by Freddy Snijder on 18/09/14.
//  Copyright (c) 2014 Visionscapers. All rights reserved.
//

#import "ViBase.h"

@protocol ViNotifierService <NSObject>

-(BOOL)add:(id)listener;
-(BOOL)remove:(id)listener;

@end

@interface ViNotifierService : ViBase <ViNotifierService> {
    
@protected
    NSMutableArray* _listeners;

}


@end
