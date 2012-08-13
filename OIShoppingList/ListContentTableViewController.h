//
//  ListContentTableViewController.h
//  OIShoppingList
//
//  Created by Tian Hongyu on 12/5/12.
//  Copyright (c) 2012 OpenIntents. All rights reserved.
//
/***********
this class displays a list that is selected by "ShoppingListTableViewController", which is stored in property"listToDisplay".
 
 This class, on its own, handle:
 edit list/view list button click;
 clean up button click.
 
 This controller segues to:
 "SelectTagFilterTableViewController" or "SelectStoreFilterTableViewController" when filter button is clicked;
 "OptionsTableViewControler" when options button is clicked.
 
 In order for the controller to work properly, its "listToDisplay" property should be set before the controller is presented to user.
**********/
#import <MessageUI/MessageUI.h>
#import "CoreDataTableViewController.h"
#import "Lists+Manage.h"
#import "Items+Manage.h"
#import "Contains+Manage.h"

@interface ListContentTableViewController : CoreDataTableViewController <UITableViewDelegate, UIActionSheetDelegate>

@property (nonatomic, strong) Lists* listToDisplay;
//this property is to be set when loading the controler from storyboard

@end
