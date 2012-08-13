//
//  SelectFontSizeTableViewController.h
//  OIShoppingList
//
//  Created by Tian Hongyu on 19/5/12.
//  Copyright (c) 2012 OpenIntents. All rights reserved.
//
/***************
 This is a simple view controller that allows user to select font size.
 
 The setting would be applied through deligation, via "OptionsTableViewController" class.
 **************/

#import <UIKit/UIKit.h>
#import "OptionsTableViewController.h"

@interface SelectFontSizeTableViewController : UITableViewController

@property  (weak,nonatomic) id<FontSizeAndSortingRuleSelectionProtocol> deligate;

@end
