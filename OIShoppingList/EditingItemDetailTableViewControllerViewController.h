//
//  EditingItemDetailTableViewControllerViewController.h
//  OIShoppingList
//
//  Created by Tian Hongyu on 21/6/12.
//  Copyright (c) 2012 OpenIntents. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListContentTableViewController.h"
#import "Contains+Manage.h"
#import "Items+Manage.h"
#import "Units+Manage.h"


@interface EditingItemDetailTableViewControllerViewController : UITableViewController<UIPickerViewDelegate>
@property (nonatomic, strong) Contains * entry;

@end
