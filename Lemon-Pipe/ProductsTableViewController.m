//
//  ProductsViewController.m
//  Lemon-Pipe
//
//  Created by Bill on 13-10-07.
//  Copyright (c) 2013 Bill. All rights reserved.
//

#import "ProductsTableViewController.h"
#import "ProductsTableViewCell.h"
#import "Product.h"

@interface ProductsTableViewController ()
{
    NSMutableArray *productLists;
}
@end

@implementation ProductsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    productLists = [[NSMutableArray alloc] initWithCapacity:20];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Protein" ofType:@"jpg"];
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:filePath];
    Product *product = [[Product alloc] initWithImage:image MSRP:10.00 Discount:35 Duration:4];
    [productLists addObject:product];
        
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return productLists.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ProductCell";
    ProductsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[ProductsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }	
    // Configure the cell...
    Product *product = [productLists objectAtIndex:indexPath.row];
    [[cell productImageView] setImage:[product image]];
    [[cell discountLabel] setText:[NSString stringWithFormat:@"%i", product.discount]];
    [[cell remainningDaysLabel] setText:[NSString stringWithFormat:@"%i", product.duration]];
    
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [productLists removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [tableView reloadData];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

/*

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ViewController *controller = [segue destinationViewController];
    controller.delegate = self;
}
*/

/*
#pragma mark - AddItem delegat
- (void) value:(NSString *)string
{
    [productLists addObject:string];
    [self.tableView reloadData];
    NSLog(@"%@", string);
}
 */

@end
