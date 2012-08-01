//
//  SelectTagFilterTableViewController.h
//  OIShoppingList
//
//  Created by Tian Hongyu on 21/7/12.
//  Copyright (c) 2012 OpenIntents. All rights reserved.
//

#import "CoreDataTableViewController.h"
#include "Lists.h"
#include "Contains.h"
#include "Items.h"
#include "TagFilteredListContentTableViewController.h"

@interface SelectTagFilterTableViewController : UITableViewController

@property (strong,nonatomic) Lists* listToDisplay;

@end
