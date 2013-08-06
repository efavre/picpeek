//
//  PPPictureManager.h
//  PicPeek
//
//  Created by Eric Perso on 14/05/13.
//  Copyright (c) 2013 ricky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PPPicture.h"
@interface PPPictureManager : NSObject

+ (id)sharedManager;
- (PPPicture *)getCurrentPicture;

@end
