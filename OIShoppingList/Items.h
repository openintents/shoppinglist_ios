//
//  Items.h
//  OIShoppingList
//
//  Created by Tian Hongyu on 19/6/12.
//  Copyright (c) 2012 OpenIntents. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Contains, Itemsstores, Units;

@interface Items : NSManagedObject

@property (nonatomic, retain) NSString * note;
@property (nonatomic, retain) NSString * tags;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * created;
@property (nonatomic, retain) NSDate * modified;
@property (nonatomic, retain) NSDate * accessed;
@property (nonatomic, retain) NSData * barcode;
@property (nonatomic, retain) NSData * location;
@property (nonatomic, retain) NSData * price_fake;
@property (nonatomic, retain) NSData * unit_fake;
@property (nonatomic, retain) NSSet *itemstores_id;
@property (nonatomic, retain) NSSet *contains_id;
@property (nonatomic, retain) Units *unit;
@end

@interface Items (CoreDataGeneratedAccessors)

- (void)addItemstores_idObject:(Itemsstores *)value;
- (void)removeItemstores_idObject:(Itemsstores *)value;
- (void)addItemstores_id:(NSSet *)values;
- (void)removeItemstores_id:(NSSet *)values;

- (void)addContains_idObject:(Contains *)value;
- (void)removeContains_idObject:(Contains *)value;
- (void)addContains_id:(NSSet *)values;
- (void)removeContains_id:(NSSet *)values;

@end
