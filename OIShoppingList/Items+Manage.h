//
//  Items+Manage.h
//  OIShoppingList
//
//  Created by Tian Hongyu on 19/6/12.
//  Copyright (c) 2012 OpenIntents. All rights reserved.
//

#import "Items.h"

@interface Items (Manage)
+(Items *) creatItemsWithName:(NSString *) name
       inManagedObjectContext:(NSManagedObjectContext *)context;
-(void) setUnit:(Units *)unit;
-(void) updateItemName:(NSString*)name
                  unit:(NSString*)unit
                  tags:(NSString*)tags;
@end
