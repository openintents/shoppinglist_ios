//
//  OptionsTableViewController.h
//  OIShoppingList
//
//  Created by Tian Hongyu on 18/5/12.
//  Copyright (c) 2012 OpenIntents. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FontSizeAndSortingRuleSelectionProtocol
-(void) applyFontSize:(NSString*)fontSize;
-(void) applySortingRule:(NSArray*)sortBy;
@end//of protocal



@interface OptionsTableViewController : UITableViewController <FontSizeAndSortingRuleSelectionProtocol>

@end
