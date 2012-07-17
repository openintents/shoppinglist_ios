//
//  Stores.h
//  OIShoppingList
//
//  Created by Tian Hongyu on 15/7/12.
//  Copyright (c) 2012 OpenIntents. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Itemsstores, Lists;

@interface Stores : NSManagedObject

@property (nonatomic, retain) NSDate * created;
@property (nonatomic, retain) NSDate * modified;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *itemstores_id;
@property (nonatomic, retain) Lists *list_id;
@end

@interface Stores (CoreDataGeneratedAccessors)

- (void)addItemstores_idObject:(Itemsstores *)value;
- (void)removeItemstores_idObject:(Itemsstores *)value;
- (void)addItemstores_id:(NSSet *)values;
- (void)removeItemstores_id:(NSSet *)values;

@end
