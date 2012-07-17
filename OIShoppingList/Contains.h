//
//  Contains.h
//  OIShoppingList
//
//  Created by Tian Hongyu on 15/7/12.
//  Copyright (c) 2012 OpenIntents. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Items, Lists;

@interface Contains : NSManagedObject

@property (nonatomic, retain) NSDate * accessed;
@property (nonatomic, retain) NSDate * created;
@property (nonatomic, retain) NSDate * modified;
@property (nonatomic, retain) NSNumber * prioriety;
@property (nonatomic, retain) NSNumber * quantity;
@property (nonatomic, retain) NSData * share_created_by;
@property (nonatomic, retain) NSData * share_modified_by;
@property (nonatomic, retain) NSString * sort_key;
@property (nonatomic, retain) NSNumber * status;
@property (nonatomic, retain) Items *item_id;
@property (nonatomic, retain) Lists *list_id;

@end
