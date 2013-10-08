//
//  NewProductViewController.m
//  Lemon-Pipe
//
//  Created by Bill on 13-10-07.
//  Copyright (c) 2013 Bill. All rights reserved.
//

#import "NewProductViewController.h"
#import "EnterPriceView.h"
#import "DiscountView.h"

@interface NewProductViewController ()
{
    UIImage *productImage;
    float MSRP;
    bool modified;
    EnterPriceView *enterPriceView;
    DiscountView *discountView;
}
@end

@implementation NewProductViewController

@synthesize imageView;

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
    enterPriceView = [[EnterPriceView alloc] initWithFrame:[self.view frame]];
    [enterPriceView.confirmButton addTarget:self action:@selector(addMSRP:) forControlEvents:UIControlEventTouchUpInside];

    discountView = [[DiscountView alloc] initWithFrame:[self.view frame]];
    [discountView.pickerView setDelegate:self];
    [discountView.pickerView setDataSource:self];
    [discountView.pickerView selectRow:10 inComponent:0 animated:NO];
	
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

- (void)addMSRP:(id)sender
{
    NSLog(@"Confirm price is %@",[enterPriceView.priceTextField text]);
    MSRP = [[enterPriceView.priceTextField text] floatValue];
    modified = true;
    
    // Heading to discount page
    self.view = discountView;
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
    [self.view addSubview:enterPriceView];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:NO completion:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - UIPickerView Delegate

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    return [[discountView choices] objectAtIndex:row];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [[discountView choices] count];
}

@end
