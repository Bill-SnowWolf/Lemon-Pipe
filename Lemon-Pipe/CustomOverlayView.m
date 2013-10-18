//
//  CustomOverlayView.m
//  Lemon-Pipe
//
//  Created by Bill on 13-10-15.
//  Copyright (c) 2013 Bill. All rights reserved.
//

#import "CustomOverlayView.h"
#import "CustomNavigationBar.h"

@implementation CustomOverlayView

@synthesize takePhotoButton;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initializeView];
    }
    return self;
}


- (void)initializeView
{
    CustomNavigationBar *navBar = [[CustomNavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    
    UINavigationItem *titleItem = [[UINavigationItem alloc] initWithTitle:@"Take Photo"];
    [navBar setItems:[NSArray arrayWithObject:titleItem]];
    
    [self addSubview:navBar];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"ButtonBackground" ofType:@"png"];
    UIImage *buttonBackground = [[UIImage imageWithContentsOfFile:filePath] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 20, 20, 20)];

    filePath = [[NSBundle mainBundle] pathForResource:@"ButtonBackgroundHighlighted" ofType:@"png"];
    UIImage *buttonBackgroundHighlighted = [[UIImage imageWithContentsOfFile:filePath] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 20, 20, 20)];
    
    filePath = [[NSBundle mainBundle] pathForResource:@"CameraIcon-White" ofType:@"png"];
    UIImage *cameraIcon = [UIImage imageWithContentsOfFile:filePath];
    
    takePhotoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [takePhotoButton setBackgroundImage:buttonBackground forState:UIControlStateNormal];
    [takePhotoButton setBackgroundImage:buttonBackgroundHighlighted forState:UIControlStateHighlighted];
    [takePhotoButton setImage:cameraIcon forState:UIControlStateNormal];
    [takePhotoButton setFrame:CGRectMake(110, 390, 100, 40)];

    
    CGRect f = self.frame;
    //    f.size.height -= 44;
    
    //    CGFloat barHeight = (f.size.height - f.size.width) / 2;
    
    UIGraphicsBeginImageContext(f.size);
    
    CGContextRef myContext =UIGraphicsGetCurrentContext();
//    CGContextSetRGBFillColor(myContext, 0.3, 0.3, 0.3, 1);
    [[UIColor colorWithWhite:0.3 alpha:0.8] set];
    UIRectFillUsingBlendMode(CGRectMake(0, 44, 320, 16), kCGBlendModeLuminosity);
    UIRectFillUsingBlendMode(CGRectMake(0, 60, 10, 300), kCGBlendModeLuminosity);
    UIRectFillUsingBlendMode(CGRectMake(310, 60, 10, 300), kCGBlendModeLuminosity);
    UIRectFillUsingBlendMode(CGRectMake(0, 360, 320, 110), kCGBlendModeLuminosity);

    //    UIRectFillUsingBlendMode(CGRectMake(0, f.size.height - barHeight, f.size.width, barHeight), kCGBlendModeNormal);

    
//    CGContextFillRect(myContext, CGRectMake(0, 44, 320, 16));
//    CGContextFillRect(myContext, CGRectMake(0, 60, 10, 300));
//    CGContextFillRect(myContext, CGRectMake(310, 60, 10, 300));
//    CGContextFillRect(myContext, CGRectMake(0, 360, 320, 110));
    
    CGContextBeginPath(myContext);
    CGContextMoveToPoint(myContext, 11, 61);
    CGContextAddLineToPoint(myContext, 309, 61);
    CGContextAddLineToPoint(myContext, 309, 359);
    CGContextAddLineToPoint(myContext, 11, 359);
    CGContextAddLineToPoint(myContext, 11, 61);
    
    CGContextSetLineCap(myContext, kCGLineCapRound);
    CGContextSetLineJoin(myContext, kCGLineJoinRound);
    
    CGContextSetRGBStrokeColor(myContext, 0, 0, 0, 1);
    CGContextSetLineWidth(myContext, 4);
    float dashLength[] = {10,10};
    CGContextSetLineDash(myContext, 0, dashLength, 2);
    CGContextStrokePath(myContext);
    
    UIImage *overlayImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *overlayIV = [[UIImageView alloc] initWithFrame:f];
    overlayIV.image = overlayImage;
    [self addSubview:overlayIV];
    
 
    [self addSubview:takePhotoButton];
    
 
}

@end
