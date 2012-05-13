//
//  ListContentTableViewController.m
//  OIShoppingList
//
//  Created by Tian Hongyu on 12/5/12.
//  Copyright (c) 2012 OpenIntents. All rights reserved.
//

#import "ListContentTableViewController.h"
#import "EditEntryViewController.h"
@interface ListContentTableViewController()
@property (weak, nonatomic) IBOutlet UITextField *addNewItemTextField;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *cleanUp;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *details;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *editList;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *spacer;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *options;

@property  int manageModeActive;
@property (strong,nonatomic) ListEntry *listEntry;

@end


@implementation ListContentTableViewController
@synthesize addNewItemTextField = _addNewItemTextField;
@synthesize cleanUp = _cleanUp;
@synthesize details = _Details;
@synthesize editList = _editList;
@synthesize spacer = _spacer;
@synthesize options = _options;
@synthesize listToDisplay = _listToDisplay;
@synthesize listEntry =_listEntry;
@synthesize manageModeActive = _manageModeActive;
#pragma mark - Table View Data Source
//link up the table datasource with database by setting the fetchResultController implemented in CoreDataTableViewController
- (void)setupFetchedResultsController // attaches an NSFetchRequest to this UITableViewController
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"ListEntry"];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"tittle"
                                                                                     ascending:YES
                                                                                      selector:@selector(localizedCaseInsensitiveCompare:)]];
    request.predicate = [NSPredicate predicateWithFormat:
                         (self.manageModeActive? @"listedIn.tittle = %@": @"(listedIn.tittle = %@) AND (display == TRUE)")
                         , self.listToDisplay.tittle];
    
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                        managedObjectContext:self.listToDisplay.managedObjectContext
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];
}
//Invok the setup when the setListToDisplay Property is set
-(void) setListToDisplay: (ShoppingList*) shoppingList 
{
    _listToDisplay = shoppingList;
    self.title = shoppingList.tittle;
    [self setupFetchedResultsController];
}
//Format the cell for table display
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"List Entry Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    ListEntry *listEntry = [self.fetchedResultsController objectAtIndexPath:indexPath]; 
    cell.textLabel.text = @"";
    if(listEntry.quantity)
        cell.textLabel.text = [[cell.textLabel.text stringByAppendingString:listEntry.quantity.description] stringByAppendingString:@" "];
    if(listEntry.unit)
        cell.textLabel.text= [[cell.textLabel.text stringByAppendingString:listEntry.unit] stringByAppendingString:@" "];
    if(listEntry.tittle)
        cell.textLabel.text =[cell.textLabel.text stringByAppendingString:listEntry.tittle];
    cell.detailTextLabel.text = listEntry.tag;
    if ([listEntry.marked isEqualToNumber:[NSNumber numberWithBool:YES]])
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        cell.textLabel.textColor = [UIColor lightGrayColor];
        cell.editingAccessoryType = UITableViewCellAccessoryCheckmark;
    }
    else 
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.textColor = [UIColor darkTextColor];
        cell.editingAccessoryType = UITableViewCellAccessoryNone;

    }
    return cell;
}



#pragma mark - UI Related Configuration

- (IBAction)cleanUp:(UITabBarItem *)sender 
{
    for(ListEntry * temp in self.listToDisplay.needToBuy)
    {
        NSNumber * trueInNSNumber =[ NSNumber numberWithBool:TRUE];
        NSNumber * flaseInNSNumber =[ NSNumber numberWithBool:FALSE];
        if([temp.marked isEqualToNumber: trueInNSNumber])
            temp.display = flaseInNSNumber;
    }
}
- (IBAction)toggleManageMode:(id)sender {
    if (self.manageModeActive== 0) {
        self.manageModeActive = 1;
        self.editList.title = @"View List";
        [self setupFetchedResultsController];
        [self.tableView setEditing:YES animated:YES];
        [self.tableView reloadData];
        
    }else
    {
        self.manageModeActive = 0;
        self.editList.title = @"Edit List";
        [self setupFetchedResultsController];
        [self.tableView setEditing:NO animated:YES];
        [self.tableView reloadData];
    }
}


- (IBAction)addEntryTextFieldFinishTyping:(UITextField *)sender {
    [sender resignFirstResponder];
    if(![self.addNewItemTextField.text isEqualToString:@""])
    {
        ListEntry * newEntry = [ListEntry creatListEntryWithTittle:sender.text inManagedObjectContext:self.listToDisplay.managedObjectContext];
        [self.listToDisplay addEntry:newEntry];    }
    sender.text = @"";
}

//set the toolbar hiden to no and add the buttons into view
-(void) displayUIToolBar
{    
    self.navigationController.toolbarHidden = NO; 
    NSMutableArray* toolbarItems = [[NSMutableArray alloc]init];
    [toolbarItems addObject:self.details];
    [toolbarItems addObject: self.editList];
    [toolbarItems addObject:self.spacer];
    [toolbarItems addObject:self.options];
    [self.navigationController.toolbar setItems:[NSArray arrayWithArray:toolbarItems]  animated:YES];
}

//set the listEntry property of the EditDetail view, so that it can access the database
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.destinationViewController respondsToSelector:@selector(setEntry:)]) {
        [segue.destinationViewController performSelector:@selector(setEntry:) withObject:self.listEntry];
    }
}
#pragma mark - UITableViewDeligate

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.suspendAutomaticTrackingOfChangesInManagedObjectContext = YES;
    self.listEntry = [self.fetchedResultsController objectAtIndexPath:indexPath]; 
    self.listEntry.marked = [NSNumber numberWithBool:[self.listEntry.marked isEqualToNumber:[NSNumber numberWithBool:NO]]];
    [tableView reloadData];
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:YES animated:NO];
    self.suspendAutomaticTrackingOfChangesInManagedObjectContext = NO;

}
-(UITableViewCellEditingStyle) tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ListEntry * temp = [self.fetchedResultsController objectAtIndexPath:indexPath]; 
    NSLog(@"%@",temp.tittle);
    if([temp.display isEqualToNumber:[NSNumber numberWithInt:0]])
        return UITableViewCellEditingStyleInsert;
    else 
        return UITableViewCellEditingStyleNone;

}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleInsert)
    {
        ListEntry * temp = [self.fetchedResultsController objectAtIndexPath:indexPath]; 
        temp.display=[NSNumber numberWithBool:TRUE];
        temp.marked = [NSNumber numberWithBool:FALSE];
        [tableView reloadData];
    }
    else if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        ListEntry * temp = [self.fetchedResultsController objectAtIndexPath:indexPath]; 
        ShoppingList * tempList = temp.listedIn;
        NSMutableArray * tempMutable = [temp.listedIn mutableCopy];
        [tempMutable removeObject: temp];
        tempList.needToBuy = [NSArray arrayWithArray:tempMutable];
        [tableView reloadData];
    }
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
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self displayUIToolBar];

}

- (void)viewDidUnload
{
    [self setAddNewItemTextField:nil];
    [self setCleanUp:nil];
    [self setDetails:nil];
    [self setEditList:nil];
    [self setSpacer:nil];
    [self setOptions:nil];
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
