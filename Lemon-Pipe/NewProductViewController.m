//
//  NewProductViewController.m
//  Lemon-Pipe
//
//  Created by Bill on 13-10-07.
//  Copyright (c) 2013 Bill. All rights reserved.
//

#import "NewProductViewController.h"
#import "EnterPriceView.h"
#import "DurationView.h"
#import "PreviewView.h"
#import "Product.h"

@interface NewProductViewController ()
{
    UIImage *productImage;
    float MSRP;
    NSInteger discount;
    NSInteger promotionDays;
    NSInteger promotionHours;
    bool modified;
    EnterPriceView *enterPriceView;
    DurationView *durationView;
    PreviewView *previewView;
}
@end

@implementation NewProductViewController

@synthesize imageView;
@synthesize delegate;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        modified = false;
        MSRP = 0.0f;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated
{
   [self takePicture];
}

- (void) viewWillDisappear:(BOOL)animated
{
    NSLog(@"Dismiss");
}

- (void) takePicture
{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        //Create camera overlay
#warning improve camera ui
        [imagePickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
        CGRect f = imagePickerController.view.bounds;
        f.size.height -= imagePickerController.navigationBar.bounds.size.height;
        
        CGFloat barHeight = (f.size.height - f.size.width) / 2;
        
        UIGraphicsBeginImageContext(f.size);
        [[UIColor colorWithRed:122 green:10 blue:10 alpha:.8] set];
        UIRectFillUsingBlendMode(CGRectMake(0, 0, f.size.width, barHeight), kCGBlendModeLuminosity);
        UIRectFillUsingBlendMode(CGRectMake(0, f.size.height - barHeight, f.size.width, barHeight), kCGBlendModeNormal);
        UIImage *overlayImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        UIImageView *overlayIV = [[UIImageView alloc] initWithFrame:f];
        overlayIV.image = overlayImage;
        [imagePickerController.cameraOverlayView addSubview:overlayIV];
    } else
        [imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    
    imagePickerController.delegate = self;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)confirmPrice:(id)sender
{
    MSRP = [[enterPriceView.priceTextField text] floatValue];
    discount = ([enterPriceView.pickerView selectedRowInComponent:0] + 7) * 5;
    modified = true;
    
    // Heading to duration page
    durationView = [[DurationView alloc] initWithFrame:[self.view frame]];
    [durationView.confirmButton addTarget:self action:@selector(confirmDuration:) forControlEvents:UIControlEventTouchUpInside];
    self.view = durationView;
}

- (void)confirmDuration:(id)sender
{
    promotionDays = [durationView.daysPickerView selectedRowInComponent:0];
    promotionHours = [durationView.hoursPickerView selectedRowInComponent:0];
    modified = true;
    
    // Heading to Preview

    previewView = [[PreviewView alloc] initWithFrame:[self.view frame]];
    
    [previewView.discountLabel setText:[NSString stringWithFormat:@"%d", discount]];
    [previewView.durationLabel setText:[NSString stringWithFormat:@"%d", promotionDays]];
    [previewView.productImageView setImage:productImage];
    [previewView.msrpLabel setText:[NSString stringWithFormat:@"$%.2f", MSRP]];
    [previewView.discountPriceLabel setText:[NSString stringWithFormat:@"$%.2f", MSRP * (1- 0.01*discount)]];
    
    [previewView.redoButton addTarget:self action:@selector(redo:) forControlEvents:UIControlEventTouchUpInside];
    [previewView.postButton addTarget:self action:@selector(post:) forControlEvents:UIControlEventTouchUpInside];
    
    self.view = previewView;
}

- (void)redo:(id)sender
{
    modified =false;
    
    discount = 0;
    promotionDays = 0;
    promotionHours = 0;
    MSRP = 0;
    productImage = nil;
    
    
    [self takePicture];
}

- (void)post:(id)sender
{
    Product *newProduct = [[Product alloc] initWithImage:productImage MSRP:MSRP discount:discount promotionDays:promotionDays promotionHours:promotionHours];
    [self.delegate addNewProduct:newProduct];
    [self.navigationController popToRootViewControllerAnimated:YES];
}



#pragma mark - UIImagePickerController delegate

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    CGSize imageSize = image.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    if (width != height) {
        CGFloat newDimension = MIN(width, height);
        CGFloat widthOffset = (width - newDimension) / 2;
        CGFloat heightOffset = (height - newDimension) / 2;
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(newDimension, newDimension), NO, 0.);
        [image drawAtPoint:CGPointMake(-widthOffset, -heightOffset)
                 blendMode:kCGBlendModeCopy
                     alpha:1.];
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    productImage = image;
    [self dismissViewControllerAnimated:NO completion:nil];
    modified = true;
    
    // Heading to MSRP page    
    enterPriceView = [[EnterPriceView alloc] initWithFrame:[self.view frame]];
    [enterPriceView.confirmButton addTarget:self action:@selector(confirmPrice:) forControlEvents:UIControlEventTouchUpInside];
    self.view = enterPriceView;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:NO completion:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
