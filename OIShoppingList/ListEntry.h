//
//  ListEntry.h
//  OIShoppingList
//
//  Created by Tian Hongyu on 13/5/12.
//  Copyright (c) 2012 OpenIntents. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Shop, ShoppingList;

@interface ListEntry : NSManagedObject

@property (nonatomic, retain) NSString * note;
@property (nonatomic, retain) NSNumber * priority;
@property (nonatomic, retain) NSString * quantity;
@property (nonatomic, retain) NSString * tag;
@property (nonatomic, retain) NSString * tittle;
@property (nonatomic, retain) NSString * unit;
@property (nonatomic, retain) NSNumber * marked;
@property (nonatomic, retain) NSNumber * display;
@property (nonatomic, retain) NSSet *canFindIn;
@property (nonatomic, retain) ShoppingList *listedIn;
@end

@interface ListEntry (CoreDataGeneratedAccessors)

- (void)addCanFindInObject:(Shop *)value;
- (void)removeCanFindInObject:(Shop *)value;
- (void)addCanFindIn:(NSSet *)values;
- (void)removeCanFindIn:(NSSet *)values;

@end
