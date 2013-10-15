//
//  CustomNavigationBar.m
//  Lemon-Pipe
//
//  Created by Bill on 13-10-15.
//  Copyright (c) 2013 Bill. All rights reserved.
//

#import "CustomNavigationBar.h"

@implementation CustomNavigationBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setTintColor:[UIColor colorWithRed:0.941 green:0.392 blue:0.196 alpha:1.0]];
    }
    return self;
}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [super drawRect:rect];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"NavBarImage" ofType:@"png"];
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:filePath];
    [image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}



@end
