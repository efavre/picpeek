//
//  PPHttpClient.m
//  PicPeek
//
//  Created by Eric Perso on 14/05/13.
//  Copyright (c) 2013 ricky. All rights reserved.
//

#import "PPHttpClient.h"
#import "PPUrlService.h"
#import "AFJSONRequestOperation.h"

@implementation PPHttpClient


+ (id)sharedHTTPClient
{
    static dispatch_once_t pred = 0;
    __strong static id __httpClient = nil;
    dispatch_once(&pred, ^{
        __httpClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:[PPUrlService baseUrl]]];
        [__httpClient setParameterEncoding:AFJSONParameterEncoding];
        [__httpClient setDefaultHeader:@"Accept" value:@"application/json"];
        [__httpClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
        [__httpClient setAuthorizationHeaderWithUsername:@"picpeek_wsclient" password:@"tneilcsw_keepcip"];
    });
    return __httpClient;
}

@end
