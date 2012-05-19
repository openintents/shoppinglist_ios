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

@interface ShoppingListSettingManager()
@property (strong, nonatomic) NSUserDefaults* myDefaults;
@end

@implementation ShoppingListSettingManager

@synthesize myDefaults = _myDefaults;
@synthesize sortingOrder = _sortingOrder;
@synthesize fontSize= _fontSize;
@synthesize whetherShowFilter = _whetherShowFilter;
@synthesize whetherHideItemImediately = _whetherHideItemImediately;
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
    
    NSMutableArray * tempArray = [[NSMutableArray alloc] init ];
    [tempArray addObject: @"sorting order checked"];
    [tempArray addObject: @"sorting order alphabetical"];
    [tempArray addObject: @"sorting order newest"];
    [self.myDefaults setObject:[NSArray arrayWithArray:tempArray] forKey:SORTING_ORDER];
    
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