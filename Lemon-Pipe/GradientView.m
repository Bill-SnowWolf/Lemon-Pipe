//
//  GradientView.m
//  Lemon-Pipe
//
//  Created by Bill on 13-10-17.
//  Copyright (c) 2013 Bill. All rights reserved.
//

#import "GradientView.h"

@implementation GradientView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

#pragma mark - UIView

+ (Class)layerClass
{
    return [CAGradientLayer class];
}

#pragma mark - Accessors

- (CAGradientLayer *)gradientLayer
{
    return (CAGradientLayer *)self.layer;
}

- (void)setColors:(NSArray *)colors
{
    NSMutableArray *cgColors = [NSMutableArray arrayWithCapacity:colors.count];
    for (UIColor *color in colors)
    {
        [cgColors addObject:(id)[color CGColor]];
    }
    
    self.gradientLayer.colors = cgColors;
}

- (NSArray *)colors
{
    NSMutableArray *uiColors = [NSMutableArray arrayWithCapacity:self.gradientLayer.colors.count];
    for (id color in self.gradientLayer.colors)
    {
        [uiColors addObject:[UIColor colorWithCGColor:(CGColorRef)color]];
    }
    
    return uiColors;
}

- (void)useDefaultColors
{
    self.gradientLayer.colors = (@[
                                 (id)[UIColor colorWithRed:0.988 green:0.529 blue:0.157 alpha:1.0].CGColor,
                                 (id)[UIColor colorWithRed:1 green:0.839 blue:0.227 alpha:1].CGColor
                                 ]);
    self.gradientLayer.startPoint = CGPointMake(0, 0);
    self.gradientLayer.endPoint = CGPointMake(1, 0);
}
@end
