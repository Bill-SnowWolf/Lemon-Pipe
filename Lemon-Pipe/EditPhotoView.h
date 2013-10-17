//
//  EditPhotoView.h
//  Lemon-Pipe
//
//  Created by Bill on 13-10-16.
//  Copyright (c) 2013 Bill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditPhotoView : UIView
@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) UIButton *retakeButton;
@property (nonatomic, retain) UIButton *useButton;

- (id)initWithFrame:(CGRect)frame image:(UIImage *)image;
@end
