//
//  ShoppingListTableViewController.m
//  OIShoppingList
//
//  Created by Tian Hongyu on 11/5/12.
//  Copyright (c) 2012 OpenIntents. All rights reserved.
//

#import "ShoppingListTableViewController.h"
#import "Lists+Manage.h"

@interface ShoppingListTableViewController()
@property (strong, nonatomic) IBOutlet UIScrollView *myScrollView;
@property (strong, nonatomic) IBOutlet UITextField *myTextField;
@end


@implementation ShoppingListTableViewController
@synthesize shoppingListDocument=_shoppingListDocument;
@synthesize myScrollView = _myScrollView;
@synthesize myTextField=_myTextField;

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
    if (![[NSFileManager defaultManager] fileExistsAtPath:[self.shoppingListDocument.fileURL path]]) {
        // does not exist on disk, so create it
        [self.shoppingListDocument saveToURL:self.shoppingListDocument.fileURL forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
            if(self.debug)
                NSLog(@"[Does not exist on disk]\ndocument created? %@!",(success? @"yes":@"no"));
            [self setupFetchedResultsController];   
            
        }];
    } else if (self.shoppingListDocument.documentState == UIDocumentStateClosed) {
        // exists on disk, but we need to open it
        [self.shoppingListDocument openWithCompletionHandler:^(BOOL success) {
            if(self.debug)
                NSLog(@"[Open exiting file]\ndocument opened? %@!",(success? @"yes":@"no"));
            [self setupFetchedResultsController];        }];
    } else if (self.shoppingListDocument.documentState == UIDocumentStateNormal) {
        if(self.debug)
            NSLog(@"[existed]");
        // already open and ready to use
        [self setupFetchedResultsController];
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



- (IBAction)creatNewList:(id)sender {
    NSString * listTittle =[[NSDate date] description];
    [Lists createShoppingListWithName:listTittle inManagedObjectContext:[self.shoppingListDocument managedObjectContext]];
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    Boolean debug =0;
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.myScrollView.contentInset = contentInsets;
    self.myScrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your application might not need or want this behavior.
    
    
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    
    if (debug) {
        aRect = self.myTextField.frame;
        NSLog(@"%f,%f,%f,%f",aRect.origin.x, aRect.origin.y , aRect.size.width, aRect.size.height);
        aRect = self.view.frame;
        NSLog(@"%f,%f,%f,%f",aRect.origin.x, aRect.origin.y , aRect.size.width, aRect.size.height);
    }
    if (!CGRectContainsPoint(aRect, self.myTextField.frame.origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, self.myTextField.frame.origin.y-kbSize.height+self.myTextField.frame.size.height*2);
        if(debug)
            NSLog(@"%f",scrollPoint.y);
        [self.myScrollView setContentOffset:scrollPoint animated:YES];
        
        if (debug) {
            aRect= self.myTextField.frame;
            NSLog(@"%f,%f,%f,%f",aRect.origin.x, aRect.origin.y , aRect.size.width, aRect.size.height);
        }
    }
}
- (void)keyboardWasShownNotUsing:(NSNotification*)aNotification {
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    CGRect bkgndRect = self.myTextField.superview.frame;
    bkgndRect.size.height += kbSize.height;
    [self.myTextField.superview setFrame:bkgndRect];
    [self.myScrollView setContentOffset:CGPointMake(0.0, self.myTextField.frame.origin.y-kbSize.height) animated:YES];
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.myScrollView.contentInset = contentInsets;
    self.myScrollView.scrollIndicatorInsets = contentInsets;
}


// Call this method somewhere in your view controller setup code.
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)unregisterForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}




//######################################
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
    cell.detailTextLabel.text = [shoppingList.created description ] ;
    
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
    self.debug=1;
    [self registerForKeyboardNotifications];
}

- (void)viewDidUnload
{
    [self setMyTextField:nil];
    [self setMyScrollView:nil];
    [self unregisterForKeyboardNotifications];
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

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
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
*/

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
- (IBAction)finishTyping:(id)sender {
    [sender resignFirstResponder];
    //NSLog(@"%@",(self.myTextField.text==nil? @"yes":@"no" ));
    if(![self.myTextField.text isEqualToString:@""])
    {
        [Lists createShoppingListWithName:self.myTextField.text inManagedObjectContext:[self.shoppingListDocument managedObjectContext]];
    }
    self.myTextField.text = @"";
}


@end
