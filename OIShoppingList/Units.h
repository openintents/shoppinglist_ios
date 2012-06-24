//
//  Units.h
//  OIShoppingList
//
//  Created by Tian Hongyu on 19/6/12.
//  Copyright (c) 2012 OpenIntents. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Items;

@interface Units : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * singular;
@property (nonatomic, retain) NSDate * created;
@property (nonatomic, retain) NSDate * modified;
@property (nonatomic, retain) NSSet *item_id;
@end

@interface Units (CoreDataGeneratedAccessors)

- (void)addItem_idObject:(Items *)value;
- (void)removeItem_idObject:(Items *)value;
- (void)addItem_id:(NSSet *)values;
- (void)removeItem_id:(NSSet *)values;

@end
