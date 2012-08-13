//
//  SelectStoreFilterTableViewController.h
//  OIShoppingList
//
//  Created by Tian Hongyu on 21/7/12.
//  Copyright (c) 2012 OpenIntents. All rights reserved.
//
/**************
 This view controller displays all the stores that a list contains and lets user select one to apply.
 
 property "listToDisplay" should be set before loading the list.
 
 Upon clicking on one of the rows, a segue to the controller "StoreFilteredListContentTableViewController" would be performed.
 ***************/
#import "CoreDataTableViewController.h"
#import "Lists+Manage.h"
#import "Stores+Manage.h"
#import "StoreFilteredListContentTableViewController.h"

@interface SelectStoreFilterTableViewController : CoreDataTableViewController

@property (strong,nonatomic) Lists* listToDisplay;
@end
