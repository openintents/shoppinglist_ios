//
//  SelectTagFilterTableViewController.m
//  OIShoppingList
//
//  Created by Tian Hongyu on 21/7/12.
//  Copyright (c) 2012 OpenIntents. All rights reserved.
//

#import "SelectTagFilterTableViewController.h"

@interface SelectTagFilterTableViewController ()
@property (strong, nonatomic) NSMutableArray* listContent;

@end

@implementation SelectTagFilterTableViewController

@synthesize listToDisplay = _listToDisplay;
@synthesize listContent=_listContent;

-(NSMutableArray*) listContent
{
    if (!_listContent) {
        _listContent = [[NSMutableArray alloc]init];
    }
    return _listContent;
}

-(void) setListToDisplay:(Lists *)listToDisplay
{
    _listToDisplay = listToDisplay;
    
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:@"Contains"];
    request.sortDescriptors =[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"item_id.tags"
                                                                                    ascending:YES
                                                                                     selector:@selector(caseInsensitiveCompare:)]];
    
    request.predicate = [NSPredicate predicateWithFormat:@"item_id.tags != nil"];
    NSArray* result = nil;
    result = [[self.listToDisplay managedObjectContext] executeFetchRequest:request error: nil];
    NSString* lastTag = nil;
    for (Contains* contain in result) {
        if (![contain.item_id.tags isEqualToString:lastTag] ) {
            lastTag = contain.item_id.tags;
            [self.listContent addObject:contain.item_id.tags];
        }
    }
    
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TagFilteredListContentTableViewController* destinationController = [self.storyboard instantiateViewControllerWithIdentifier:@"tagFilteredListContent"];
    destinationController.listToDisplay = self.listToDisplay;
    destinationController.tagFilter = [self.listContent objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:destinationController animated:YES];
}


-(UITableViewCell*) tableView: tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"TagFilterSelectionCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [self.listContent objectAtIndex:indexPath.row];
    
    return cell;
}

-(int)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(int) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listContent.count;
}




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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
