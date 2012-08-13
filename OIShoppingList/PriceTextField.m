//
//  PriceTextField.m
//  OIShoppingList
//
//  Created by Tian Hongyu on 17/7/12.
//  Copyright (c) 2012 OpenIntents. All rights reserved.
//
/*********
 This class subclasses NSSTring and added the property storeName.
 
 The aim of subclassing is to provide the class "PriceStoreTableViewController" with a mechanism to retain the relationship between the text field, which could be dynamically gennertaed, and the store, that the price is associated with.
 
 *********/
#import "PriceTextField.h"

@implementation PriceTextField
@synthesize storeName = _storeName;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
