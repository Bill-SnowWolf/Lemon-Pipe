//
//  EnterPriceView.m
//  Lemon-Pipe
//
//  Created by Bill on 13-10-08.
//  Copyright (c) 2013 Bill. All rights reserved.
//

#import "EnterPriceView.h"
#import "GradientView.h"

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
        [self setBackgroundColor:[UIColor colorWithRed:0.129 green:0.282 blue:0.384 alpha:1.0]];
        [self setUserInteractionEnabled:TRUE];
        [self initializeView];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef myContext = UIGraphicsGetCurrentContext();
    
    CGContextBeginPath(myContext);
    CGContextMoveToPoint(myContext, 3, 16);
    CGContextAddLineToPoint(myContext, 317, 16);
    CGContextMoveToPoint(myContext, 3, 135);
    CGContextAddLineToPoint(myContext, 317, 135);
    CGContextMoveToPoint(myContext, 3, 280);
    CGContextAddLineToPoint(myContext, 317, 280);
    CGContextSetRGBStrokeColor(myContext, 1, 1, 1, 1);
    CGContextStrokePath(myContext);
    
    CGContextMoveToPoint(myContext, 3, 126);
    CGContextAddLineToPoint(myContext, 317, 126);
    CGContextMoveToPoint(myContext, 3, 270);
    CGContextAddLineToPoint(myContext, 317, 270);
    CGContextMoveToPoint(myContext, 3, 350);
    CGContextAddLineToPoint(myContext, 317, 350);
    CGContextSetRGBStrokeColor(myContext, 0, 0, 0, 1);
    CGContextStrokePath(myContext);
}

- (void) initializeView
{
    GradientView *subview1 = [[GradientView alloc] initWithFrame:CGRectMake(3, 16, 314, 110)];
    [subview1 useDefaultColors];
    
    
    
    
    UILabel *priceTitlelabel = [[UILabel alloc] init];
    priceTitlelabel.text = @"Enter the MSRP:";
    priceTitlelabel.font = [UIFont fontWithName:@"Ubuntu-Medium" size:24.0];
    priceTitlelabel.textAlignment = NSTextAlignmentCenter;
    priceTitlelabel.backgroundColor = [UIColor clearColor];
    priceTitlelabel.frame = CGRectMake(17.0, 12.0, 280.0, 24.0);
    [subview1 addSubview: priceTitlelabel];
    
    priceTextField = [[UITextField alloc] initWithFrame:CGRectMake(7.0, 48.0, 300.0, 50.0)];
    [priceTextField setPlaceholder:@"Tap here to enter"];
    [priceTextField setTextAlignment:NSTextAlignmentCenter];
    [priceTextField setBorderStyle:UITextBorderStyleBezel];
    [priceTextField setFont:[UIFont fontWithName:@"Ubuntu" size:24.0]];
    [priceTextField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [priceTextField setKeyboardType:UIKeyboardTypeDecimalPad];
    [priceTextField setBackgroundColor:[UIColor whiteColor]];
    
    [priceTextField addTarget:self action:@selector(editingPrice:) forControlEvents:UIControlEventEditingChanged];
    [priceTextField addTarget:self action:@selector(doneEditongPrice:) forControlEvents:UIControlEventEditingDidEnd];
    [subview1 addSubview:priceTextField];
    
    [self addSubview:subview1];

    
    GradientView *subview2 = [[GradientView alloc] initWithFrame:CGRectMake(3, 135, 314, 135)];
    [subview2 useDefaultColors];
    
    UILabel *discountTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(17, 11, 280, 21)];
    [discountTitleLabel setTextAlignment:NSTextAlignmentCenter];
    [discountTitleLabel setFont:[UIFont fontWithName:@"Ubuntu-Medium" size:24]];
    [discountTitleLabel setText:@"Choose a discount"];
    [discountTitleLabel setBackgroundColor:[UIColor clearColor]];
    [subview2 addSubview:discountTitleLabel];
    
    
    pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 320, 1000)];
    pickerView.showsSelectionIndicator = true;
    pickerView.delegate = self;
    pickerView.dataSource = self;
    
    CGAffineTransform rotate = CGAffineTransformMakeRotation(-3.14/2);
    rotate = CGAffineTransformScale(rotate, 0.25, 1.4);
    
    [self.pickerView setTransform:rotate];
    [self.pickerView setCenter:CGPointMake(157, 80)];
    CGAffineTransform rotateItem = CGAffineTransformMakeRotation(3.14/2);
    rotateItem = CGAffineTransformScale(rotateItem, 0.7, 4.0);
    choices = [[NSMutableArray alloc] initWithCapacity:20];
    
    for (int i=7;i<20;i++) {
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
        choiceLabel.font = [UIFont fontWithName:@"Ubuntu" size:25];
        choiceLabel.transform = rotateItem;
        [choices addObject:choiceLabel];
    }
    
    [subview2 addSubview:pickerView];
    [self addSubview:subview2];
    
    GradientView *priceSubview = [[GradientView alloc] initWithFrame:CGRectMake(3, 280, 314, 70)];
    [priceSubview useDefaultColors];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(57, 7, 200, 21)];
    [label setText:@"Discounted price:"];
    [label setFont:[UIFont fontWithName:@"Ubuntu-Medium" size:22]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setBackgroundColor:[UIColor clearColor]];
    [priceSubview addSubview:label];
    
    priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(107, 36, 100, 21)];
    [priceLabel setText:@"$00.00"];
    [priceLabel setFont:[UIFont fontWithName:@"Ubuntu-Medium" size:22]];
    [priceLabel setBackgroundColor:[UIColor clearColor]];
    [priceLabel setTextAlignment:NSTextAlignmentCenter];
    [priceSubview addSubview:priceLabel];
    
    [self addSubview:priceSubview];

    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"ButtonBackground" ofType:@"png"];
    UIImage *buttonBackground = [[UIImage imageWithContentsOfFile:filePath] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 20, 20, 20)];


    filePath = [[NSBundle mainBundle] pathForResource:@"ButtonBackgroundHighlighted" ofType:@"png"];
    UIImage *buttonBackgroundHighlighted = [[UIImage imageWithContentsOfFile:filePath] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 20, 20, 20)];
    
    confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmButton setBackgroundImage:buttonBackground forState:UIControlStateNormal];
    [confirmButton setFrame:CGRectMake(25, 360, 270, 40.)];
    [confirmButton setTitle:@"Confirm" forState:UIControlStateNormal];
    [confirmButton setBackgroundImage:buttonBackgroundHighlighted forState:UIControlStateHighlighted];
    [[confirmButton titleLabel] setFont:[UIFont fontWithName:@"MarkoOne-Regular" size:20.]];
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
