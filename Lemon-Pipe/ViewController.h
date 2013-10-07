//
//  ViewController.h
//  Lemon-Pipe
//
//  Created by Bill on 13-10-07.
//  Copyright (c) 2013 Bill. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddItemsDelegate <NSObject>

- (void)value: (NSString *) string;

@end

@interface ViewController : UIViewController
@property (nonatomic, retain) IBOutlet UITextField *textField;
@property (nonatomic, weak) id<AddItemsDelegate> delegate;

- (IBAction)inputValue:(id)sender;
@end
