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
@synthesize pickerView;
@synthesize priceLabel;
@synthesize choices;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setUserInteractionEnabled:TRUE];
        [self initializeView];
    }
    return self;
}

- (void) initializeView
{
    UILabel *priceTitlelabel = [[UILabel alloc] init];
    priceTitlelabel.text = @"Enter the MSRP:";
    priceTitlelabel.font = [UIFont fontWithName:@"Futura-Medium" size:22.0];
    priceTitlelabel.textAlignment = NSTextAlignmentCenter;
    priceTitlelabel.frame = CGRectMake(20.0, 20.0, 280.0, 30.0);
    [self addSubview: priceTitlelabel];
    
    priceTextField = [[UITextField alloc] initWithFrame:CGRectMake(0.0, 57.0, 320.0, 48.0)];
    [priceTextField setPlaceholder:@"Tap here to enter"];
    [priceTextField setTextAlignment:NSTextAlignmentCenter];
    [priceTextField setBorderStyle:UITextBorderStyleBezel];
    [priceTextField setFont:[UIFont fontWithName:@"Helvetica" size:24.0]];
    [priceTextField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [priceTextField setKeyboardType:UIKeyboardTypeDecimalPad];
    
    [priceTextField addTarget:self action:@selector(editingPrice:) forControlEvents:UIControlEventEditingChanged];
    [priceTextField addTarget:self action:@selector(doneEditongPrice:) forControlEvents:UIControlEventEditingDidEnd];
    
    [self addSubview:priceTextField];

    
    UILabel *discountTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 135, 280, 21)];
    [discountTitleLabel setTextAlignment:NSTextAlignmentCenter];
    [discountTitleLabel setFont:[UIFont fontWithName:@"Arial" size:20]];
    [discountTitleLabel setText:@"Choose a discount"];
    [self addSubview:discountTitleLabel];
    
    
    pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 100, 1000)];
    pickerView.showsSelectionIndicator = true;
    pickerView.delegate = self;
    pickerView.dataSource = self;
    
    CGAffineTransform rotate = CGAffineTransformMakeRotation(-3.14/2);
    rotate = CGAffineTransformScale(rotate, 1.0, 1.5);
    
    [self.pickerView setTransform:rotate];
    [self.pickerView setCenter:CGPointMake(160, 214)];
    CGAffineTransform rotateItem = CGAffineTransformMakeRotation(3.14/2);
    rotateItem = CGAffineTransformScale(rotateItem, 0.7, 1.0);
    choices = [[NSMutableArray alloc] initWithCapacity:20];
    
    for (int i=7;i<=20;i++) {
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
    
    UIView *priceSubview = [[UIView alloc] initWithFrame:CGRectMake(0, 287, 320, 50)];
    [priceSubview setBackgroundColor:[UIColor colorWithWhite:0.9 alpha:1.0]];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(60, 14, 138, 21)];
    [label setText:@"Discounted price:"];
    [label setFont:[UIFont fontWithName:@"System" size:17]];
    [label setBackgroundColor:[UIColor clearColor]];
    [priceSubview addSubview:label];
    
    priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(197, 14, 52, 21)];
    [priceLabel setText:@"$00.00"];
    [priceLabel setFont:[UIFont fontWithName:@"System" size:17]];
    [priceLabel setBackgroundColor:[UIColor clearColor]];
    [priceSubview addSubview:priceLabel];
    
    [self addSubview:priceSubview];
    
    confirmButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [confirmButton setFrame:CGRectMake(50., 360., 220., 30.)];
    [confirmButton setTitle:@"confirm" forState:UIControlStateNormal];
    [[confirmButton titleLabel] setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18.]];
    [self addSubview:confirmButton];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if (touch.phase == UITouchPhaseBegan)
        [self.priceTextField resignFirstResponder];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)editingPrice: (id)sender
{
#warning add $ here
//    if ([priceTextField.text characterAtIndex:0]!='$') {
//        NSString *price = [NSString stringWithFormat:@"$%@", [priceTextField text]];
//        [priceTextField setText:price];
//    }
}

- (void)doneEditongPrice: (id)sender
{
    float price = [priceTextField.text floatValue];
    priceTextField.text = [NSString stringWithFormat:@"%.2f", price];
    
    [self setPrice];
}

- (void) setPrice
{
#warning change after adding $
    float price = [[priceTextField text] floatValue];
    price = price * (1 -([pickerView selectedRowInComponent:0]+7) * 0.05);
    priceLabel.text = [NSString stringWithFormat:@"$%.2f", price];
    
}


#pragma mark - UIPickerView Delegate

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    return [[self choices] objectAtIndex:row];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [[self choices] count];
}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [self setPrice];
}


@end
