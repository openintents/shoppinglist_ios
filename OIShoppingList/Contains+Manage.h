//
//  Contains+Manage.h
//  OIShoppingList
//
//  Created by Tian Hongyu on 19/6/12.
//  Copyright (c) 2012 OpenIntents. All rights reserved.
//

#import "Contains.h"

@interface Contains (Manage)
+(Contains*) creatContainsBetweenItem:(Items*) items 
                              andList:(Lists*) list 
                     inManagedObjectContext:(NSManagedObjectContext*) context;

-(Boolean) isChecked;
-(Boolean) needDisplay;
-(void) cleanItem;
-(void) rescueItem;
-(void) toggleChecked;
-(void) undateQuantity:(NSString*) property 
             prioriety:(NSString*) prioreity
              itemName:(NSString*)name
                  unit:(NSString*)unit
                  tags:(NSString*)tags;
-(void) setThePrice:(NSNumber*)price
    inStoreWithName:(NSString*)name;
@end
