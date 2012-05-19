//
//  SelectFontSizeTableViewController.m
//  OIShoppingList
//
//  Created by Tian Hongyu on 19/5/12.
//  Copyright (c) 2012 OpenIntents. All rights reserved.
//

#import "SelectFontSizeTableViewController.h"

@interface SelectFontSizeTableViewController ()

@end
/*allowed value for font size:
 @"font size big"
 @"font size standard"
 @"font size small"
 */

@implementation SelectFontSizeTableViewController
@synthesize deligate = _deligate;

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
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
            cell.textLabel.text=@"Big";
            break;
        case 1:
            cell.textLabel.text=@"Standard";
            break;
        case 2:
            cell.textLabel.text=@"Small";
            break;
            
        default:
            break;
    }
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* temp = @"";
    switch (indexPath.row) {
        case 0:
            temp = @"font size big";
            break;
        case 1:
            temp = @"font size standard";
            break;
        case 2:
            temp = @"font size small";
            break;
            
        default:
            NSLog(@"error occured when selecting at index path: %@", [indexPath description]);
            break;
    }
    [self.deligate applyFontSize:temp];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
