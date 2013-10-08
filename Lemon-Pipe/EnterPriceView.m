//
//  EnterPriceView.m
//  Lemon-Pipe
//
//  Created by Bill on 13-10-08.
//  Copyright (c) 2013 Bill. All rights reserved.
//

#import "EnterPriceView.h"

@implementation EnterPriceView
@synthesize confirmButton;
@synthesize priceTextField;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeView];
    }
    return self;
}

- (void) initializeView
{
    UILabel *label = [[UILabel alloc] init];
    label.text = @"Enter the MSRP price here:";
    label.font = [UIFont fontWithName:@"Futura" size:20.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.frame = CGRectMake(20.0, 20.0, 280.0, 20.0);
    [self addSubview:label];
    
    priceTextField = [[UITextField alloc] initWithFrame:CGRectMake(17.0, 64.0, 286.0, 30.0)];
    [priceTextField setPlaceholder:@"$00.00"];
    [priceTextField setTextAlignment:NSTextAlignmentCenter];
    [priceTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [priceTextField setFont:[UIFont fontWithName:@"Helvetica-Bold" size:27.0]];
    [priceTextField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [priceTextField setKeyboardType:UIKeyboardTypeDecimalPad];
    [priceTextField becomeFirstResponder];
    
    [self addSubview:priceTextField];
    
    confirmButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [confirmButton setFrame:CGRectMake(50., 120., 220., 30.)];
    [confirmButton setTitle:@"confirm" forState:UIControlStateNormal];
    [[confirmButton titleLabel] setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18.]];
    [self addSubview:confirmButton];
    
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
