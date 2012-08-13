//
//  Units+Manage.h
//  OIShoppingList
//
//  Created by Tian Hongyu on 20/6/12.
//  Copyright (c) 2012 OpenIntents. All rights reserved.
//
/**************
 This category adds methods to the generated class"Units", so that these methods won't be "erased" when regenarating the class
 *************/
#import "Units.h"

@interface Units (Manage)
+(Units*)getUnitWithName:(NSString*) name  
                 forItem:(Items*)item
inManagedObjectContext:(NSManagedObjectContext*)context;

@end
