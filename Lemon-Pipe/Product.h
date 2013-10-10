//
//  Products.h
//  Lemon-Pipe
//
//  Created by Bill on 13-10-07.
//  Copyright (c) 2013 Bill. All rights reserved.
//
//  This class is a Data structure of product
#import <Foundation/Foundation.h>

@interface Product : NSObject
@property (nonatomic, retain) UIImage *image;
@property (nonatomic) float MSRP;
@property (nonatomic) NSInteger discount;
@property (nonatomic) float discountPrice;
@property (nonatomic) NSInteger promotionDays;
@property (nonatomic) NSInteger promotionHours;
@property (nonatomic) NSInteger numOfDayLeft;

- (id) init;
- (id) initWithImage:(UIImage *)aImage MSRP:(float)retailPrice discount:(NSInteger)disc promotionDays:(NSInteger)days promotionHours:(NSInteger) hours;

@end
