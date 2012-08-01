//
//  Stores+Manage.h
//  OIShoppingList
//
//  Created by Tian Hongyu on 13/7/12.
//  Copyright (c) 2012 OpenIntents. All rights reserved.
//

#import "Stores.h"
#import "Items.h"
#import "Itemsstores.h"
#import "Contains+Manage.h"

@interface Stores (Manage)
+(Stores*)getStoreWithName:(NSString*)name 
                    inList:(Lists*)list
    inManagedObjectContext:(NSManagedObjectContext*)context;

-(NSNumber*)priceForItem:(Items*)item;

-(NSDictionary*) subtotalForItemsAndCalculatedItemsWithinStore;
@end
