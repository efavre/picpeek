//
//  PPPropositionService.m
//  PicPeek
//
//  Created by Eric Perso on 14/05/13.
//  Copyright (c) 2013 ricky. All rights reserved.
//

#import "PPPropositionService.h"
#import "PPUserService.h"
#import "PPUrlService.h"
#import "PPHttpClient.h"
#import "PPPicture.h"
#import "PPPictureManager.h"

#define WEB_SERVICE_PROPOSITION_KEY @"proposition"
#define WEB_SERVICE_MESSAGE_KEY @"message"

@implementation PPPropositionService

+ (void)submitProposition:(NSString *)proposition byNickname:(NSString *)nickname withSuccess:(void (^)(PPProposition *proposition))success failure:(void (^)(NSHTTPURLResponse *, NSError *))failure
{
    NSDictionary *propositionAttributes = [NSDictionary dictionaryWithObjectsAndKeys:nickname, @"nickname", proposition, @"proposition", [PPUserService getAppUuid], @"app_uuid", nil];
    NSDictionary *parameters = [NSDictionary dictionaryWithObject:propositionAttributes forKey:@"proposition"];
    
    PPPicture *picture = [[PPPictureManager sharedManager] getCurrentPicture];
    NSString *uri = [NSString stringWithFormat:[PPUrlService postPicturePropositionUri], [picture.webIdentifier intValue]];
    
    [[PPHttpClient sharedHTTPClient] postPath:uri parameters:parameters success:^(AFHTTPRequestOperation *operation, id jsonObject) {
        NSDictionary *propositionDictionary = [jsonObject objectForKey:WEB_SERVICE_PROPOSITION_KEY];
        PPProposition *proposition = [PPProposition propositionWithDictionary:propositionDictionary];
        if (success)
        {
            success(proposition);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error : %@", error);
    }];
    
}
@end
