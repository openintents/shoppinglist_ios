//
//  ShoppingListSettingManager.h
//  OIShoppingList
//
//  Created by Tian Hongyu on 18/5/12.
//  Copyright (c) 2012 OpenIntents. All rights reserved.
//
/**************
 Instances of this class manages and updates the setting stored in NSUserDefaults.
 
 Synchronization has been added to the setters of properties. And the getter reads from NSUserDefault for its value.
 Therefore, any changes in one instance of this class would also be reflected in other instances.
 **************/
#import <Foundation/Foundation.h>

@interface ShoppingListSettingManager : NSObject

@property (strong, nonatomic) NSArray*  sortingOrder;
@property (strong, nonatomic) NSString*  fontSize;
@property Boolean whetherShowFilter;
@property Boolean whetherHideItemImediately;

-(void) setAppToFactorySetting;
-(NSString *) inspectSetting;
-(NSString *) showSortingOrder;
-(NSArray *) getSortDescriptor;
-(NSArray *) getFontSize;
@end
