//
//  SelectSortingRuleTableViewController.m
//  OIShoppingList
//
//  Created by Tian Hongyu on 19/5/12.
//  Copyright (c) 2012 OpenIntents. All rights reserved.
//

#import "SelectSortingRuleTableViewController.h"

@interface SelectSortingRuleTableViewController ()
@property (strong,nonatomic) NSMutableArray* mySortingOrder;

@end
/*allowed sorting order
@"sorting order checked"
@"sorting order alphabetical"
@"sorting order newest"
@"sorting order tag"
@"sorting order prioriety"
@"sorting order price"
 */
@implementation SelectSortingRuleTableViewController
@synthesize deligate=_deligate;

@synthesize mySortingOrder = _mySortingOrder;

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"font size selection cells";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    switch (indexPath.row) {
           
        case 0:
            cell.textLabel.text=@"Checked First";
            cell.showsReorderControl = YES;
            [cell setEditing:YES animated:YES];
            break;
        case 1:
            cell.textLabel.text=@"Alphabetical Order";
            cell.showsReorderControl = YES;
            [cell setEditing:YES animated:YES];
            break;
        case 2:
            cell.textLabel.text=@"Newest First";
            cell.showsReorderControl = YES;
            [cell setEditing:YES animated:YES];
            break;
        case 3:
            cell.textLabel.text=@"Tagged First";
            cell.showsReorderControl = YES;
            [cell setEditing:YES animated:YES];
            break;
        case 4:
            cell.textLabel.text=@"Higher Prioriety First";
            cell.showsReorderControl = YES;
            [cell setEditing:YES animated:YES];
            break;
        case 5:
            cell.textLabel.text=@"Lower Price First";
            cell.showsReorderControl = YES;
            [cell setEditing:YES animated:YES];
            break;
        default:
            NSLog(@"error when selecting prioriety at index path: %@", indexPath.description);
            break;
    }
    return cell;
}

#pragma mark - Table view delegate



- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleNone;
}
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    NSString* temp = [self.mySortingOrder objectAtIndex:fromIndexPath.row];
    [self.mySortingOrder removeObjectAtIndex:fromIndexPath.row];
    [self.mySortingOrder insertObject: temp atIndex:toIndexPath.row];
    [self.deligate applySortingRule:[[NSArray alloc] initWithArray:self.mySortingOrder]];
    NSLog(@"%@", self.mySortingOrder.description);
}

-(void) viewDidLoad
{
    [super viewDidLoad];
    self.mySortingOrder = [NSMutableArray arrayWithObjects: @"sorting order checked",
                                                            @"sorting order alphabetical",
                                                            @"sorting order newest",
                                                            @"sorting order tag",
                                                            @"sorting order prioriety",
                                                            @"sorting order price", nil
                           ];
}
-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView setEditing:YES animated:NO];
}
@end
