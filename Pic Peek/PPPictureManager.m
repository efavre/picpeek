//
//  PPPictureManager.m
//  PicPeek
//
//  Created by Eric Perso on 14/05/13.
//  Copyright (c) 2013 ricky. All rights reserved.
//

#import "PPPictureManager.h"
#import "AppDelegate.h"

@implementation PPPictureManager

+ (id)sharedManager
{
    static dispatch_once_t pred = 0;
    __strong static id __manager = nil;
    dispatch_once(&pred, ^{
        __manager = [[self alloc] init];
    });
    return __manager;
}

- (PPPicture *)getCurrentPicture
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    [request setEntity:[NSEntityDescription entityForName:@"PPPicture" inManagedObjectContext:appDelegate.managedObjectContext]];
    [request setPredicate:[NSPredicate predicateWithFormat:@"webIdentifier != nil"]];
    [request setFetchLimit:1];
    PPPicture *picture = [[appDelegate.managedObjectContext executeFetchRequest:request error:nil] lastObject];
    return picture;
}

@end
