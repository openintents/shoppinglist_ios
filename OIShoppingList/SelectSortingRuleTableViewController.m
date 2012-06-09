//
//  SelectSortingRuleTableViewController.m
//  OIShoppingList
//
//  Created by Tian Hongyu on 19/5/12.
//  Copyright (c) 2012 OpenIntents. All rights reserved.
//

#import "SelectSortingRuleTableViewController.h"

@interface SelectSortingRuleTableViewController ()<MFMailComposeViewControllerDelegate,MFMessageComposeViewControllerDelegate>
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
    return self.mySortingOrder.count;
}
-(NSString*) rephraseSortingRule: (NSString*)rule
{
    NSString* rephrasedRule;
    if ([rule isEqualToString:  @"sorting order checked"]) {
        rephrasedRule = @"Checked First";
    }else if([rule isEqualToString:  @"sorting order alphabetical"]) {
        rephrasedRule = @"Alphabetical Order";
    }else if([rule isEqualToString: @"sorting order newest"]) {
        rephrasedRule = @"Newest first";
    }else if([rule isEqualToString:  @"sorting order tag"]) {
        rephrasedRule = @"Tagged first";
    }else if([rule isEqualToString:  @"sorting order prioriety"]) {
        rephrasedRule = @"Prioriety first";
    }else if([rule isEqualToString:  @"sorting order price"]) {
        rephrasedRule = @"Lower price first";
    }
    return rephrasedRule;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"font size selection cells";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
            cell.textLabel.text=[self rephraseSortingRule: [self.mySortingOrder objectAtIndex:indexPath.row]];
            cell.showsReorderControl = YES;
            [cell setEditing:YES animated:YES];
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
    self.mySortingOrder = [ NSMutableArray arrayWithArray:[self.deligate getSettingManager].sortingOrder];
}
-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView setEditing:YES animated:NO];
}
@end
