//
//  EditingItemDetailTableViewControllerViewController.h
//  OIShoppingList
//
//  Created by Tian Hongyu on 21/6/12.
//  Copyright (c) 2012 OpenIntents. All rights reserved.
//
/***********
 This view controller displays the fields that are associated with a certain item and enables user to edit the various fields.
 
 In order to display and manage the store-wise price calculation, the application would sague to "PriceStoreTableViewController" when price is selected.
 
 For this controller to work, the "entry" property must be set correctly whent the controller is loaded from storyboard.
 **********/
#import <UIKit/UIKit.h>
#import "ListContentTableViewController.h"
#import "Contains+Manage.h"
#import "Items+Manage.h"
#import "Units+Manage.h"


@interface EditingItemDetailTableViewControllerViewController : UITableViewController<UIPickerViewDelegate>
@property (nonatomic, strong) Contains * entry;

@end
