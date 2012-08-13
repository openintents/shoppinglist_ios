//
//  SelectTagFilterTableViewController.h
//  OIShoppingList
//
//  Created by Tian Hongyu on 21/7/12.
//  Copyright (c) 2012 OpenIntents. All rights reserved.
//
/**************
 This view controller displays all the tags that a list contains and lets user select one to apply.
 
 property "listToDisplay" should be set before loading the list.
 
 Upon clicking on one of the rows, a segue to the controller "TagFilteredListContentTableViewController" would be performed.
 ***************/
#import "CoreDataTableViewController.h"
#include "Lists.h"
#include "Contains.h"
#include "Items.h"
#include "TagFilteredListContentTableViewController.h"

@interface SelectTagFilterTableViewController : UITableViewController

@property (strong,nonatomic) Lists* listToDisplay;

@end
