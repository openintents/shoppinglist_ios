//
//  ShoppingList.h
//  OIShoppingList
//
//  Created by Tian Hongyu on 11/5/12.
//  Copyright (c) 2012 OpenIntents. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ListEntry;

@interface ShoppingList : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * listId;
@property (nonatomic, retain) NSString * tittle;
@property (nonatomic, retain) NSSet *needToBuy;
@end

@interface ShoppingList (CoreDataGeneratedAccessors)

- (void)addNeedToBuyObject:(ListEntry *)value;
- (void)removeNeedToBuyObject:(ListEntry *)value;
- (void)addNeedToBuy:(NSSet *)values;
- (void)removeNeedToBuy:(NSSet *)values;

@end
