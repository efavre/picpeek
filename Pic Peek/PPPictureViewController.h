//
//  FirstViewController.h
//  Pic Peek
//
//  Created by Eric Perso on 13/05/13.
//  Copyright (c) 2013 ricky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@interface PPPictureViewController : UIViewController <ADBannerViewDelegate>
{
    bool bannerIsVisible;
}

@property (nonatomic, strong) IBOutlet UIImageView *pictureImageView;
@property (nonatomic, strong) IBOutlet UILabel *labelCategory;
@property (nonatomic, strong) NSDictionary *blackSquaresDictionary;

@end
