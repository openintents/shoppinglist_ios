//
//  ItemsInStock.h
//  OIShoppingList
//
//  Created by Tian Hongyu on 11/5/12.
//  Copyright (c) 2012 OpenIntents. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Shop;

@interface ItemsInStock : NSManagedObject

@property (nonatomic, retain) NSNumber * price;
@property (nonatomic, retain) NSNumber * quantity;
@property (nonatomic, retain) NSString * tittle;
@property (nonatomic, retain) NSString * unit;
@property (nonatomic, retain) Shop *canFindIn;

@end
