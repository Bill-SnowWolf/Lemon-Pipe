//
//  DurationView.h
//  Lemon-Pipe
//
//  Created by Bill on 13-10-09.
//  Copyright (c) 2013 Bill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DurationView : UIView <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, retain) UIPickerView *hoursPickerView;
@property (nonatomic, retain) UIPickerView *daysPickerView;
@property (nonatomic, retain) UILabel *endDateLabel;
@property (nonatomic, retain) UIButton *confirmButton;
@property (nonatomic) NSMutableArray *hoursList;
@property (nonatomic) NSMutableArray *daysList;

@end
