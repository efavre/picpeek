//
//  SecondViewController.h
//  Pic Peek
//
//  Created by Eric Perso on 13/05/13.
//  Copyright (c) 2013 ricky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@interface PPSolutionViewController : UIViewController<UITextFieldDelegate,ADBannerViewDelegate>
{
    bool bannerIsVisible;
}

@property(nonatomic, strong) IBOutlet UITextField *propositionTextField;
@property(nonatomic, strong) IBOutlet UITextField *nicknameTextField;

-(IBAction) submitProposition:(id)sender;
-(IBAction) dismissKeyboard:(id)sender;

@end
