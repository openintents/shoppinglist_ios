//
//  ShoppingListTableViewController.h
//  OIShoppingList
//
//  Created by Tian Hongyu on 11/5/12.
//  Copyright (c) 2012 OpenIntents. All rights reserved.
//
#import "CoreDataTableViewController.h"

#import <UIKit/UIKit.h>

@interface ShoppingListTableViewController : CoreDataTableViewController

@property (nonatomic, strong) UIManagedDocument *shoppingListDocument;

@end
