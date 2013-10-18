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
#import "CustomOverlayView.h"
#import "EditPhotoView.h"

@interface NewProductViewController ()
{
    UIImage *productImage;
    float MSRP;
    NSInteger discount;
    NSInteger promotionDays;
    NSInteger promotionHours;
    bool modified;
    EditPhotoView *editPhotoView;
    EnterPriceView *enterPriceView;
    DurationView *durationView;
    PreviewView *previewView;
    UIImagePickerController *imagePickerController;
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
    [[UINavigationBar appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIFont fontWithName:@"MarkoOne-Regular" size:24.0], UITextAttributeFont,nil]];
    
    // Hide back button
    self.navigationItem.hidesBackButton = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated
{
   [self openCamera];
}

- (void) viewWillDisappear:(BOOL)animated
{
    
}

#pragma mark - View Actions
// Take Photo View
- (void) openCamera
{
    imagePickerController = [[UIImagePickerController alloc] init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        //Create camera overlay
        [imagePickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
        [imagePickerController setModalPresentationStyle:UIModalPresentationCurrentContext];
        
        imagePickerController.showsCameraControls = NO;
        
        CustomOverlayView *overlayView = [[CustomOverlayView alloc] initWithFrame:imagePickerController.view.frame];
        [overlayView.takePhotoButton addTarget:self action:@selector(takePhoto:) forControlEvents:UIControlEventTouchUpInside];
        
        [imagePickerController.cameraOverlayView addSubview:overlayView];
    } else
        [imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    
    imagePickerController.delegate = self;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)takePhoto:(id)sender
{
    [imagePickerController takePicture];
}

// Edit Photo View
- (void)useImage:(id)sender
{
    // Heading to MSRP page
    enterPriceView = [[EnterPriceView alloc] initWithFrame:[self.view frame]];
    [enterPriceView.confirmButton addTarget:self action:@selector(confirmPrice:) forControlEvents:UIControlEventTouchUpInside];
    self.view = enterPriceView;
    [self.navigationItem setTitle:@"Price & Discount"];
}

- (void)retakeImage:(id)sender
{
    productImage = nil;
    [self openCamera];
}


// Price & Discount View

- (void)confirmPrice:(id)sender
{
    MSRP = [[enterPriceView.priceTextField text] floatValue];
    discount = ([enterPriceView.pickerView selectedRowInComponent:0] + 7) * 5;
    modified = true;
    
    // Heading to duration page
    durationView = [[DurationView alloc] initWithFrame:[self.view frame]];
    [durationView.confirmButton addTarget:self action:@selector(confirmDuration:) forControlEvents:UIControlEventTouchUpInside];
    self.view = durationView;
    
    [self.navigationItem setTitle:@"Choose a Duration"];
}

// Duration View

- (void)confirmDuration:(id)sender
{
    promotionDays = [durationView.daysPickerView selectedRowInComponent:0];
    promotionHours = [durationView.hoursPickerView selectedRowInComponent:0];
    modified = true;
    
    // Heading to Preview

    previewView = [[PreviewView alloc] initWithFrame:[self.view frame] discount:discount msrp:MSRP productImage:productImage promotionDays:promotionDays promotionHours:promotionHours];
    
    [previewView.discountPriceLabel setText:[NSString stringWithFormat:@"$%.2f", MSRP * (1- 0.01*discount)]];
    
    [previewView.redoButton addTarget:self action:@selector(redo:) forControlEvents:UIControlEventTouchUpInside];
    [previewView.postButton addTarget:self action:@selector(post:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.navigationItem setTitle:@"Promotion Preview"];
    
    self.view = previewView;
}

// Preview View
- (void)redo:(id)sender
{
    modified =false;
    
    discount = 0;
    promotionDays = 0;
    promotionHours = 0;
    MSRP = 0;
    productImage = nil;
    
    
    [self openCamera];
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
    NSLog(@"width = %.2f, height = %.2f %.2f", width, height, [[UIScreen mainScreen] scale]);
    CGFloat newDimension = 2360;
    CGFloat widthOffset = 20 * [[UIScreen mainScreen] scale];
    CGFloat heightOffset = 135 * [[UIScreen mainScreen] scale];
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(40, 300, 2360, 2360));
    // or use the UIImage wherever you like
    image = [UIImage imageWithCGImage:imageRef scale:1.0 orientation:UIImageOrientationRight];
    CGImageRelease(imageRef);
    
    productImage = image;
    /*    UIGraphicsBeginImageContextWithOptions(CGSizeMake(newDimension, newDimension), NO, 0.);

    [image drawAtPoint:CGPointMake(-widthOffset, -heightOffset)
                 blendMode:kCGBlendModeCopy
                     alpha:1.];
    
    productImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
*/
    [self dismissViewControllerAnimated:NO completion:nil];
    modified = true;
    
    // Show Edit Photo View
    [self.navigationItem setTitle:@"Edit Photo"];
    editPhotoView = [[EditPhotoView alloc] initWithFrame:self.view.frame image:productImage];
    
    [editPhotoView.retakeButton addTarget:self action:@selector(retakeImage:) forControlEvents:UIControlEventTouchUpInside];
    [editPhotoView.useButton addTarget:self action:@selector(useImage:) forControlEvents:UIControlEventTouchUpInside];
    
    self.view = editPhotoView;

}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:NO completion:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
