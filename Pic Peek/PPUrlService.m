//
//  PPUrlService.m
//  PicPeek
//
//  Created by Eric Perso on 14/05/13.
//  Copyright (c) 2013 ricky. All rights reserved.
//

#import "PPUrlService.h"
#define ROOT_URL @"http://picpeek.herokuapp.com"
//#define ROOT_URL @"http://localhost:3000"

@implementation PPUrlService

+ (NSString *)baseUrl
{
    return ROOT_URL;
}

+ (NSString *)getPictureUri
{
    return @"/pictures/active";
}

+ (NSString *)postPicturePropositionUri
{
    return @"/pictures/%d/propositions";
}

+ (NSString *)getPictureSquaresUri
{
    return @"/pictures/%d/squares";
}

@end
