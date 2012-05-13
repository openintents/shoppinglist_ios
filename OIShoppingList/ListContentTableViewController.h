//
//  ListContentTableViewController.h
//  OIShoppingList
//
//  Created by Tian Hongyu on 12/5/12.
//  Copyright (c) 2012 OpenIntents. All rights reserved.
//

#import "CoreDataTableViewController.h"
#import "ShoppingList+Creat.h"
#import "ListEntry.h"

@interface ListContentTableViewController : CoreDataTableViewController <UITableViewDelegate>

@property (nonatomic, strong) ShoppingList* listToDisplay;

@end
