//
//  Contains+Manage.m
//  OIShoppingList
//
//  Created by Tian Hongyu on 19/6/12.
//  Copyright (c) 2012 OpenIntents. All rights reserved.
//

#import "Contains+Manage.h"
#import "Lists.h"
#import "Items+Manage.h"

@implementation Contains (Manage)
+(Contains*) creatContainsBetweenItem:(Items*) items 
                              andList:(Lists*) list 
               inManagedObjectContext:(NSManagedObjectContext*) context

{
    Contains * contains = nil;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Contains"];
    
    request.predicate = [NSPredicate predicateWithFormat:@"item_id= %@ AND list_id = %@", items, list];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"created" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    NSError *error = nil;
    NSArray *containsArray = [context executeFetchRequest:request error:&error];
    
    if (!containsArray || ([containsArray count] > 1)) {
        // handle error
    } else if (![containsArray count]) {
        contains = [NSEntityDescription insertNewObjectForEntityForName:@"Contains"
                                                     inManagedObjectContext:context];
        contains.quantity  = [NSNumber numberWithInt:1];
        contains.list_id = list;
        contains.item_id = items;
        contains.created= [NSDate date];
        contains.modified = [NSDate date];
        contains.accessed = [NSDate date];
        NSLog(@"added new contains %@", [contains description]);
    } else {
        contains   = [containsArray lastObject];
        contains.modified = [NSDate date];
        contains.accessed = [NSDate date];
    }
    
    return contains;

}
/*
 status:0 => item not check
 status:1 => item checked displayed
 status:2 => item checked hided
 */
-(Boolean) isChecked
{
    return ![self.status isEqualToNumber:[NSNumber numberWithInt:0]];
}
-(Boolean) needDisplay
{
    return ![self.status isEqualToNumber: [NSNumber numberWithInt: 2]];
}
-(void) cleanItem
{
    if ([self.status isEqualToNumber: [NSNumber numberWithInt:1]]) {
        self.status =[NSNumber numberWithInt:2];   
    }
}
-(void) rescueItem
{
    self.status =[NSNumber numberWithInt:0];   
   
}
-(void) toggleChecked
{
    if ([self.status isEqualToNumber:[NSNumber numberWithInt:0]]) {
        self.status = [NSNumber numberWithInt:1];
    }else{
        self.status = [NSNumber numberWithInt:0];
    }
}
-(void) undateQuantity:(NSString*) quantity 
             prioriety:(NSString*) prioreity
              itemName:(NSString*)name
                  unit:(NSString*)unit
                  tags:(NSString*)tags
{
    if (! [self.quantity isEqualToNumber:[NSNumber numberWithInt: [quantity intValue]]]) {
        self.quantity = [NSNumber numberWithInt: [quantity intValue]];
        self.modified = [NSDate date];
    }
    if (! [self.prioriety isEqualToNumber:[NSNumber numberWithInt: [prioreity intValue]]]) {
        self.prioriety =[NSNumber numberWithInt: [prioreity intValue]];
        self.modified = [NSDate date];
    }
    [self.item_id updateItemName:name unit:unit tags:tags]; 
    
}

@end
