//
//  ListEntry+Creat.h
//  OIShoppingList
//
//  Created by Tian Hongyu on 12/5/12.
//  Copyright (c) 2012 OpenIntents. All rights reserved.
//

#import "ListEntry.h"

@interface ListEntry (Creat)

+(ListEntry *) creatListEntryWithTittle:(NSString *) tittle
          inManagedObjectContext:(NSManagedObjectContext *)context;

@end
