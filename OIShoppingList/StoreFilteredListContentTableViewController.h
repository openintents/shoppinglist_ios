//
//  StoreFilteredListContentTableViewController.h
//  OIShoppingList
//
//  Created by Tian Hongyu on 21/7/12.
//  Copyright (c) 2012 OpenIntents. All rights reserved.
//

#import <MessageUI/MessageUI.h>
#import "CoreDataTableViewController.h"
#import "Lists+Manage.h"
#import "Items+Manage.h"
#import "Contains+Manage.h"


@interface StoreFilteredListContentTableViewController : CoreDataTableViewController<UITableViewDelegate, UIActionSheetDelegate>

@property (strong,nonatomic) Stores* storeFilter;
@property (nonatomic, strong) Lists* listToDisplay;

@end
