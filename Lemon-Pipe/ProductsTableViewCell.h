//
//  ProductsTableViewCell.h
//  Lemon-Pipe
//
//  Created by Bill on 13-10-07.
//  Copyright (c) 2013 Bill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductsTableViewCell : UITableViewCell
@property (nonatomic, retain) IBOutlet UILabel *discountLabel;
@property (nonatomic, retain) IBOutlet UILabel *remainningDaysLabel;
@property (nonatomic, retain) IBOutlet UIImageView *productImageView;
@end
