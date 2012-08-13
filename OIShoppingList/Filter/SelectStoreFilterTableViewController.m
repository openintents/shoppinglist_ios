//
//  SelectStoreFilterTableViewController.m
//  OIShoppingList
//
//  Created by Tian Hongyu on 21/7/12.
//  Copyright (c) 2012 OpenIntents. All rights reserved.
//
/**************
 This view controller displays all the stores that a list contains and lets user select one to apply.
 
 property "listToDisplay" should be set before loading the list.
 
 Upon clicking on one of the rows, a segue to the controller "StoreFilteredListContentTableViewController" would be performed.
 ***************/
#import "SelectStoreFilterTableViewController.h"

@interface SelectStoreFilterTableViewController ()

@end

@implementation SelectStoreFilterTableViewController

@synthesize listToDisplay = _listToDisplay;


- (void)setupFetchedResultsController // attaches an NSFetchRequest to this UITableViewController
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Stores"];
    request.sortDescriptors =[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"created"
                                                                                    ascending:YES
                                                                                     selector:@selector(compare:)]];
    request.predicate = [NSPredicate predicateWithFormat:@"list_id = %@", self.listToDisplay];
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                        managedObjectContext:self.listToDisplay.managedObjectContext
                                                                          sectionNameKeyPath:nil                                                                                        cacheName:nil];
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    StoreFilteredListContentTableViewController* destinationController = [self.storyboard instantiateViewControllerWithIdentifier:@"storeFilteredListContent"];
    destinationController.listToDisplay = self.listToDisplay;
    destinationController.storeFilter = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [self.navigationController pushViewController:destinationController animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"StoreFilterSelectionCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    Stores*store = [self.fetchedResultsController objectAtIndexPath:indexPath]; 
    cell.textLabel.text = store.name;
    
    return cell;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupFetchedResultsController];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
