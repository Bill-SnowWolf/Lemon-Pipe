//
//  DurationView.m
//  Lemon-Pipe
//
//  Created by Bill on 13-10-09.
//  Copyright (c) 2013 Bill. All rights reserved.
//

#import "DurationView.h"
#import "GradientView.h"

@implementation DurationView
@synthesize hoursPickerView;
@synthesize daysPickerView;
@synthesize endDateLabel;
@synthesize confirmButton;
@synthesize hoursList;
@synthesize daysList;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor colorWithRed:0.129 green:0.282 blue:0.384 alpha:1.0]];
        [self initializeView];
        [self setEndDate];
    }
    return self;
}
- (void)drawRect:(CGRect)rect
{
    CGContextRef myContext = UIGraphicsGetCurrentContext();
    
    CGContextBeginPath(myContext);
    CGContextMoveToPoint(myContext, 3, 15);
    CGContextAddLineToPoint(myContext, 317, 15);
    CGContextMoveToPoint(myContext, 3, 280);
    CGContextAddLineToPoint(myContext, 317, 280);
    CGContextMoveToPoint(myContext, 3, 146);
    CGContextAddLineToPoint(myContext, 317, 146);
    CGContextSetRGBStrokeColor(myContext, 1, 1, 1, 1);
    CGContextStrokePath(myContext);
    
    CGContextMoveToPoint(myContext, 3, 275);
    CGContextAddLineToPoint(myContext, 317, 275);
    CGContextMoveToPoint(myContext, 3, 350);
    CGContextAddLineToPoint(myContext, 317, 350);
    CGContextMoveToPoint(myContext, 3, 145);
    CGContextAddLineToPoint(myContext, 317, 145);
    CGContextSetRGBStrokeColor(myContext, 0, 0, 0, 1);
    CGContextStrokePath(myContext);
    
}

- (void) initializeView
{
    GradientView *subview1 = [[GradientView alloc] initWithFrame:CGRectMake(3, 15, 314, 130)];
    [subview1 useDefaultColors];
    
    UILabel *hoursLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 9, 314, 21)];
    [hoursLabel setBackgroundColor:[UIColor clearColor]];
    [hoursLabel setTextAlignment:NSTextAlignmentCenter];
    [hoursLabel setText:@"Number of Hours"];
    [hoursLabel setFont:[UIFont fontWithName:@"Ubuntu-Medium" size:24]];
    [subview1 addSubview:hoursLabel];
    
    // Initialize hours picker view
    hoursPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 320, 1000)];
    hoursPickerView.showsSelectionIndicator = true;
    hoursPickerView.delegate = self;
    hoursPickerView.dataSource = self;
    
    CGAffineTransform rotate = CGAffineTransformMakeRotation(-3.14/2);
    rotate = CGAffineTransformScale(rotate, 0.25, 1.4);
    
    [self.hoursPickerView setTransform:rotate];
    [self.hoursPickerView setCenter:CGPointMake(157, 80)];
    CGAffineTransform rotateItem = CGAffineTransformMakeRotation(3.14/2);
    rotateItem = CGAffineTransformScale(rotateItem, 0.7, 4.0);
    hoursList = [[NSMutableArray alloc] initWithCapacity:20];
    
    for (int i=0;i<=24;i++) {
        UILabel *choiceLabel;
        choiceLabel = [[UILabel alloc] init];
        choiceLabel.text = [NSString stringWithFormat:@"%d", i];
        choiceLabel.textColor = [UIColor blackColor];
        choiceLabel.frame = CGRectMake(0, 0, 100, 70);
        choiceLabel.backgroundColor = [UIColor clearColor];
        choiceLabel.textAlignment = NSTextAlignmentCenter;
        choiceLabel.shadowColor = [UIColor whiteColor];
        choiceLabel.shadowOffset = CGSizeMake(-1, -1);
        choiceLabel.adjustsFontSizeToFitWidth = YES;
        choiceLabel.font = [UIFont fontWithName:@"Ubuntu" size:25];
        choiceLabel.transform = rotateItem;
        [hoursList addObject:choiceLabel];
    }
    
    [subview1 addSubview:hoursPickerView];
    [self addSubview:subview1];
    
    GradientView *subview2 = [[GradientView alloc] initWithFrame:CGRectMake(3, 146, 314, 129)];
    [subview2 useDefaultColors];
    
    
    UILabel *daysLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, 9, 314, 21)];
    [daysLabel setBackgroundColor:[UIColor clearColor]];
    [daysLabel setTextAlignment:NSTextAlignmentCenter];
    [daysLabel setText:@"Number of Days"];
    [daysLabel setFont:[UIFont fontWithName:@"Ubuntu-Medium" size:24]];
    [subview2 addSubview:daysLabel];
    
    
    
    // Initialize days picker view
    daysPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 320, 1000)];
    daysPickerView.showsSelectionIndicator = true;
    daysPickerView.delegate = self;
    daysPickerView.dataSource = self;
    
    rotate = CGAffineTransformMakeRotation(-3.14/2);
    rotate = CGAffineTransformScale(rotate, 0.25, 1.4);
    
    [self.daysPickerView setTransform:rotate];
    [self.daysPickerView setCenter:CGPointMake(157, 80)];
    rotateItem = CGAffineTransformMakeRotation(3.14/2);
    rotateItem = CGAffineTransformScale(rotateItem, 0.7, 4.0);
    daysList = [[NSMutableArray alloc] initWithCapacity:20];
    
    for (int i=0;i<=14;i++) {
        UILabel *choiceLabel;
        choiceLabel = [[UILabel alloc] init];
        choiceLabel.text = [NSString stringWithFormat:@"%d", i];
        choiceLabel.textColor = [UIColor blackColor];
        choiceLabel.frame = CGRectMake(0, 0, 50, 50);
        choiceLabel.backgroundColor = [UIColor clearColor];
        choiceLabel.textAlignment = NSTextAlignmentCenter;
        choiceLabel.shadowColor = [UIColor whiteColor];
        choiceLabel.shadowOffset = CGSizeMake(-1, -1);
        choiceLabel.adjustsFontSizeToFitWidth = YES;
        choiceLabel.font = [UIFont fontWithName:@"Ubuntu" size:25];
        choiceLabel.transform = rotateItem;
        [daysList addObject:choiceLabel];
    }
    
    [subview2 addSubview:daysPickerView];
    
    [self addSubview:subview2];
    
    GradientView *subview3 = [[GradientView alloc] initWithFrame:CGRectMake(3, 280, 314, 70)];
    [subview3 useDefaultColors];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 7, 314, 21)];
    [label setText:@"Promotion ends"];
    [label setFont:[UIFont fontWithName:@"Ubuntu-Medium" size:20]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setBackgroundColor:[UIColor clearColor]];
    [subview3 addSubview:label];
    
    endDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 36, 314, 21)];
    [endDateLabel setTextAlignment:NSTextAlignmentCenter];
    [endDateLabel setText:@"End Date"];
    [endDateLabel setBackgroundColor:[UIColor clearColor]];
    [endDateLabel setFont:[UIFont fontWithName:@"Ubuntu-Medium" size:20]];
    [subview3 addSubview:endDateLabel];
    [self addSubview:subview3];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"ButtonBackground" ofType:@"png"];
    UIImage *buttonBackground = [[UIImage imageWithContentsOfFile:filePath] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 20, 20, 20)];
    filePath = [[NSBundle mainBundle] pathForResource:@"ButtonBackgroundHighlighted" ofType:@"png"];
    UIImage *buttonBackgroundHighlighted = [[UIImage imageWithContentsOfFile:filePath] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 20, 20, 20)];

    
    confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmButton setBackgroundImage:buttonBackground forState:UIControlStateNormal];
    [confirmButton setBackgroundImage:buttonBackgroundHighlighted forState:UIControlStateHighlighted];
    [confirmButton setFrame:CGRectMake(25, 360, 270, 40.)];
    [confirmButton setTitle:@"Confirm" forState:UIControlStateNormal];
    [[confirmButton titleLabel] setFont:[UIFont fontWithName:@"MarkoOne-Regular" size:20.]];
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

#pragma UIPickerView Delegate
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    if (pickerView == self.daysPickerView)
        return [[self daysList] objectAtIndex:row];
    else
        return [[self hoursList] objectAtIndex:row];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView == self.daysPickerView)
        return [[self daysList] count];
    else
        return [[self hoursList] count];
}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [self setEndDate];
}

- (void) setEndDate
{
    NSDate *today = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *offset = [[NSDateComponents alloc] init];
    [offset setDay:[daysPickerView selectedRowInComponent:0]+1];
    [offset setHour:[hoursPickerView selectedRowInComponent:0]+1];
    NSDate *endDay = [calendar dateByAddingComponents:offset toDate:today options:0];
    
    NSDateComponents *components = [calendar components:NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit fromDate:endDay];
    NSArray *weekDayName = [[NSArray alloc] initWithObjects:@"Sunday", @"Monday", @"Tuesday", @"Wednesday", @"Thursday", @"Friday", @"Saturday", nil];
    NSArray *monthName = [[NSArray alloc] initWithObjects:@"January", @"February", @"March", @"April", @"May", @"June", @"July", @"August", @"September", @"October", @"November", @"December", nil];

    NSString *appendingString;
    if (components.day == 1)
        appendingString = @"st";
    else if (components.day == 2)
        appendingString = @"nd";
    else if (components.day == 3)
        appendingString = @"rd";
    else
        appendingString = @"th";

    
    NSString *endDayStr = [[NSString alloc] initWithFormat:@"%@ %@ %d%@", [weekDayName objectAtIndex:components.weekday-1], [monthName objectAtIndex:components.month-1], components.day, appendingString];
        
    [endDateLabel setText:endDayStr];
    
}

@end
