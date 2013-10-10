//
//  NewProductViewController.h
//  Lemon-Pipe
//
//  Created by Bill on 13-10-07.
//  Copyright (c) 2013 Bill. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Product;

@protocol NewProductDelegate <NSObject>

- (void) addNewProduct: (Product *)newProduct;

@end

@interface NewProductViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, retain) IBOutlet UIImageView *imageView;
@property (nonatomic) id<NewProductDelegate> delegate;

@end
