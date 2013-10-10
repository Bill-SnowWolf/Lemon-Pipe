//
//  DurationView.m
//  Lemon-Pipe
//
//  Created by Bill on 13-10-09.
//  Copyright (c) 2013 Bill. All rights reserved.
//

#import "DurationView.h"

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
        [self setBackgroundColor:[UIColor whiteColor]];
        [self initializeView];
    }
    return self;
}

- (void) initializeView
{
    UILabel *durationTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 280, 21)];
    [durationTitleLabel setText:@"Choose a duration"];
    [durationTitleLabel setFont:[UIFont fontWithName:@"Arial" size:27]];
    [durationTitleLabel setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:durationTitleLabel];
    
    UIView *subview = [[UIView alloc] initWithFrame:CGRectMake(0, 55, 320, 240)];
    [subview setBackgroundColor:[UIColor colorWithWhite:0.9 alpha:1.0]];
    
    UILabel *hoursLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 7, 320, 21)];
    [hoursLabel setBackgroundColor:[UIColor clearColor]];
    [hoursLabel setTextAlignment:NSTextAlignmentCenter];
    [hoursLabel setText:@"number of hours"];
    [hoursLabel setFont:[UIFont fontWithName:@"Arial" size:20]];
    [subview addSubview:hoursLabel];
    
    // Initialize hours picker view
    hoursPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 80, 1000)];
    hoursPickerView.showsSelectionIndicator = true;
    hoursPickerView.delegate = self;
    hoursPickerView.dataSource = self;
    
    CGAffineTransform rotate = CGAffineTransformMakeRotation(-3.14/2);
    rotate = CGAffineTransformScale(rotate, 1.0, 1.5);
    
    [self.hoursPickerView setTransform:rotate];
    [self.hoursPickerView setCenter:CGPointMake(160, 76)];
    CGAffineTransform rotateItem = CGAffineTransformMakeRotation(3.14/2);
    rotateItem = CGAffineTransformScale(rotateItem, 0.7, 1.0);
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
        choiceLabel.font = [UIFont fontWithName:@"Georgia" size:25];
        choiceLabel.transform = rotateItem;
        [hoursList addObject:choiceLabel];
    }
    
    [subview addSubview:hoursPickerView];
    
    
    UILabel *daysLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 125, 320, 25)];
    [daysLabel setBackgroundColor:[UIColor clearColor]];
    [daysLabel setTextAlignment:NSTextAlignmentCenter];
    [daysLabel setText:@"number of days"];
    [daysLabel setFont:[UIFont fontWithName:@"Arial" size:20]];
    [subview addSubview:daysLabel];
    
    
    
    // Initialize days picker view
    daysPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 80, 1000)];
    daysPickerView.showsSelectionIndicator = true;
    daysPickerView.delegate = self;
    daysPickerView.dataSource = self;
    
    rotate = CGAffineTransformMakeRotation(-3.14/2);
    rotate = CGAffineTransformScale(rotate, 1.0, 1.5);
    
    [self.daysPickerView setTransform:rotate];
    [self.daysPickerView setCenter:CGPointMake(160, 200)];
    rotateItem = CGAffineTransformMakeRotation(3.14/2);
    rotateItem = CGAffineTransformScale(rotateItem, 0.7, 1.0);
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
        choiceLabel.font = [UIFont fontWithName:@"Georgia" size:25];
        choiceLabel.transform = rotateItem;
        [daysList addObject:choiceLabel];
    }
    
    [subview addSubview:daysPickerView];
    
    [self addSubview:subview];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 301, 320, 21)];
    [label setText:@"Promotion ends"];
    [label setFont:[UIFont fontWithName:@"Arial" size:20]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:label];
    
    endDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 330, 320, 21)];
    [endDateLabel setTextAlignment:NSTextAlignmentCenter];
    [endDateLabel setText:@"End Date"];
    [endDateLabel setFont:[UIFont fontWithName:@"Arial" size:20]];
    [self addSubview:endDateLabel];
    
    
    confirmButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [confirmButton setFrame:CGRectMake(50., 360., 220., 30.)];
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
    NSDate *today = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *offset = [[NSDateComponents alloc] init];
    [offset setDay:[daysPickerView selectedRowInComponent:0]+1];
    [offset setHour:[hoursPickerView selectedRowInComponent:0]+1];
    NSDate *endDay = [calendar dateByAddingComponents:offset toDate:today options:0];

    NSDateComponents *components = [calendar components:NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit fromDate:endDay];
    NSArray *weekDayName = [[NSArray alloc] initWithObjects:@"Sunday", @"Monday", @"Tuesday", @"Wednesday", @"Thursday", @"Friday", @"Saturday", nil];
    NSArray *monthName = [[NSArray alloc] initWithObjects:@"January", @"February", @"March", @"April", @"May", @"June", @"July", @"August", @"September", @"October", @"November", @"December", nil];
    NSMutableString *endDayStr = [[NSMutableString alloc] initWithFormat:@"%@ %@ %d", [weekDayName objectAtIndex:components.weekday-1], [monthName objectAtIndex:components.month-1], components.day];

    if (components.day == 1)
        [endDayStr stringByAppendingString:@"st"];
    else if (components.day == 2)
        [endDayStr stringByAppendingString:@"nd"];
    else if (components.day == 3)
        [endDayStr stringByAppendingString:@"rd"];
    else
        [endDayStr stringByAppendingString:@"th"];
    
    [endDateLabel setText:endDayStr];
}

@end
