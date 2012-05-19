//
//  ShoppingListSettingManager.h
//  OIShoppingList
//
//  Created by Tian Hongyu on 18/5/12.
//  Copyright (c) 2012 OpenIntents. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShoppingListSettingManager : NSObject

@property (strong, nonatomic) NSArray*  sortingOrder;
@property (strong, nonatomic) NSString*  fontSize;
@property Boolean whetherShowFilter;
@property Boolean whetherHideItemImediately;

-(void) setAppToFactorySetting;
-(NSString *) inspectSetting;
-(NSString *) showSortingOrder;
@end
