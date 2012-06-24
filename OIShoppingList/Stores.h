//
//  Stores.h
//  OIShoppingList
//
//  Created by Tian Hongyu on 19/6/12.
//  Copyright (c) 2012 OpenIntents. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Itemsstores, Lists;

@interface Stores : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * created;
@property (nonatomic, retain) NSDate * modified;
@property (nonatomic, retain) NSSet *list_id;
@property (nonatomic, retain) NSSet *itemstores_id;
@end

@interface Stores (CoreDataGeneratedAccessors)

- (void)addList_idObject:(Lists *)value;
- (void)removeList_idObject:(Lists *)value;
- (void)addList_id:(NSSet *)values;
- (void)removeList_id:(NSSet *)values;

- (void)addItemstores_idObject:(Itemsstores *)value;
- (void)removeItemstores_idObject:(Itemsstores *)value;
- (void)addItemstores_id:(NSSet *)values;
- (void)removeItemstores_id:(NSSet *)values;

@end
