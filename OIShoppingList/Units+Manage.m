//
//  Units+Manage.m
//  OIShoppingList
//
//  Created by Tian Hongyu on 20/6/12.
//  Copyright (c) 2012 OpenIntents. All rights reserved.
//

#import "Units+Manage.h"

@implementation Units (Manage)
+(Units*)getUnitWithName:(NSString*) name                  
                 forItem:(Items*)item
  inManagedObjectContext:(NSManagedObjectContext*)context
{
    Units * unit = nil;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Units"];
    
    request.predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    NSError *error = nil;
    NSArray *unitArray = [context executeFetchRequest:request error:&error];
    
    if (!unitArray || ([unitArray count] > 1)) {
        // handle error
        NSLog(@"error occur");
    } else if (![unitArray count]) {
        unit = [NSEntityDescription insertNewObjectForEntityForName:@"Units"
                                                 inManagedObjectContext:context];
        unit.name = name;
        [unit addItem_idObject:item];
        unit.created= [NSDate date];
        unit.modified = [NSDate date];
        NSLog(@"added new unit =====%@", [unit description]);
    } else {
        unit   = [unitArray lastObject];
        [unit addItem_idObject:item];
        NSLog(@"existed unit:===>\nR%@", [self description]);

    }
    
    return unit;

}

@end
