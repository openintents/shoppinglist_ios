//
//  OptionsTableViewController.h
//  OIShoppingList
//
//  Created by Tian Hongyu on 18/5/12.
//  Copyright (c) 2012 OpenIntents. All rights reserved.
//
/*************
 this class presents a static table view for adjusting settings.
 Delegation protocal for changing font size and sorting order is also implemented.
 *************/
#import <MessageUI/MessageUI.h>
#import <UIKit/UIKit.h>
#import "ShoppingListSettingManager.h"

@protocol FontSizeAndSortingRuleSelectionProtocol
-(void) applyFontSize:(NSString*)fontSize;
-(void) applySortingRule:(NSArray*)sortBy;
-(ShoppingListSettingManager*) getSettingManager;
@end//of protocal

//
@interface OptionsTableViewController : UITableViewController <FontSizeAndSortingRuleSelectionProtocol> 
@end
