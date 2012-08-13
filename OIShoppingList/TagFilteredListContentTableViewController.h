//
//  TagFilteredListContentTableViewController.h
//  OIShoppingList
//
//  Created by Tian Hongyu on 21/7/12.
//  Copyright (c) 2012 OpenIntents. All rights reserved.
//
/*************
 This view controller displays a list with a tag filter applied.
 Only the entries with the specified filter would be displied
 
 Property "listToDisplay" and "tagFilter" should be set before presenting the controller.
 *************/
#import <MessageUI/MessageUI.h>
#import "CoreDataTableViewController.h"
#import "Lists+Manage.h"
#import "Items+Manage.h"
#import "Contains+Manage.h"

@interface TagFilteredListContentTableViewController : CoreDataTableViewController

@property (strong,nonatomic) Lists* listToDisplay;
@property (strong,nonatomic) NSString* tagFilter;
@end
