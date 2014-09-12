//
//  Vi.h
//  Visionscapers core library
//
//  Created by Freddy Snijder on 02/04/14.
//  Copyright (c) 2014 Visionscapers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ViBase : NSObject {

@protected
    //If this is false, we can't safely call the instance methods
    BOOL                    _isValid;
    
}

-(id)init;

//Normally would also add a method that allows to set the error code
+(NSError*)errorWithMessage:(NSString*)errMessage;

@end
