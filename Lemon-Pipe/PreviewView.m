//
//  PreviewView.m
//  Lemon-Pipe
//
//  Created by Bill on 13-10-09.
//  Copyright (c) 2013 Bill. All rights reserved.
//

#import "PreviewView.h"

@implementation PreviewView
@synthesize discountLabel;
@synthesize discountPriceLabel;
@synthesize durationLabel;
@synthesize productImageView;
@synthesize msrpLabel;
@synthesize redoButton;
@synthesize postButton;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self initializeView];
    }
    return self;
}

- (void)initializeView
{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(44, 26, 233, 21)];
    [titleLabel setText:@"Promotion preview"];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setFont:[UIFont fontWithName:@"Arial" size:22]];
    [self addSubview:titleLabel];
    
    discountLabel = [[UILabel alloc] initWithFrame:CGRectMake(14, 132, 51, 72)];
    [discountLabel setText:@"00"];
    [discountLabel setTextAlignment:NSTextAlignmentRight];
    [discountLabel setFont:[UIFont fontWithName:@"Arial" size:45]];
    [self addSubview:discountLabel];
    
    UILabel *percentLabel = [[UILabel alloc] initWithFrame:CGRectMake(72, 147, 16, 21)];
    [percentLabel setText:@"%"];
    [percentLabel setFont:[UIFont fontWithName:@"Arial" size:17]];
    [self addSubview:percentLabel];
    
    UILabel *offLabel = [[UILabel alloc] initWithFrame:CGRectMake(71, 166, 19, 21)];
    [offLabel setText:@"off"];
    [offLabel setFont:[UIFont fontWithName:@"Arial" size:17]];
    [self addSubview:offLabel];
    
    productImageView = [[UIImageView alloc] initWithFrame:CGRectMake(98, 105, 125, 125)];
    [self addSubview:productImageView];
    
    durationLabel = [[UILabel alloc] initWithFrame:CGRectMake(225, 132, 51, 72)];
    [durationLabel setText:@"00"];
    [durationLabel setTextAlignment:NSTextAlignmentRight];
    [durationLabel setFont:[UIFont fontWithName:@"Arial" size:45]];
    [self addSubview:durationLabel];
    
    UILabel *daysLabel = [[UILabel alloc] initWithFrame:CGRectMake(279, 147, 36, 21)];
    [daysLabel setText:@"days"];
    [daysLabel setFont:[UIFont fontWithName:@"Arial" size:17]];
    [self addSubview:daysLabel];
    
    UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(286, 166, 23, 21)];
    [leftLabel setText:@"left"];
    [leftLabel setFont:[UIFont fontWithName:@"Arial" size:17]];
    [self addSubview:leftLabel];
    

    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(91, 274, 75, 21)];
    [label1 setText:@"MSRP ="];
    [label1 setFont:[UIFont fontWithName:@"Arial" size:17]];
    [label1 setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:label1];
    
    msrpLabel = [[UILabel alloc] initWithFrame:CGRectMake(169, 274, 70, 21)];
    [msrpLabel setText:@"$00.00"];
    [msrpLabel setTextAlignment:NSTextAlignmentLeft];
    [msrpLabel setFont:[UIFont fontWithName:@"Arial" size:17]];
    [self addSubview:msrpLabel];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(65, 303, 123, 21)];
    [label2 setText:@"discount price ="];
    [label2 setTextAlignment:NSTextAlignmentCenter];
    [label2 setFont:[UIFont fontWithName:@"Arial" size:17]];
    [self addSubview:label2];
    
    discountPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(196, 303, 70, 21)];
    [discountPriceLabel setText:@"$00.00"];
    [discountPriceLabel setTextAlignment:NSTextAlignmentLeft];
    [discountPriceLabel setFont:[UIFont fontWithName:@"Arial" size:17]];
    [self addSubview:discountPriceLabel];
    
    redoButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [redoButton setTitle:@"redo" forState:UIControlStateNormal];
    [redoButton setFrame:CGRectMake(44, 349, 93, 44)];
    [self addSubview:redoButton];
    
    postButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [postButton setTitle:@"post!" forState:UIControlStateNormal];
    [postButton setFrame:CGRectMake(184, 349, 93, 44)];
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
