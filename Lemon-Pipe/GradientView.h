//
//  GradientView.h
//  Lemon-Pipe
//
//  Created by Bill on 13-10-17.
//  Copyright (c) 2013 Bill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface GradientView : UIView

@property (nonatomic, readonly) CAGradientLayer *gradientLayer;

// An Array of UIColors for the gradient
@property (nonatomic, readwrite) NSArray *colors;

- (void)useDefaultColors;

@end
