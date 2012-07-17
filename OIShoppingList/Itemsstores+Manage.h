//
//  Itemsstores+Manage.h
//  OIShoppingList
//
//  Created by Tian Hongyu on 13/7/12.
//  Copyright (c) 2012 OpenIntents. All rights reserved.
//

#import "Itemsstores.h"
#import "Lists.h"
#import "Stores+Manage.h"
#import "Items+Manage.h"
#import "Contains+Manage.h"


@interface Itemsstores (Manage)
+(Itemsstores*) getItemsstoresReadyForItem:(Items*)item
                               inStore:(Stores*)store
               inManagedObjectContext:(NSManagedObjectContext*)context;
@end
