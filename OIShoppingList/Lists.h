//
//  Lists.h
//  OIShoppingList
//
//  Created by Tian Hongyu on 19/6/12.
//  Copyright (c) 2012 OpenIntents. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Contains, Stores;

@interface Lists : NSManagedObject

@property (nonatomic, retain) NSDate * created;
@property (nonatomic, retain) NSData * image;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * modified;
@property (nonatomic, retain) NSDate * accessed;
@property (nonatomic, retain) NSString * share_name;
@property (nonatomic, retain) NSString * share_contact;
@property (nonatomic, retain) NSNumber * store_filter;
@property (nonatomic, retain) NSNumber * tags_filter;
@property (nonatomic, retain) NSSet *contains_id;
@property (nonatomic, retain) NSSet *store_id;
@end

@interface Lists (CoreDataGeneratedAccessors)

- (void)addContains_idObject:(Contains *)value;
- (void)removeContains_idObject:(Contains *)value;
- (void)addContains_id:(NSSet *)values;
- (void)removeContains_id:(NSSet *)values;

- (void)addStore_idObject:(Stores *)value;
- (void)removeStore_idObject:(Stores *)value;
- (void)addStore_id:(NSSet *)values;
- (void)removeStore_id:(NSSet *)values;

@end
