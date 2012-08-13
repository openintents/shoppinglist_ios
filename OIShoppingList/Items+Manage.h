//
//  Items+Manage.h
//  OIShoppingList
//
//  Created by Tian Hongyu on 19/6/12.
//  Copyright (c) 2012 OpenIntents. All rights reserved.
//
/**************
 This category adds methods to the generated class"Item", so that these methods won't be "erased" when regenarating the class
 *************/
#import "Items.h"
#import "Stores+Manage.h"
#import "Itemsstores+Manage.h"
#import "Contains+Manage.h"

@interface Items (Manage)
+(Items *) creatItemsWithName:(NSString *) name
       inManagedObjectContext:(NSManagedObjectContext *)context;
-(void) updateItemName:(NSString*)name
                  unit:(NSString*)unit
                  tags:(NSString*)tags;

@end
