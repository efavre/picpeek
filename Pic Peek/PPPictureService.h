//
//  PictureService.h
//  Pic Peek
//
//  Created by Eric Perso on 13/05/13.
//  Copyright (c) 2013 ricky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "PPPicture.h"

@interface PPPictureService : NSObject

+ (void)getPictureInfosWithSuccess:(void (^)(PPPicture *picture))success
                           failure:(void (^)(NSError *error))failure;

+ (void)getPicture:(PPPicture *)picture squaresWithSuccess:(void (^)(NSArray *squaresArray))success
                           failure:(void (^)(NSError *error))failure;

@end
