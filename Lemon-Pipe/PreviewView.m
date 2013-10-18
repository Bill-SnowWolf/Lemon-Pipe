//
//  PreviewView.m
//  Lemon-Pipe
//
//  Created by Bill on 13-10-09.
//  Copyright (c) 2013 Bill. All rights reserved.
//

#import "PreviewView.h"
#import "GradientView.h"
#import <QuartzCore/CAShapeLayer.h>

@implementation PreviewView
@synthesize discountLabel;
@synthesize discountPriceLabel;
@synthesize durationLabel;
@synthesize productImageView;
@synthesize msrpLabel;
@synthesize redoButton;
@synthesize postButton;

- (id)initWithFrame:(CGRect)frame discount:(NSInteger) discount msrp:(float)msrp productImage:(UIImage *)productImage promotionDays:(NSInteger)days promotionHours:(NSInteger)hours
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor colorWithRed:0.129 green:0.282 blue:0.384 alpha:1.0]];
        [self initializeViewWithDiscount:discount msrp:msrp productImage:productImage promotionDays:days promotionHours:hours];
    }
    return self;
}

- (void)initializeViewWithDiscount: (NSInteger)discount msrp:(float)msrp productImage:(UIImage *)productImage promotionDays:(NSInteger)days promotionHours:(NSInteger)hours
{
    NSString *filePath;
    
    UIView *previewContainer = [[UIView alloc] initWithFrame:CGRectMake(5, 3, 310, 362)];
    [previewContainer setBackgroundColor:[UIColor whiteColor]];
    
    GradientView * topRowView = [[GradientView alloc] initWithFrame:CGRectMake(5, 3, 300, 50)];
    [topRowView useDefaultColors];
    
    discountLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 1, 89, 50)];
    [discountLabel setText:[NSString stringWithFormat:@"%d", discount]];
    [discountLabel setBackgroundColor:[UIColor clearColor]];
    [discountLabel setTextAlignment:NSTextAlignmentCenter];
    [discountLabel setTextColor:[UIColor whiteColor]];
    [discountLabel setFont:[UIFont fontWithName:@"PlantagenetCherokee" size:60]];
    [discountLabel setShadowOffset:CGSizeMake(2, 2)];
    [discountLabel setShadowColor:[UIColor blackColor]];
    
    CGAffineTransform transform = discountLabel.transform;
    transform = CGAffineTransformScale(transform, 1.5, 1.0);
    [discountLabel setTransform:transform];
    
    [topRowView addSubview:discountLabel];
    
    filePath = [[NSBundle mainBundle] pathForResource:@"PercentOff" ofType:@"png"];
    UIImageView *percentOffView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:filePath]];
    [percentOffView setFrame:CGRectMake(106, 2, 100, 46)];
    [topRowView addSubview:percentOffView];
    
    msrpLabel = [[UILabel alloc] initWithFrame:CGRectMake(215, 3, 75, 21)];
    [msrpLabel setText:[NSString stringWithFormat:@"$%.2f", msrp]];
    [msrpLabel setFont:[UIFont fontWithName:@"Ubuntu-Medium" size:20]];
    [msrpLabel setBackgroundColor:[UIColor clearColor]];
    [msrpLabel setTextAlignment:NSTextAlignmentCenter];
    
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.frame = msrpLabel.bounds;
    lineLayer.strokeColor = [UIColor redColor].CGColor;
    lineLayer.lineWidth = 2.0f;
    lineLayer.lineCap = kCALineCapRound;
    
    CGMutablePathRef pathRef = CGPathCreateMutable();
    float xOffset = 5;

    if (msrp<10)
        xOffset = 20;
    else if (msrp<100)
        xOffset = 15;
    else if (msrp<1000)
        xOffset = 10;
    CGPathMoveToPoint(pathRef, NULL, xOffset, CGRectGetMidY(lineLayer.bounds)+2);
    CGPathAddLineToPoint(pathRef, NULL, lineLayer.bounds.size.width-xOffset, CGRectGetMidY(lineLayer.bounds)-4);

    [lineLayer setPath:pathRef];
    CGPathRelease(pathRef);
    
    [msrpLabel.layer addSublayer:lineLayer];
    [topRowView addSubview:msrpLabel];
    
    discountPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(210, 25, 90, 21)];
    [discountPriceLabel setText:[NSString stringWithFormat:@"$%.2f", msrp*discount/100.0]];
    [discountPriceLabel setTextAlignment:NSTextAlignmentCenter];
    [discountPriceLabel setFont:[UIFont fontWithName:@"Ubuntu-Bold" size:24]];
    [discountPriceLabel setBackgroundColor:[UIColor clearColor]];
    [topRowView addSubview:discountPriceLabel];
    
    [previewContainer addSubview:topRowView];
    
    productImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 53, 300, 260)];
    [productImageView setImage:productImage];
    [previewContainer addSubview:productImageView];
    
    GradientView *bottomRowView = [[GradientView alloc] initWithFrame:CGRectMake(5, 313, 300, 45)];
    [bottomRowView useDefaultColors];
    
    UILabel *expireTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(7, 1, 80, 21)];
    [expireTitleLabel setText:@"Expires in:"];
    [expireTitleLabel setBackgroundColor:[UIColor clearColor]];
    [expireTitleLabel setFont:[UIFont fontWithName:@"BerlinSansFB-Reg" size:15]];
    [bottomRowView addSubview:expireTitleLabel];
    
    filePath = [[NSBundle mainBundle] pathForResource:@"TimerBackground" ofType:@"png"];
    UIImage *timerBackground = [UIImage imageWithContentsOfFile:filePath];
    UIImageView *timerBackgroundView = [[UIImageView alloc] initWithImage:timerBackground];
    [timerBackgroundView setFrame:CGRectMake(7, 20, 127, 24)];
    [bottomRowView addSubview:timerBackgroundView];
    
    
    UILabel *daysLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 22, 23, 21)];
    [daysLabel setBackgroundColor:[UIColor clearColor]];
    [daysLabel setTextAlignment:NSTextAlignmentCenter];
    [daysLabel setFont:[UIFont fontWithName:@"BerlinSansFB-Reg" size:11]];
    
    NSMutableString *daysStr = [[NSMutableString alloc] initWithCapacity:5];
    if (days<10)
        [daysStr appendString:@"0"];
    [daysStr appendFormat:@"%dd", days];
    [daysLabel setText:daysStr];
    [bottomRowView addSubview:daysLabel];
    
    UILabel *hoursLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(43.5, 22, 12, 21)];
    [hoursLabel1 setBackgroundColor:[UIColor clearColor]];
    [hoursLabel1 setTextAlignment:NSTextAlignmentCenter];
    [hoursLabel1 setFont:[UIFont fontWithName:@"BerlinSansFB-Reg" size:11]];
    [bottomRowView addSubview:hoursLabel1];
    
    UILabel *hoursLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(56.5, 22, 12, 21)];
    [hoursLabel2 setBackgroundColor:[UIColor clearColor]];
    [hoursLabel2 setFont:[UIFont fontWithName:@"BerlinSansFB-Reg" size:11]];
    [hoursLabel2 setTextAlignment:NSTextAlignmentCenter];
    [bottomRowView addSubview:hoursLabel2];
    
    if (hours<10)
        [hoursLabel1 setText:@"0"];
    else
        [hoursLabel1 setText:[NSString stringWithFormat:@"%d", (hours/10)]];

    [hoursLabel2 setText:[NSString stringWithFormat:@"%d", hours/10]];
    
    UILabel *minutesLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(73.5, 22, 12, 21)];
    [minutesLabel1 setBackgroundColor:[UIColor clearColor]];
    [minutesLabel1 setTextAlignment:NSTextAlignmentCenter];
    [minutesLabel1 setText:@"0"];
    [minutesLabel1 setFont:[UIFont fontWithName:@"BerlinSansFB-Reg" size:11]];
    [bottomRowView addSubview:minutesLabel1];
    
    UILabel *minutesLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(87.5, 22, 12, 21)];
    [minutesLabel2 setTextAlignment:NSTextAlignmentCenter];
    [minutesLabel2 setBackgroundColor:[UIColor clearColor]];
    [minutesLabel2 setText:@"0"];
    [minutesLabel2 setFont:[UIFont fontWithName:@"BerlinSansFB-Reg" size:11]];
    [bottomRowView addSubview:minutesLabel2];
    
    UILabel *secondsLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(104.5, 22, 12, 21)];
    [secondsLabel1 setTextAlignment:NSTextAlignmentCenter];
    [secondsLabel1 setBackgroundColor:[UIColor clearColor]];
    [secondsLabel1 setText:@"0"];
    [secondsLabel1 setFont:[UIFont fontWithName:@"BerlinSansFB-Reg" size:11]];
    [bottomRowView addSubview:secondsLabel1];
    
    UILabel *secondsLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(118.25, 22, 12, 21)];
    [secondsLabel2 setTextAlignment:NSTextAlignmentCenter];
    [secondsLabel2 setBackgroundColor:[UIColor clearColor]];
    [secondsLabel2 setText:@"0"];
    [secondsLabel2 setFont:[UIFont fontWithName:@"BerlinSansFB-Reg" size:11]];
    [bottomRowView addSubview:secondsLabel2];
    
    
    filePath = [[NSBundle mainBundle] pathForResource:@"Stock" ofType:@"png"];
    UIImage *stockImage = [UIImage imageWithContentsOfFile:filePath];
    UIImageView *stockImageView = [[UIImageView alloc] initWithFrame:CGRectMake(144, 3, 36, 24)];
    [stockImageView setImage:stockImage];
    [bottomRowView addSubview:stockImageView];
    
    UILabel *itemsLeftLabel = [[UILabel alloc] initWithFrame:CGRectMake(181, 5, 29, 24)];
    [itemsLeftLabel setText:@"10"];
    [itemsLeftLabel setBackgroundColor:[UIColor clearColor]];
    [itemsLeftLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:24]];
    [bottomRowView addSubview:itemsLeftLabel];
    
    
    UILabel *itemsLeftTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(138, 24, 71, 21)];
    [itemsLeftTitleLabel setText:@"items left"];
    [itemsLeftTitleLabel setBackgroundColor:[UIColor clearColor]];
    [itemsLeftTitleLabel setTextAlignment:NSTextAlignmentCenter];
    [itemsLeftTitleLabel setFont:[UIFont fontWithName:@"BerlinSansFB-Reg" size:14]];
    [bottomRowView addSubview:itemsLeftTitleLabel];
    
    
    filePath = [[NSBundle mainBundle] pathForResource:@"BuyButton" ofType:@"png"];
    UIImage *buyButtonBackground = [UIImage imageWithContentsOfFile:filePath];
    
    UIButton *buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [buyButton setBackgroundImage:buyButtonBackground forState:UIControlStateNormal];
    [buyButton setUserInteractionEnabled:NO];
    [buyButton setFrame:CGRectMake(215, -1, 85, 46)];
    [buyButton setTitle:@"Buy" forState:UIControlStateNormal];
    [buyButton.titleLabel setFont:[UIFont fontWithName:@"BerlinSansFBDemi-Bold" size:28]];
    [buyButton.titleLabel setTextColor:[UIColor blackColor]];
    [bottomRowView addSubview:buyButton];
    
    
    
    
    
    

    
    
    [previewContainer addSubview:bottomRowView];
    
    [self addSubview:previewContainer];
    
    filePath = [[NSBundle mainBundle] pathForResource:@"ButtonBackground" ofType:@"png"];
    UIImage *buttonBackground = [[UIImage imageWithContentsOfFile:filePath] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 20, 20, 20)];
    
    filePath = [[NSBundle mainBundle] pathForResource:@"ButtonBackgroundHighlighted" ofType:@"png"];
    UIImage *buttonBackgroundHighlighted = [[UIImage imageWithContentsOfFile:filePath] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 20, 20, 20)];
    
    
    redoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [redoButton setBackgroundImage:buttonBackground forState:UIControlStateNormal];
    [redoButton setBackgroundImage:buttonBackgroundHighlighted forState:UIControlStateHighlighted];
    [redoButton setTitle:@"Redo" forState:UIControlStateNormal];
    [redoButton.titleLabel setFont:[UIFont fontWithName:@"MarkoOne-Regular" size:20]];
    [redoButton setFrame:CGRectMake(25, 370, 120, 40)];
    [self addSubview:redoButton];
    
    postButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [postButton setTitle:@"Post" forState:UIControlStateNormal];
    [postButton setBackgroundImage:buttonBackground forState:UIControlStateNormal];
    [postButton setBackgroundImage:buttonBackgroundHighlighted forState:UIControlStateHighlighted];
    [postButton setFrame:CGRectMake(175, 370, 120, 40)];
    [postButton.titleLabel setFont:[UIFont fontWithName:@"MarkoOne-Regular" size:20]];
    [self addSubview:postButton];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
