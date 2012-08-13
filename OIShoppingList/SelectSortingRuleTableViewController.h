//
//  SelectSortingRuleTableViewController.h
//  OIShoppingList
//
//  Created by Tian Hongyu on 19/5/12.
//  Copyright (c) 2012 OpenIntents. All rights reserved.
//
/**************
 This class allows user to reorder the sorting creteria.
 
 By dragging and reordering the sorting creteria, the class "OptionsTableViewController" would update the sorting predicates through delegation.
 ************/
#import <UIKit/UIKit.h>
#import "OptionsTableViewController.h"

@interface SelectSortingRuleTableViewController : UITableViewController

@property  (weak,nonatomic) id<FontSizeAndSortingRuleSelectionProtocol> deligate;

@end
