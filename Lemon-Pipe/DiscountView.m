//
//  DiscountView.m
//  Lemon-Pipe
//
//  Created by Bill on 13-10-08.
//  Copyright (c) 2013 Bill. All rights reserved.
//

#import "DiscountView.h"

@implementation DiscountView
{
    NSMutableArray *discountArray;
}
@synthesize pickerView;
@synthesize choices;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor whiteColor]];
        [self initializeView];
    }
    return self;
}

- (void) initializeView
{
    pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 100, 100, 1000)];
    pickerView.showsSelectionIndicator = true;
    
    CGAffineTransform rotate = CGAffineTransformMakeRotation(-3.14/2);
    rotate = CGAffineTransformScale(rotate, 1.0, 1.5);
    
    [self.pickerView setTransform:rotate];
    [self.pickerView setCenter:CGPointMake(160, 100)];
    CGAffineTransform rotateItem = CGAffineTransformMakeRotation(3.14/2);
    rotateItem = CGAffineTransformScale(rotateItem, 0.7, 1.0);
    choices = [[NSMutableArray alloc] initWithCapacity:20];
    
    for (int i=0;i<19;i++) {
        UILabel *choiceLabel;
        choiceLabel = [[UILabel alloc] init];
        choiceLabel.text = [NSString stringWithFormat:@"%d%%", 5*i];
        choiceLabel.textColor = [UIColor blackColor];
        choiceLabel.frame = CGRectMake(0, 0, 100, 100);
        choiceLabel.backgroundColor = [UIColor clearColor];
        choiceLabel.textAlignment = NSTextAlignmentCenter;
        choiceLabel.shadowColor = [UIColor whiteColor];
        choiceLabel.shadowOffset = CGSizeMake(-1, -1);
        choiceLabel.adjustsFontSizeToFitWidth = YES;
        choiceLabel.font = [UIFont fontWithName:@"Georgia" size:25];
        choiceLabel.transform = rotateItem;
        [choices addObject:choiceLabel];
    }
    
    
    [self addSubview:pickerView];
    
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
