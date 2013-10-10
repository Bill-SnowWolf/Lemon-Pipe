//
//  EnterPriceView.h
//  Lemon-Pipe
//
//  Created by Bill on 13-10-08.
//  Copyright (c) 2013 Bill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EnterPriceView : UIView <UIPickerViewDataSource, UIPickerViewDelegate>
@property (nonatomic, retain) UIButton *confirmButton;
@property (nonatomic, retain) UITextField *priceTextField;
@property (nonatomic, retain) UIPickerView *pickerView;
@property (nonatomic) NSMutableArray *choices;
@property (nonatomic, retain) UILabel *priceLabel;

@end
