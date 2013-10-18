//
//  PreviewView.h
//  Lemon-Pipe
//
//  Created by Bill on 13-10-09.
//  Copyright (c) 2013 Bill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PreviewView : UIView
@property (nonatomic, retain) UILabel *discountLabel;
@property (nonatomic, retain) UILabel *durationLabel;
@property (nonatomic, retain) UIImageView *productImageView;
@property (nonatomic, retain) UILabel *msrpLabel;
@property (nonatomic, retain) UILabel *discountPriceLabel;
@property (nonatomic, retain) UIButton *redoButton;
@property (nonatomic, retain) UIButton *postButton;

- (id)initWithFrame:(CGRect)frame discount:(NSInteger) discount msrp:(float)msrp productImage:(UIImage *)productImage promotionDays:(NSInteger)days promotionHours:(NSInteger)hours;
@end
