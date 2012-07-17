//
//  PriceStoreTableViewController.h
//  OIShoppingList
//
//  Created by Tian Hongyu on 16/7/12.
//  Copyright (c) 2012 OpenIntents. All rights reserved.
//

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
