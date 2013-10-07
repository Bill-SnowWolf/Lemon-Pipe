//
//  Products.m
//  Lemon-Pipe
//
//  Created by Bill on 13-10-07.
//  Copyright (c) 2013 Bill. All rights reserved.
//

#import "Product.h"

@implementation Product
@synthesize image;
@synthesize MSRP;
@synthesize discount;
@synthesize discountPrice;
@synthesize duration;
@synthesize numOfDayLeft;

- (id) init
{
    self = [super init];
    if (self) {
        image = [[UIImage alloc] init];
        MSRP = 0;
        discount = 0;
        discountPrice = 0;
        duration = 0;
        numOfDayLeft = 0;
    }
    return self;
}

- (id) initWithImage:(UIImage *)aImage MSRP:(float)retailPrice Discount:(NSInteger)disc Duration:(NSInteger)numOfDays
{
    self = [super init];
    if (self) {
        image = aImage;
        MSRP = retailPrice;
        discount = disc;
        discountPrice = MSRP * discount;
        duration = numOfDays;
        numOfDayLeft = duration;
    }
    return self;
}


@end
