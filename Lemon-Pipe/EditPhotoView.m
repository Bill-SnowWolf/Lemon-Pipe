//
//  EditPhotoView.m
//  Lemon-Pipe
//
//  Created by Bill on 13-10-16.
//  Copyright (c) 2013 Bill. All rights reserved.
//

#import "EditPhotoView.h"

@implementation EditPhotoView
@synthesize imageView;
@synthesize retakeButton;
@synthesize useButton;

- (id)initWithFrame:(CGRect)frame image:(UIImage *)image
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor colorWithRed:0.129 green:0.278 blue:0.384 alpha:1.0]];
        [self initializeViewWithImage: image];
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)initializeViewWithImage:(UIImage *)image
{
    UIView *subview = [[UIView alloc] initWithFrame:CGRectMake(5, 5, 310, 345)];
    [subview setBackgroundColor:[UIColor whiteColor]];
    
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 300, 300)];
    [imageView setImage:image];
    [subview addSubview:imageView];
    [self addSubview:subview];
    
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"ButtonBackground" ofType:@"png"];
    UIImage *buttonBackground = [[UIImage imageWithContentsOfFile:filePath] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 20, 20, 20)];
    
    filePath = [[NSBundle mainBundle] pathForResource:@"ButtonBackgroundHighlighted" ofType:@"png"];
    UIImage *buttonBackgroundHighlighted = [[UIImage imageWithContentsOfFile:filePath] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 20, 20, 20)];

    
    retakeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [retakeButton setFrame:CGRectMake(40, 360, 100, 40)];
    [retakeButton setTitle:@"Retake" forState:UIControlStateNormal];
    [retakeButton setBackgroundImage:buttonBackground forState:UIControlStateNormal];
    [retakeButton setBackgroundImage:buttonBackgroundHighlighted forState:UIControlStateHighlighted];
    [retakeButton.titleLabel setFont:[UIFont fontWithName:@"MarkoOne-Regular" size:20]];
    [self addSubview:retakeButton];
    
    useButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [useButton setBackgroundImage:buttonBackground forState:UIControlStateNormal];
    [useButton setFrame:CGRectMake(180, 360, 100, 40)];
    [useButton.titleLabel setFont:[UIFont fontWithName:@"MarkoOne-Regular" size:20]];
    [useButton setTitle:@"Use" forState:UIControlStateNormal];
    [useButton setBackgroundImage:buttonBackgroundHighlighted forState:UIControlStateHighlighted];
    [self addSubview:useButton];
    
}

@end
