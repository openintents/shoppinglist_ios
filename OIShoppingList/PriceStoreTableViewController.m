//
//  PriceStoreTableViewController.m
//  OIShoppingList
//
//  Created by Tian Hongyu on 16/7/12.
//  Copyright (c) 2012 OpenIntents. All rights reserved.
//

#import "PriceStoreTableViewController.h"

@interface PriceStoreTableViewController ()

@end

@implementation PriceStoreTableViewController

#define MAINLABEL_TAG 1
#define SECONDLABEL_TAG 2
#define PHOTO_TAG 3
#define PRICE_TAG 4


@synthesize contain = _contain;



#pragma mark - table view data source
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"ImageOnRightCell";
    
    UILabel *secondLabel;
    PriceTextField * price;
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        secondLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 110 , 30)];
        secondLabel.tag = SECONDLABEL_TAG;
        secondLabel.font = [UIFont systemFontOfSize:16.0];
        secondLabel.textAlignment = UITextAlignmentLeft;
        secondLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
        [cell.contentView addSubview:secondLabel];
        
        price = [[PriceTextField alloc]initWithFrame:CGRectMake(180, 5, 30, 30)];
        price.tag = PRICE_TAG;
        price.delegate = self;
        price.keyboardAppearance = UIKeyboardTypeNumberPad;
        price.borderStyle = UITextBorderStyleLine;
        price.placeholder = @"price";
        price.font=[UIFont systemFontOfSize:18.0];
        price.textAlignment = UITextAlignmentLeft;
        [cell.contentView addSubview: price];
        
        } else {
        secondLabel = (UILabel *)[cell.contentView viewWithTag:SECONDLABEL_TAG];
        price = (PriceTextField*)[cell.contentView viewWithTag:PRICE_TAG];
    }
    
    Stores * store = [self.fetchedResultsController objectAtIndexPath:indexPath];
    secondLabel.text = store.name;
    price.text = [[store priceForItem:self.contain.item_id] description];
    price.storeName = store.name;
    return cell;
}

-(BOOL) textFieldShouldReturn:(PriceTextField *)textField
{
    [textField resignFirstResponder];
    
    [self.contain setThePrice:[NSNumber numberWithFloat: [textField.text doubleValue]] inStoreWithName:textField.storeName];
                              
    return YES;
}
-(void)textFieldDidEndEditing:(PriceTextField *)textField
{
    [textField resignFirstResponder];
    [self.contain setThePrice:[NSNumber numberWithFloat: [textField.text doubleValue]] inStoreWithName:textField.storeName];


}


#pragma mark - creat new entry
- (IBAction)finishTyping:(UITextField *)sender {
    
    [self.contain setThePrice:[NSNumber numberWithInt:0] inStoreWithName:sender.text];
}

#pragma mark - fatch results controller setup
-(void) setContain:(Contains *)contain 
{
    _contain = contain;
    self.title = contain.item_id.name;
    [self setupFetchedResultsController];
}

- (void)setupFetchedResultsController // attaches an NSFetchRequest to this UITableViewController
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Stores"];
    request.sortDescriptors =[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"created"
     ascending:YES
     selector:@selector(compare:)]];
    request.predicate = [NSPredicate predicateWithFormat:@"list_id = %@", self.contain.list_id];

    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                        managedObjectContext:self.contain.managedObjectContext
                                                                          sectionNameKeyPath:nil                                                                                        cacheName:nil];
}



#pragma mark - lifecycle
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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source




// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
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

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}

#pragma mark - Table view delegate
/*
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO animated:NO];   
}
*/
@end
