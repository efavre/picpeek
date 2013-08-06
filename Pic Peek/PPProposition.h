//
//  PPProposition.h
//  PicPeek
//
//  Created by Eric Perso on 15/05/13.
//  Copyright (c) 2013 ricky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PPProposition : NSObject

@property(nonatomic, strong) NSString *proposition;
@property(nonatomic, strong) NSString *message;
@property(nonatomic) BOOL status;

+ (PPProposition *)propositionWithDictionary:(NSDictionary *)dictionary;

@end
