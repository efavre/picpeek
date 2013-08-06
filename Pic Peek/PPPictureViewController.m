//
//  FirstViewController.m
//  Pic Peek
//
//  Created by Eric Perso on 13/05/13.
//  Copyright (c) 2013 ricky. All rights reserved.
//

#import "PPPictureViewController.h"
#import "PPPictureManager.h"
#import "PPPictureService.h"
#import "PPPicture.h"

#define BLACK_SQUARE_SIZE 25

@interface PPPictureViewController ()

@end

@implementation PPPictureViewController

@synthesize pictureImageView, blackSquaresDictionary, labelCategory;

#pragma mark - View life and death

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Peek?", @"Peek?");
        self.tabBarItem.image = [UIImage imageNamed:@"camera"];
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self displayBlackSquares];
    [self configurePicture];
}

-(void)viewDidAppear:(BOOL)animated
{
    [self revealSquares];
}

#pragma mark - Display elements

- (void)configurePicture
{
    [PPPictureService getPictureInfosWithSuccess:^(PPPicture *picture) {
        [self displayCategory:picture];
        [self displayPicture:picture];
        [self revealSquares];
        
    } failure:^(NSError *error) {
        NSLog(@"ERROR : %@", error);
    }];
}

- (void)displayPicture:(PPPicture *)picture
{
    NSLog(@"picture %@", picture.pictureUrl);
    [self.pictureImageView setImageWithURL:[NSURL URLWithString:picture.pictureUrl] placeholderImage:nil];
    
}

- (void)displayCategory:(PPPicture *)picture
{
    self.labelCategory.text = picture.category;
}

- (void)displayBlackSquares
{
    CGRect pictureFrame = self.pictureImageView.frame;
    NSUInteger numberOfSquaresInWidth =  (NSUInteger) pictureFrame.size.width / BLACK_SQUARE_SIZE;
    NSUInteger numberOfSquaresInHeight =  (NSUInteger) pictureFrame.size.height / BLACK_SQUARE_SIZE;
    NSMutableDictionary *blackSquaresMutableDictionary = [NSMutableDictionary dictionary];
    for (int verticalIterator = 0 ; verticalIterator < numberOfSquaresInHeight ; verticalIterator ++ )
    {
        for (int horizontalIterator = 0; horizontalIterator < numberOfSquaresInWidth; horizontalIterator ++)
        {
            CGRect blackSquareFrame = CGRectMake(horizontalIterator * BLACK_SQUARE_SIZE, verticalIterator * BLACK_SQUARE_SIZE, BLACK_SQUARE_SIZE, BLACK_SQUARE_SIZE);
            UIView *blackSquareView = [[UIView alloc] initWithFrame:blackSquareFrame];
            [blackSquareView setBackgroundColor:[UIColor blackColor]];
            [blackSquaresMutableDictionary setObject:blackSquareView forKey:[NSString stringWithFormat:@"%d,%d", horizontalIterator, verticalIterator]];
            [self.pictureImageView addSubview:blackSquareView];
        }
        
    }
    self.blackSquaresDictionary = blackSquaresMutableDictionary;
}

- (void)revealSquares
{
    PPPicture *picture = [[PPPictureManager sharedManager] getCurrentPicture];
    [PPPictureService getPicture:picture squaresWithSuccess:^(NSArray *squaresArray) {
        for (NSDictionary *squareDictionary in squaresArray)
        {
            int abscissa = [[[squareDictionary valueForKey:@"square"] valueForKey:@"abscissa"] intValue];
            int ordinate = [[[squareDictionary valueForKey:@"square"] valueForKey:@"ordinate"] intValue];
            UIView *blackSquareView = [self.blackSquaresDictionary objectForKey:[NSString stringWithFormat:@"%d,%d", abscissa, ordinate]];
            [UIView animateWithDuration:1.0f animations:^{
                [blackSquareView setBackgroundColor:[UIColor clearColor]];
            }];
        }
    } failure:^(NSError *error) {
        NSLog(@"ERROR : %@", error);
    }];

}

@end
