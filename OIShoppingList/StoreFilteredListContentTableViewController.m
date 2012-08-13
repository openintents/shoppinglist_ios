//
//  StoreFilteredListContentTableViewController.m
//  OIShoppingList
//
//  Created by Tian Hongyu on 21/7/12.
//  Copyright (c) 2012 OpenIntents. All rights reserved.
//
/*************
 This view controller displays a list with a store filter applied.
 Only the entries with the specified filter would be displied
 
 Property "listToDisplay" and "storeFilter" should be set before presenting the controller.
 *************/
#import "StoreFilteredListContentTableViewController.h"
#import "EditingItemDetailTableViewControllerViewController.h"
#import "ShoppingListSettingManager.h"
#import "Units.h"

@interface StoreFilteredListContentTableViewController ()<MFMailComposeViewControllerDelegate,MFMessageComposeViewControllerDelegate>


@property (strong,nonatomic)  ShoppingListSettingManager * mySettingManager;

@property  int manageModeActive;
@property (strong,nonatomic) Contains *listEntry;
@property (strong,nonatomic) UIActionSheet* shareOption;
@property (strong, nonatomic) IBOutlet UILabel *priceLable;

@end


@implementation StoreFilteredListContentTableViewController
@synthesize listToDisplay = _listToDisplay;
@synthesize listEntry =_listEntry;
@synthesize manageModeActive = _manageModeActive;
@synthesize mySettingManager = _mySettingManager;
@synthesize shareOption = _shareOption;
@synthesize priceLable = _priceLable;
@synthesize storeFilter = _storeFilter;

-(void)setSubtotalLable
{
    NSString* resultString = @"Subtotals:               ";
    NSSet* set=[self.listToDisplay getStoreWisePriceDescription];
    for (NSDictionary* storeDic in set) {
        // @"subtotal",@"availablePrice",@"name"
        if ([self.storeFilter.name isEqualToString:[storeDic objectForKey:@"name"]]) {
            NSString* storeName = (NSString*)[storeDic objectForKey:@"name"];
            double storeSubtotal = [((NSNumber*)[storeDic objectForKey:@"subtotal"])doubleValue];
            NSString*temp = [NSString stringWithFormat:@"%@: $ %5.2lf\n",storeName,storeSubtotal];
            resultString = [resultString stringByAppendingString:temp];
        }
    }
    self.priceLable.text = resultString;
}
-(ShoppingListSettingManager*) mySettingManager
{
    if (!_mySettingManager) {
        _mySettingManager = [[ShoppingListSettingManager alloc]init];
    }
    return _mySettingManager;
}



#pragma mark - Table View Data Source
//link up the table datasource with database by setting the fetchResultController implemented in CoreDataTableViewController
- (void)setupFetchedResultsController // attaches an NSFetchRequest to this UITableViewController
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Items"];
    request.sortDescriptors =[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name"
     ascending:YES
     selector:@selector(compare:)]];
    request.predicate = [NSPredicate predicateWithFormat:
                         @" (ANY itemstores_id.store_id = %@) "
                         ,  self.storeFilter ];
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                        managedObjectContext:self.listToDisplay.managedObjectContext
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];
}
//Invok the setup when the setListToDisplay Property is set
-(void) setListToDisplay: (Lists*) shoppingList 
{
    _listToDisplay = shoppingList;
    self.title = [shoppingList.name stringByAppendingString:@" filtered"];
    [self setupFetchedResultsController];
    NSLog(@"listToDisplay set to %@",[self.listToDisplay description]);
}
//Format the cell for table display
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray* font=self.mySettingManager.getFontSize;
    static NSString *CellIdentifier = @"List Entry Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    Contains *listEntry = nil;
    Items* item = [self.fetchedResultsController objectAtIndexPath:indexPath]; 
    for (listEntry in item.contains_id) {
        if ([listEntry.list_id isEqual:self.listToDisplay]) {
            break;
        }
    }
    cell.textLabel.text = @"";
    if(listEntry.quantity)
        cell.textLabel.text = [[cell.textLabel.text stringByAppendingString:listEntry.quantity.description] stringByAppendingString:@" "];
    if(listEntry.item_id.unit.name)
        cell.textLabel.text= [[cell.textLabel.text stringByAppendingString:listEntry.item_id.unit.name] stringByAppendingString:@" "];
    if(listEntry.item_id.name)
        cell.textLabel.text =[cell.textLabel.text stringByAppendingString:listEntry.item_id.name];
    cell.detailTextLabel.text = listEntry.item_id.tags;
    if ([listEntry isChecked] == YES)
    {
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        cell.textLabel.textColor = [UIColor lightGrayColor];
        cell.editingAccessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        cell.textLabel.font = [font objectAtIndex:0];
        cell.detailTextLabel.font = [font objectAtIndex:1];
        cell.imageView.image = [UIImage imageNamed:@"checkMark.png"];
    }
    else 
    {
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        cell.textLabel.textColor = [UIColor darkTextColor];
        cell.editingAccessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        cell.textLabel.font = [font objectAtIndex:0];
        cell.detailTextLabel.font = [font objectAtIndex:1];
        cell.imageView.image = [UIImage imageNamed:@"noCheckMark.png"];
        
    }
    return cell;
}



//set the listEntry property of the EditDetail view, so that it can access the database
#pragma mark - UITableViewDeligate
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    EditingItemDetailTableViewControllerViewController * entryDetail =[self.storyboard instantiateViewControllerWithIdentifier:@"entryDetail"];
    Contains *listEntry = nil;
    Items* item = [self.fetchedResultsController objectAtIndexPath:indexPath]; 
    for (listEntry in item.contains_id) {
        if ([listEntry.list_id isEqual:self.listToDisplay]) {
            break;
        }
    }
    [self.navigationController pushViewController:entryDetail animated:YES];
}
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Contains *listEntry = nil;
    Items* item = [self.fetchedResultsController objectAtIndexPath:indexPath]; 
    for (listEntry in item.contains_id) {
        if ([listEntry.list_id isEqual:self.listToDisplay]) {
            break;
        }
    }
    self.listEntry= listEntry;
    [self.listEntry toggleChecked];
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:YES animated:NO];
    if(self.mySettingManager.whetherHideItemImediately)
    {
        for(Contains* temp in self.listToDisplay.contains_id)
        {
            if([temp isChecked]== TRUE)
                [temp cleanItem];
        }
    }
    [self.tableView reloadData];
    [self setSubtotalLable];
    
}
-(UITableViewCellEditingStyle) tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Contains *listEntry = nil;
    Items* item = [self.fetchedResultsController objectAtIndexPath:indexPath]; 
    for (listEntry in item.contains_id) {
        if ([listEntry.list_id isEqual:self.listToDisplay]) {
            break;
        }
    }

    Contains * temp = listEntry; 
    if(![temp needDisplay])
        return UITableViewCellEditingStyleInsert;
    else 
        return UITableViewCellEditingStyleDelete;
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleInsert)
    {
        Contains *listEntry = nil;
        Items* item = [self.fetchedResultsController objectAtIndexPath:indexPath]; 
        for (listEntry in item.contains_id) {
            if ([listEntry.list_id isEqual:self.listToDisplay]) {
                break;
            }
        }
        
        Contains * temp = listEntry;         [temp rescueItem];
        [tableView reloadData];
    }
    else if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        Contains *listEntry = nil;
        Items* item = [self.fetchedResultsController objectAtIndexPath:indexPath]; 
        for (listEntry in item.contains_id) {
            if ([listEntry.list_id isEqual:self.listToDisplay]) {
                break;
            }
        }
        
        Contains * temp = listEntry;         [self.listToDisplay.managedObjectContext deleteObject:temp];
    }
    [self setSubtotalLable];
    
}
#pragma mark - generated code
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView
 {
 }
 */

/*
 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
 - (void)viewDidLoad
 {
 [super viewDidLoad];
 }
 */


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupFetchedResultsController];
    [self.tableView reloadData];
    [self setSubtotalLable];
    
}

- (void)viewDidUnload
{
    [self setPriceLable:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
