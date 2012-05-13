//
//  Shop.h
//  OIShoppingList
//
//  Created by Tian Hongyu on 11/5/12.
//  Copyright (c) 2012 OpenIntents. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ItemsInStock, ListEntry;

@interface Shop : NSManagedObject

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSNumber * shopId;
@property (nonatomic, retain) NSDate * location;
@property (nonatomic, retain) NSString * tittle;
@property (nonatomic, retain) NSSet *hasEntry;
@property (nonatomic, retain) NSSet *itemsInStock;
@end

@interface Shop (CoreDataGeneratedAccessors)

- (void)addHasEntryObject:(ListEntry *)value;
- (void)removeHasEntryObject:(ListEntry *)value;
- (void)addHasEntry:(NSSet *)values;
- (void)removeHasEntry:(NSSet *)values;

- (void)addItemsInStockObject:(ItemsInStock *)value;
- (void)removeItemsInStockObject:(ItemsInStock *)value;
- (void)addItemsInStock:(NSSet *)values;
- (void)removeItemsInStock:(NSSet *)values;

@end
