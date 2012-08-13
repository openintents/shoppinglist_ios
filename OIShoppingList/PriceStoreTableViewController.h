//
//  PriceStoreTableViewController.h
//  OIShoppingList
//
//  Created by Tian Hongyu on 16/7/12.
//  Copyright (c) 2012 OpenIntents. All rights reserved.
//
/**************
 This class displays the name of all the stores that are associated with a list and the price information, if available, that are associated with a certain item.
 
 When clilcking on the text fielt that are located within each cell, user would be able to key in the price for an item in a store.
 
 In order for the controller to work, property "contain" should be set.
 *************/
#import "CoreDataTableViewController.h"
#import "Contains+Manage.h"
#import "Items+Manage.h"
#import "Stores.h"
#import "Itemsstores.h"
#import "PriceTextField.h"
#import <UIKit/UIKit.h>

@interface PriceStoreTableViewController :  CoreDataTableViewController<UITextFieldDelegate>
@property (strong , nonatomic) Contains *contain;
@end
