//
//  Items+Manage.m
//  OIShoppingList
//
//  Created by Tian Hongyu on 19/6/12.
//  Copyright (c) 2012 OpenIntents. All rights reserved.
//
/**************
 This category adds methods to the generated class"Item", so that these methods won't be "erased" when regenarating the class
 *************/
#import "Items+Manage.h"
#import "Units+Manage.h"

@implementation Items (Manage)

+(Items *) creatItemsWithName:(NSString *) name
       inManagedObjectContext:(NSManagedObjectContext *)context
{
    Items  *items = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Items"];
    request.predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    NSError *error = nil;
    NSArray *entryList = [context executeFetchRequest:request error:&error];
    
    if (!entryList || ([entryList count] > 1)) {
        // handle error
    } else if (![entryList count]) {
        items = [NSEntityDescription insertNewObjectForEntityForName:@"Items"
                                                  inManagedObjectContext:context];
        items.name=name;
        items.created = [NSDate date];
        items.accessed = [NSDate date];
        items.modified = [NSDate date];
    } else {
        items   = [entryList lastObject];
        items.accessed = [NSDate date];

    }
    
    return items;
    
}
-(void) updateItemName:(NSString*)name
                  unit:(NSString*)unit
                  tags:(NSString*)tags
{
    if(![self.name isEqualToString:name])
    {
        self.name = name;
        self.modified = [NSDate date];
    }
    if(![self.tags isEqualToString:tags])
    {
        self.tags = tags;
        self.modified = [NSDate date];
    }
    if(![unit isEqualToString:self.unit.name])
    {
        if(![unit isEqualToString:@""])
        {
            [Units getUnitWithName:unit forItem:self inManagedObjectContext:[self managedObjectContext]];
            self.modified = [NSDate date];
            //NSLog(@"new unit added with name:===>\n\n%@",unit);
        }
    }
    //NSLog(@"update item:========>\n%@",[ self description]);

}



@end
