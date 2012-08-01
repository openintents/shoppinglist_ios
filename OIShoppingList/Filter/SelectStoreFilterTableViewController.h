//
//  SelectStoreFilterTableViewController.h
//  OIShoppingList
//
//  Created by Tian Hongyu on 21/7/12.
//  Copyright (c) 2012 OpenIntents. All rights reserved.
//

#import "CoreDataTableViewController.h"
#import "Lists+Manage.h"
#import "Stores+Manage.h"
#import "StoreFilteredListContentTableViewController.h"

@interface SelectStoreFilterTableViewController : CoreDataTableViewController

@property (strong,nonatomic) Lists* listToDisplay;
@end
