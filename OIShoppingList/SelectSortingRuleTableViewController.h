//
//  SelectSortingRuleTableViewController.h
//  OIShoppingList
//
//  Created by Tian Hongyu on 19/5/12.
//  Copyright (c) 2012 OpenIntents. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OptionsTableViewController.h"

@interface SelectSortingRuleTableViewController : UITableViewController

@property  (weak,nonatomic) id<FontSizeAndSortingRuleSelectionProtocol> deligate;

@end
