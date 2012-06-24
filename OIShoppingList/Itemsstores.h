//
//  Itemsstores.h
//  OIShoppingList
//
//  Created by Tian Hongyu on 19/6/12.
//  Copyright (c) 2012 OpenIntents. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Items, Stores;

@interface Itemsstores : NSManagedObject

@property (nonatomic, retain) NSDate * created;
@property (nonatomic, retain) NSDate * modified;
@property (nonatomic, retain) NSNumber * price;
@property (nonatomic, retain) NSNumber * aisle;
@property (nonatomic, retain) NSNumber * stocks_item;
@property (nonatomic, retain) Items *item_id;
@property (nonatomic, retain) Stores *store_id;

@end
