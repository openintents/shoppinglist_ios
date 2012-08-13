//
//  ShoppingListTableViewController.m
//  OIShoppingList
//
//  Created by Tian Hongyu on 11/5/12.
//  Copyright (c) 2012 OpenIntents. All rights reserved.
//
/**********
 This class is the view controller that is first loaded when the app lunches
 
 shoppingListDocument would be the core data document that is used in the app.
 It would be opened and initilized properly when the activity indicator stops animating.
 **********/

#import "ShoppingListTableViewController.h"
#import "Lists+Manage.h"

@interface ShoppingListTableViewController()
@property (strong, nonatomic) IBOutlet UITextField *myTextField;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *myActivityIndicator;

@end


@implementation ShoppingListTableViewController
@synthesize shoppingListDocument=_shoppingListDocument;
@synthesize myTextField=_myTextField;
@synthesize myActivityIndicator = _myActivityIndicator;

#pragma mark - set up CoreData and open documents for use


- (void)setupFetchedResultsController // attaches an NSFetchRequest to this UITableViewController
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Lists"];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)]];
    // no predicate because we want ALL the Photographers
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                        managedObjectContext:self.shoppingListDocument.managedObjectContext
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];
}

- (void)useDocument
{
    self.myActivityIndicator.hidden = NO;
    [self.myActivityIndicator startAnimating];
    if (![[NSFileManager defaultManager] fileExistsAtPath:[self.shoppingListDocument.fileURL path]]) {
        // does not exist on disk, so create it
        [self.shoppingListDocument saveToURL:self.shoppingListDocument.fileURL forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
            if(self.debug)
                NSLog(@"[Does not exist on disk]\ndocument created? %@!",(success? @"yes":@"no"));
            [self setupFetchedResultsController];   
            [self.myActivityIndicator stopAnimating];
            
        }];
    } else if (self.shoppingListDocument.documentState == UIDocumentStateClosed) {
        // exists on disk, but we need to open it
        [self.shoppingListDocument openWithCompletionHandler:^(BOOL success) {
            if(self.debug)
                NSLog(@"[Open exiting file]\ndocument opened? %@!",(success? @"yes":@"no"));
            [self setupFetchedResultsController];  
            [self.myActivityIndicator stopAnimating];}];
    } else if (self.shoppingListDocument.documentState == UIDocumentStateNormal) {
        if(self.debug)
            NSLog(@"[existed]");
        // already open and ready to use
        [self setupFetchedResultsController];
        [self.myActivityIndicator stopAnimating];

    }
}


- (void)setShoppingListDocument:(UIManagedDocument *)shoppingListDocument
{
    if (_shoppingListDocument!=shoppingListDocument) {
        _shoppingListDocument=shoppingListDocument;
        [self useDocument];
    }
}



#pragma mark - other UI element handling

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    Lists *shoppingList = [self.fetchedResultsController objectAtIndexPath:indexPath];
    // be somewhat generic here (slightly advanced usage)
    // we'll segue to ANY view controller that has a photographer @property
    if ([segue.destinationViewController respondsToSelector:@selector(setListToDisplay:)]) {
        // use performSelector:withObject: to send without compiler checking
        // (which is acceptable here because we used introspection to be sure this is okay)
        [segue.destinationViewController performSelector:@selector(setListToDisplay:) withObject:shoppingList];
    }
}

- (IBAction)finishTyping:(id)sender {
    [sender resignFirstResponder];
    //NSLog(@"%@",(self.myTextField.text==nil? @"yes":@"no" ));
    if(![self.myTextField.text isEqualToString:@""])
    {
        [Lists createShoppingListWithName:self.myTextField.text inManagedObjectContext:[self.shoppingListDocument managedObjectContext]];
    }
    self.myTextField.text = @"";
}


/*
- (IBAction)creatNewList:(id)sender {
    NSString * listTittle =[[NSDate date] description];
    [Lists createShoppingListWithName:listTittle inManagedObjectContext:[self.shoppingListDocument managedObjectContext]];
}
*/



#pragma mark - Table view data source


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ShoppingListTable";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    Lists *shoppingList = [self.fetchedResultsController objectAtIndexPath:indexPath]; 
    cell.textLabel.text = shoppingList.name;
    cell.detailTextLabel.text = [[shoppingList.created description ] substringToIndex:10] ;
    
    return cell;
}



- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(UITableViewCellEditingStyle) tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
           return UITableViewCellEditingStyleDelete;
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete)
      {
          Lists* deleteList= [self.fetchedResultsController objectAtIndexPath:indexPath];
          [self.shoppingListDocument.managedObjectContext deleteObject:deleteList];
      }
}


#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!self.shoppingListDocument) {  
        NSURL *url = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
        url = [url URLByAppendingPathComponent:@"OIShoppinglistDatabase"];
        self.shoppingListDocument = [[UIManagedDocument alloc] initWithFileURL:url]; // setter will create this for us on disk
        if(self.debug)
            NSLog(@"setting shopping list document to: t%@", url.description);

    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.myActivityIndicator.hidesWhenStopped = YES;
    self.myActivityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [self.myActivityIndicator startAnimating];
    self.debug=1;
}

- (void)viewDidUnload
{
    [self setMyTextField:nil];
    [self setMyActivityIndicator:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


#pragma mark - View lifecycle(not Modified)




- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}



@end
