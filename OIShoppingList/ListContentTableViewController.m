//
//  ListContentTableViewController.m
//  OIShoppingList
//
//  Created by Tian Hongyu on 12/5/12.
//  Copyright (c) 2012 OpenIntents. All rights reserved.
//
/***********
 this class displays a list that is selected by "ShoppingListTableViewController", which is stored in property"listToDisplay".
 
 This class, on its own, handle:
 edit list/view list button click;
 clean up button click.
 
 This controller segues to:
 "SelectTagFilterTableViewController" or "SelectStoreFilterTableViewController" when filter button is clicked;
 "OptionsTableViewControler" when options button is clicked.
 
 In order for the controller to work properly, its "listToDisplay" property should be set before the controller is presented to user.
 **********/

#import "ListContentTableViewController.h"
#import "EditingItemDetailTableViewControllerViewController.h"
#import "SelectStoreFilterTableViewController.h"
#import "SelectTagFilterTableViewController.h"
#import "ShoppingListSettingManager.h"
#import "Units.h"
@interface ListContentTableViewController()<MFMailComposeViewControllerDelegate,MFMessageComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *addNewItemTextField;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *cleanUp;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *share;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *editList;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *spacer;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *options;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *filter;
@property (strong,nonatomic) ShoppingListSettingManager * mySettingManager;

@property  int manageModeActive;
@property (strong,nonatomic) Contains *listEntry;
@property (strong,nonatomic) UIActionSheet* shareOption;
@property (strong, nonatomic) IBOutlet UILabel *priceLable;

@end


@implementation ListContentTableViewController

#pragma mark - suntheize, getter and setters

@synthesize addNewItemTextField = _addNewItemTextField;
@synthesize cleanUp = _cleanUp;
@synthesize share = _share;
@synthesize editList = _editList;
@synthesize spacer = _spacer;
@synthesize options = _options;
@synthesize filter = _filter;
@synthesize listToDisplay = _listToDisplay;
@synthesize listEntry =_listEntry;
@synthesize manageModeActive = _manageModeActive;
@synthesize mySettingManager = _mySettingManager;
@synthesize shareOption = _shareOption;
@synthesize priceLable = _priceLable;
-(ShoppingListSettingManager*) mySettingManager
{
    if (!_mySettingManager) {
        _mySettingManager = [[ShoppingListSettingManager alloc]init];
    }
    return _mySettingManager;
}
#pragma mark - Subtotal display
-(void)setSubtotalLable
{
    NSString* resultString = @"Subtotals:               ";
    NSSet* set=[self.listToDisplay getStoreWisePriceDescription];
    if (set.count >0) {
        for (NSDictionary* storeDic in set) {
            // @"subtotal",@"availablePrice",@"name"
            NSString* storeName = (NSString*)[storeDic objectForKey:@"name"];
            double storeSubtotal = [((NSNumber*)[storeDic objectForKey:@"subtotal"])doubleValue];
            NSString*temp = [NSString stringWithFormat:@"%@: $ %5.2lf\n",storeName,storeSubtotal];
            resultString = [resultString stringByAppendingString:temp];
        }

    }
    else {
        resultString = @"No price information available.\n";
    }
    self.priceLable.text = resultString;
}


#pragma mark - SMS sharing
-(NSString*)getSharedListInText
{
    NSString* text = @"";
    NSArray * list =[self.fetchedResultsController fetchedObjects];
    Contains *listEntry = nil; 

    for (listEntry in list) {
        if(listEntry.quantity)
            text = [[text stringByAppendingString:listEntry.quantity.description] stringByAppendingString:@" "];
        if(listEntry.item_id.unit)
            text= [[text stringByAppendingString:listEntry.item_id.unit.name] stringByAppendingString:@" "];
        if(listEntry.item_id)
            text =[text stringByAppendingString:listEntry.item_id.name];
        text = [text stringByAppendingString:@"\n"];
    }
    return text;

}

-(void)displaySMSComposerSheet
{
    if ([MFMessageComposeViewController canSendText]) {
        MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
        picker.messageComposeDelegate = self;
        
        NSString *smsBody = [self getSharedListInText];
        [picker setBody:smsBody];
        [self presentModalViewController:picker animated:YES];
        
    }
}
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissModalViewControllerAnimated:YES];
}
#pragma mark - Mail sharing

-(void)displayMailComposerSheet
{
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
        picker.mailComposeDelegate = self;
        
        [picker setSubject: self.listToDisplay.name];
        NSString *emailBody = [self getSharedListInText];
        [picker setMessageBody:emailBody isHTML:NO];
        
        [self presentModalViewController:picker animated:YES];

    }        
}

// The mail compose view controller delegate method
- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError *)error
{
    [self dismissModalViewControllerAnimated:YES];
}
# pragma mark - action sheet
-(UIActionSheet*) shareOption
{
    if (!_shareOption) {
        _shareOption = [[UIActionSheet alloc] initWithTitle:@"share" delegate:self cancelButtonTitle:@"cancel" destructiveButtonTitle:nil otherButtonTitles:@"SMS",@"Email", nil];
    }
    return _shareOption;
}
- (IBAction)shareClicked:(id)sender {
    [self.shareOption showFromToolbar:self.navigationController.toolbar];
}
- (IBAction)filterClicked:(id)sender {
    [[[UIActionSheet alloc] initWithTitle:@"filter" delegate:self cancelButtonTitle:@"cancel" destructiveButtonTitle:nil otherButtonTitles:@"Filter By Store",@"Filter By Tags", nil] showFromToolbar:self.navigationController.toolbar];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([@"share" isEqualToString: actionSheet.title ]) {
        if (buttonIndex==0) {
            [self displaySMSComposerSheet];
        }else if (buttonIndex==1) {
            [self displayMailComposerSheet];
        }else {
            // [self.shareOption dismissWithClickedButtonIndex:3 animated:YES];
        }
    }
    else if ([@"filter" isEqualToString:actionSheet.title]) {
        if (buttonIndex==0) {
            SelectStoreFilterTableViewController* destController = [self.navigationController.storyboard instantiateViewControllerWithIdentifier:@"Select Store Filter"];
            destController.listToDisplay = self.listToDisplay;
            [self.navigationController pushViewController:destController animated:YES];
        }else if (buttonIndex==1) {
            SelectTagFilterTableViewController* destController = [self.navigationController.storyboard instantiateViewControllerWithIdentifier:@"Select Tag Filter"];
            destController.listToDisplay = self.listToDisplay;
            [self.navigationController pushViewController:destController animated:YES];
        }else {
            // [self.shareOption dismissWithClickedButtonIndex:3 animated:YES];
        }

    }
}


#pragma mark - Table View Data Source
//link up the table datasource with database by setting the fetchResultController implemented in CoreDataTableViewController
- (void)setupFetchedResultsController // attaches an NSFetchRequest to this UITableViewController
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Contains"];
    request.sortDescriptors = self.mySettingManager.getSortDescriptor;
    /*=[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"quantity"
                                                                                     ascending:YES
                                                                                      selector:@selector(compare:)]];*/
    request.predicate = [NSPredicate predicateWithFormat:
                         (self.manageModeActive? @"list_id.name = %@": @"(list_id.name = %@) AND (status != 2)")
                         , self.listToDisplay.name];
    
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                        managedObjectContext:self.listToDisplay.managedObjectContext
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];
}
//Invok the setup when the setListToDisplay Property is set
-(void) setListToDisplay: (Lists*) shoppingList 
{
    _listToDisplay = shoppingList;
    self.title = shoppingList.name;
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
    Contains *listEntry = [self.fetchedResultsController objectAtIndexPath:indexPath]; 
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



#pragma mark - UI button and toolbar

- (IBAction)cleanUp:(UITabBarItem *)sender 
{
    for(Contains* temp in self.listToDisplay.contains_id)
    {
        if([temp isChecked]== TRUE)
            [temp cleanItem];
        [self.tableView reloadData];
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
        [self.listToDisplay addItemWithName:sender.text inManagedObjectContext:self.listToDisplay.managedObjectContext];
    }
    sender.text = @"";
}

//set the toolbar hiden to no and add the buttons into view
-(void) displayUIToolBar
{    
    self.navigationController.toolbarHidden = NO; 
    NSMutableArray* toolbarItems = [[NSMutableArray alloc]init];
    [toolbarItems addObject:self.share];
    [toolbarItems addObject: self.editList];
    [toolbarItems addObject:self.filter];
    [toolbarItems addObject:self.spacer];
    [toolbarItems addObject:self.options];
    [self.navigationController.toolbar setItems:[NSArray arrayWithArray:toolbarItems]  animated:YES];
}

//set the listEntry property of the EditDetail view, so that it can access the database


#pragma mark - UITableViewDeligate
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.destinationViewController respondsToSelector:@selector(setEntry:)]) {
        [segue.destinationViewController performSelector:@selector(setEntry:) withObject:self.listEntry];
    }
    if ([segue.destinationViewController respondsToSelector:@selector(setListToDisplay:)]) {
        [segue.destinationViewController performSelector:@selector(setListToDisplay:)withObject:self.listToDisplay];
        NSLog(@"setDestinationListToDisplay");
    }
}
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    EditingItemDetailTableViewControllerViewController * entryDetail =[self.storyboard instantiateViewControllerWithIdentifier:@"entryDetail"];
    entryDetail.entry = [self.fetchedResultsController objectAtIndexPath:indexPath]; 
    [self.navigationController pushViewController:entryDetail animated:YES];
}
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.listEntry = [self.fetchedResultsController objectAtIndexPath:indexPath]; 
    [self.listEntry toggleChecked];
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:YES animated:NO];
    if(self.mySettingManager.whetherHideItemImediately)
    {
        for(Contains* temp in self.listToDisplay.contains_id)
        {
            if([temp isChecked]== TRUE)
                [temp cleanItem];
            [self.tableView reloadData];
        }
    }
    [self setSubtotalLable];

}
-(UITableViewCellEditingStyle) tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Contains * temp = [self.fetchedResultsController objectAtIndexPath:indexPath]; 
    if(![temp needDisplay])
        return UITableViewCellEditingStyleInsert;
    else 
        return UITableViewCellEditingStyleDelete;

}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleInsert)
    {
        Contains * temp = [self.fetchedResultsController objectAtIndexPath:indexPath]; 
        [temp rescueItem];
        [tableView reloadData];
    }
    else if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        Contains * temp = [self.fetchedResultsController objectAtIndexPath:indexPath]; 
        [self.listToDisplay.managedObjectContext deleteObject:temp];
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
    [self displayUIToolBar];
    [self setupFetchedResultsController];
    [self.tableView reloadData];
    [self setSubtotalLable];
    
}

- (void)viewDidUnload
{
    [self setAddNewItemTextField:nil];
    [self setCleanUp:nil];
    [self setShare:nil];
    [self setEditList:nil];
    [self setSpacer:nil];
    [self setOptions:nil];
    [self setPriceLable:nil];
    [self setFilter:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return YES;
}

@end
