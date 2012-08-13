//
//  ShoppingListTableViewController.h
//  OIShoppingList
//
//  Created by Tian Hongyu on 11/5/12.
//  Copyright (c) 2012 OpenIntents. All rights reserved.
//
/**********
 This class is the view controller that is first loaded when the app lunches
 
 shoppingListDocument would be the core data document that is used in the app.
 It would be opened and initilized properly when the activity indicator stops animating.
 **********/
#import "CoreDataTableViewController.h"

#import <UIKit/UIKit.h>

@interface ShoppingListTableViewController : CoreDataTableViewController

@property (nonatomic, strong) UIManagedDocument *shoppingListDocument;

@end
