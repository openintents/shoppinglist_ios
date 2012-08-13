//
//  PriceTextField.h
//  OIShoppingList
//
//  Created by Tian Hongyu on 17/7/12.
//  Copyright (c) 2012 OpenIntents. All rights reserved.
//

#import <UIKit/UIKit.h>
/*********
 This class subclasses NSSTring and added the property storeName.
 
 The aim of subclassing is to provide the class "PriceStoreTableViewController" with a mechanism to retain the relationship between the text field, which could be dynamically gennertaed, and the store, that the price is associated with.
 
 *********/

@interface PriceTextField : UITextField
@property (strong ,nonatomic) NSString* storeName;
@end
