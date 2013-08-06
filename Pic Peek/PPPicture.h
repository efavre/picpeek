//
//  Picture.h
//  PicPeek
//
//  Created by Eric Perso on 14/05/13.
//  Copyright (c) 2013 ricky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface PPPicture : NSManagedObject

@property (nonatomic, retain) NSNumber * webIdentifier;
@property (nonatomic, retain) NSString * category;
@property (nonatomic, retain) NSString * pictureUrl;

@end
