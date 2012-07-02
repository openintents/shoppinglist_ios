//
//  ShoppingListSettingManager.m
//  OIShoppingList
//
//  Created by Tian Hongyu on 18/5/12.
//  Copyright (c) 2012 OpenIntents. All rights reserved.
//

#import "ShoppingListSettingManager.h"
#define FONT_SIZE @"OIShoppingList.userSetting.FontSize"
#define SORTING_ORDER  @"OIShoppingList.userSetting.SortingOrder"
#define AUTO_HIDE @"OIShoppingList.userSetting.AutoHide"

@interface ShoppingListSettingManager()
@property (strong, nonatomic) NSUserDefaults* myDefaults;
@end

@implementation ShoppingListSettingManager

@synthesize myDefaults = _myDefaults;
@synthesize sortingOrder = _sortingOrder;
@synthesize fontSize= _fontSize;
@synthesize whetherShowFilter = _whetherShowFilter;

-(void) setWhetherHideItemImediately:(Boolean)whetherHideItemImediately
{
    [self.myDefaults setObject:[NSNumber numberWithBool:whetherHideItemImediately ] forKey:AUTO_HIDE];
     [self.myDefaults synchronize];
}
-(Boolean) whetherHideItemImediately
{
    NSNumber* temp = [self.myDefaults objectForKey:AUTO_HIDE];
    return [[NSNumber numberWithBool:YES] isEqualToNumber:temp];
}
-(NSArray *) getSortDescriptor;
{
    /*Keys defined in data model:
     @property (nonatomic, retain) NSString * note;
     @property (nonatomic, retain) NSNumber * priority;
     @property (nonatomic, retain) NSString * quantity;
     @property (nonatomic, retain) NSString * tag;
     @property (nonatomic, retain) NSString * tittle;
     @property (nonatomic, retain) NSString * unit;
     @property (nonatomic, retain) NSNumber * marked;
     @property (nonatomic, retain) NSNumber * display;
     @property (nonatomic, retain) NSSet *canFindIn;
     @property (nonatomic, retain) ShoppingList *listedIn;
     */
    NSMutableArray* descriptor = [[NSMutableArray alloc]init];
    NSString * tempSetting= nil;
    for(tempSetting in self.sortingOrder)
    {
        NSSortDescriptor * tempDescriptor = nil;   

        if([tempSetting isEqualToString: @"sorting order checked"])
        {
            tempDescriptor = [[NSSortDescriptor alloc]
              initWithKey:@"status"
                              ascending:NO];
        }else if ([tempSetting isEqualToString:@"sorting order alphabetical"]) {
            tempDescriptor = [[NSSortDescriptor alloc]
                              initWithKey:@"item_id.name"
                              ascending:YES
                              selector:@selector(localizedCaseInsensitiveCompare:)] ;
        }else if ([tempSetting isEqualToString:@"sorting order newest"]) {
            tempDescriptor = [[NSSortDescriptor alloc]
                              initWithKey:@"modified"
                              ascending:YES] ;
        }else if ([tempSetting isEqualToString:@"sorting order tag" ]) {
            tempDescriptor = [[NSSortDescriptor alloc]
                              initWithKey:@"item_id.tags"
                              ascending:YES
                              selector:@selector(localizedCaseInsensitiveCompare:)] ;
        }else if ([tempSetting isEqualToString:@"sorting order prioriety"]) {
           tempDescriptor = [[NSSortDescriptor alloc]
                              initWithKey:@"prioriety"
                              ascending:YES];
        }else if ( [tempSetting isEqualToString:@"sorting order price" ]) {
           /*to be impelmented*/
        }else {
            NSLog(@"ShoppinglistSettingManager: error generating sorting descriptor::%@",tempSetting);
        }
        
        if (tempDescriptor) {
            [descriptor addObject:tempDescriptor];
        }
    }
    
    

    return [NSArray arrayWithArray:descriptor];
}
-(NSArray *) getFontSize;
{
    UIFont * textFont = nil;
    UIFont * detailedTextFont = nil;
    NSString * tempSetting= self.fontSize;
    
    if([tempSetting isEqualToString: @"font size big"])
    {
        textFont = [UIFont boldSystemFontOfSize: 24];
        detailedTextFont = [UIFont systemFontOfSize: 14];
    }else if ([tempSetting isEqualToString:@"font size standard"]) {
        textFont = [UIFont boldSystemFontOfSize: 20];
        detailedTextFont = [UIFont systemFontOfSize: 12];
    }else if ([tempSetting isEqualToString:@"font size small"]) {
        textFont = [UIFont boldSystemFontOfSize: 16];
        detailedTextFont = [UIFont systemFontOfSize: 10];
    }else {
        NSLog(@"ShoppinglistSettingManager: error generating sorting descriptor");
    }
       
    return [NSArray arrayWithObjects:textFont,detailedTextFont, nil];
}

-(NSString*)showSortingOrder
{ 
    NSArray * temp = nil;
    NSString * result = @"";
    NSArray* order = self.sortingOrder;
    temp = [[order objectAtIndex:0] componentsSeparatedByString:@" "] ;
    result = [result stringByAppendingFormat:@"%@, ",[temp lastObject]];
    temp = [[order objectAtIndex:1] componentsSeparatedByString:@" "] ;
    result = [result stringByAppendingFormat:@"%@...",[temp lastObject]];
    return result;
}

-(void)setAppToFactorySetting
{
    [self.myDefaults setObject:@"font size standard" forKey:FONT_SIZE];
    
    NSMutableArray * tempArray = [NSMutableArray arrayWithObjects: @"sorting order checked",
                                  @"sorting order alphabetical",
                                  @"sorting order newest",
                                  @"sorting order tag",
                                  @"sorting order prioriety",
                                  @"sorting order price", nil
                                  ];
    [self.myDefaults setObject:[NSArray arrayWithArray:tempArray] forKey:SORTING_ORDER];
    [self.myDefaults setObject:[NSNumber numberWithBool:NO] forKey:AUTO_HIDE];

    [self.myDefaults synchronize];
}

 -(NSUserDefaults *) myDefaults
{
    if(!_myDefaults)
        //get standard default if it already exist.
    {
        _myDefaults=[NSUserDefaults standardUserDefaults];
        if(![_myDefaults objectForKey:SORTING_ORDER] )
            //creat if standard default does not exist, init with app default values.
        {
            [self setAppToFactorySetting];
        }
    }
    return _myDefaults;
}
/*allowed values for font setting
@"font size big"
@"font size standard"
@"font size small"
*/
-(void) setFontSize:(NSString *)fontSize
{
    [self.myDefaults setObject:fontSize forKey:FONT_SIZE];
    [self.myDefaults synchronize];
    _fontSize = fontSize;
}

-(NSString *) fontSize
{
    _fontSize = [self.myDefaults stringForKey:FONT_SIZE ];
    return _fontSize;
}

/*alloswed values for sorting order settings
 @"sorting order checked"
 @"sorting order alphabetical"
 @"sorting order newest"
 @"sorting order tag"
 @"sorting order prioriety"
 @"sorting order price"
 */
-(void) setSortingOrder:(NSArray *)sortingOrder
{
    [self.myDefaults setObject:sortingOrder forKey:SORTING_ORDER];
    [self.myDefaults synchronize];
    NSLog(@"userDefault syncronized for sorting order");
    _sortingOrder = sortingOrder;
}
-(NSArray *) sortingOrder
{
    _sortingOrder = [self.myDefaults arrayForKey:SORTING_ORDER];
    return _sortingOrder;
}

//method to desplay setting for debugging purposes
-(NSString *) inspectSetting
{
    NSString * tempString = @"\n settings stored as follow: \n=====================\n";
    tempString = [tempString stringByAppendingFormat:@"font size:\n    %@ \nsorting order:\n    %@",self.fontSize,self.sortingOrder.description];
    NSLog(@"%@",tempString);
    return tempString;
}
@end