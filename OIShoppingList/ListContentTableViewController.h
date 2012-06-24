//
//  ListContentTableViewController.h
//  OIShoppingList
//
//  Created by Tian Hongyu on 12/5/12.
//  Copyright (c) 2012 OpenIntents. All rights reserved.
//

#import <MessageUI/MessageUI.h>
#import "CoreDataTableViewController.h"
#import "Lists+Manage.h"
#import "Items+Manage.h"
#import "Contains+Manage.h"

@interface ListContentTableViewController : CoreDataTableViewController <UITableViewDelegate, UIActionSheetDelegate>

@property (nonatomic, strong) Lists* listToDisplay;

@end
