//
//  PPProposition.m
//  PicPeek
//
//  Created by Eric Perso on 15/05/13.
//  Copyright (c) 2013 ricky. All rights reserved.
//

#import "PPProposition.h"

#define WEB_SERVICE_PROPOSITION_KEY @"proposition"
#define WEB_SERVICE_STATUS_KEY @"status"
#define WEB_SERVICE_MESSAGE_KEY @"message"

@implementation PPProposition

@synthesize proposition, message, status;

+ (PPProposition *)propositionWithDictionary:(NSDictionary *)dictionary
{
    PPProposition *proposition = [[PPProposition alloc] init];
    proposition.proposition = [dictionary objectForKey:WEB_SERVICE_PROPOSITION_KEY];
    proposition.message = [dictionary objectForKey:WEB_SERVICE_MESSAGE_KEY];
    proposition.status = ([[dictionary objectForKey:WEB_SERVICE_STATUS_KEY] intValue] == 1);
    return proposition;
}

@end
