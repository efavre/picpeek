//
//  PPHttpClient.h
//  PicPeek
//
//  Created by Eric Perso on 14/05/13.
//  Copyright (c) 2013 ricky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHttpClient.h"

@interface PPHttpClient : AFHTTPClient

+ (id)sharedHTTPClient;

@end
