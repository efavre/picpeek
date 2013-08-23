//
//  SecondViewController.m
//  Pic Peek
//
//  Created by Eric Perso on 13/05/13.
//  Copyright (c) 2013 ricky. All rights reserved.
//

#import "PPSolutionViewController.h"
#import "PPPropositionService.h"

@interface PPSolutionViewController ()

@end

@implementation PPSolutionViewController

@synthesize propositionTextField, nicknameTextField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        bannerIsVisible = NO;
        self.title = NSLocalizedString(@"Pic!", @"Pic!");
        self.tabBarItem.image = [UIImage imageNamed:@"lightbulb"];
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.propositionTextField.delegate = self;
    self.nicknameTextField.delegate = self;
}

#pragma mark - User Actions

-(void) submitProposition:(id)sender
{
    [PPPropositionService submitProposition:self.propositionTextField.text byNickname:self.nicknameTextField.text withSuccess:^(PPProposition *proposition) {
        if (proposition.status) {
            [[[UIAlertView alloc]initWithTitle:@"Bravo" message:proposition.message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
        }
        else
        {
            [[[UIAlertView alloc]initWithTitle:@"Et non" message:proposition.message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
        }
        [self dismissKeyboard:nil];
    } failure:^(NSHTTPURLResponse *response, NSError *error) {
        [self dismissKeyboard:nil];
    }];
}

-(void)dismissKeyboard:(id)sender
{
    [self.propositionTextField resignFirstResponder];
    [self.nicknameTextField resignFirstResponder];
}

#pragma mark UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == propositionTextField)
    {
        [nicknameTextField becomeFirstResponder];
    }
    else if (textField == nicknameTextField)
    {
        [self submitProposition:nil];
    }
    return YES;
}

/**************************************************************************************************/
#pragma mark - AdBannerViewDelegate
- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    if (!bannerIsVisible)
    {
		NSLog(@"bannerViewDidLoadAd");
        [UIView animateWithDuration:0.5 animations:^{
            banner.frame = CGRectOffset(banner.frame, 0, -50);
        }];
        bannerIsVisible = YES;
    }
}
- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
	if (bannerIsVisible)
	{
		NSLog(@"bannerView:didFailToReceiveAdWithError:");
        [UIView animateWithDuration:0.5 animations:^{
            banner.frame = CGRectOffset(banner.frame, 0, 50);
        }];
		bannerIsVisible = NO;
	}
    
}


@end
