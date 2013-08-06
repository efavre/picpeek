//
//  PictureService.m
//  Pic Peek
//
//  Created by Eric Perso on 13/05/13.
//  Copyright (c) 2013 ricky. All rights reserved.
//

#import "PPPictureService.h"
#import "PPUrlService.h"
#import "PPHttpClient.h"
#import "PPPicture.h"
#import "AppDelegate.h"

#define WEB_SERVICE_PICTURE_KEY @"picture"
#define WEB_SERVICE_IDENTIFIER_KEY @"id"
#define WEB_SERVICE_CATEGORY_KEY @"category"
#define WEB_SERVICE_PICTURE_URL_KEY @"url"
#define WEB_SERVICE_SQUARES_KEY @"squares"

@implementation PPPictureService

+(void)getPictureInfosWithSuccess:(void (^)(PPPicture * picture))success failure:(void (^)(NSError *error))failure
{
    [[PPHttpClient sharedHTTPClient] getPath:[PPUrlService getPictureUri] parameters:nil success:^(AFHTTPRequestOperation *operation, id jsonObject)
    {
        NSDictionary *pictureDictionary = [jsonObject objectForKey:WEB_SERVICE_PICTURE_KEY];

        PPPicture *picture = [self storeNewPicture:pictureDictionary];
        
        if (success)
        {
            success(picture);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)getPicture:(PPPicture *)picture squaresWithSuccess:(void (^)(NSArray *squaresArray))success
                             failure:(void (^)(NSError *error))failure
{
    NSString *pictureSquaresUri = [NSString stringWithFormat:[PPUrlService getPictureSquaresUri], [picture.webIdentifier intValue]];
    
    [[PPHttpClient sharedHTTPClient] getPath:pictureSquaresUri parameters:nil success:^(AFHTTPRequestOperation *operation, id jsonObject)
     {
         NSArray *squaresArray = [jsonObject objectForKey:WEB_SERVICE_SQUARES_KEY];
                  
         if (success)
         {
             success(squaresArray);
         }
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         if (failure) {
             failure(error);
         }
     }];

}


+(PPPicture *) storeNewPicture:(NSDictionary *)pictureDictionary
{
    [self deletePersistedPicture];
    PPPicture *picture = nil;
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if ([pictureDictionary objectForKey:WEB_SERVICE_IDENTIFIER_KEY])
    {
        picture = (PPPicture *)[NSEntityDescription insertNewObjectForEntityForName:@"PPPicture" inManagedObjectContext:appDelegate.managedObjectContext];
        picture.category = [pictureDictionary objectForKey:WEB_SERVICE_CATEGORY_KEY];
        picture.webIdentifier = [pictureDictionary objectForKey:WEB_SERVICE_IDENTIFIER_KEY];
        picture.pictureUrl = [pictureDictionary objectForKey:WEB_SERVICE_PICTURE_URL_KEY];
        [appDelegate.managedObjectContext save:nil];
    }
    return picture;
}

+(void) deletePersistedPicture
{
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    [request setEntity:[NSEntityDescription entityForName:@"PPPicture" inManagedObjectContext:appDelegate.managedObjectContext]];
    [request setPredicate:[NSPredicate predicateWithFormat:@"webIdentifier != nil"]];
    PPPicture *picture = [[appDelegate.managedObjectContext executeFetchRequest:request error:nil] lastObject];
    if (picture) {
        [appDelegate.managedObjectContext deleteObject:picture];
    }
}

@end
