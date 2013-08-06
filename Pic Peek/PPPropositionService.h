//
//  PPPropositionService.h
//  PicPeek
//
//  Created by Eric Perso on 14/05/13.
//  Copyright (c) 2013 ricky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PPProposition.h"

@interface PPPropositionService : NSObject


+ (void)submitProposition:(NSString *)solution byNickname:(NSString *)nickname
              withSuccess:(void (^)(PPProposition *proposition))success
                  failure:(void (^)(NSHTTPURLResponse *response, NSError *error))failure;

@end
