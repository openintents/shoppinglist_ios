//
//  EditEntryViewController.m
//  OIShoppingList
//
//  Created by Tian Hongyu on 12/5/12.
//  Copyright (c) 2012 OpenIntents. All rights reserved.
//

#import "EditEntryViewController.h"
@interface EditEntryViewController()
@property (strong, nonatomic) IBOutlet UITextField *product;
@property (strong, nonatomic) IBOutlet UITextField *quantity;
@property (strong, nonatomic) IBOutlet UITextField *unit;
@property (strong, nonatomic) IBOutlet UITextField *tag;
@property (strong, nonatomic) IBOutlet UITextField *price;
@property (strong, nonatomic) IBOutlet UITextField *note;
@property (strong, nonatomic) IBOutlet UIPickerView *myPickerView;
@property (strong,nonatomic)NSArray* myPickerData;

@property Boolean debug;

@end

@implementation EditEntryViewController
@synthesize product = _product;
@synthesize quantity = _quantity;
@synthesize unit = _unit;
@synthesize tag = _tag;
@synthesize price = _price;
@synthesize note = _note;
@synthesize myPickerView = _myPickerView;

@synthesize entry = _entry;
@synthesize myPickerData = _myPickerData;
@synthesize debug = _debug;


-(NSArray*)myPickerData
{
    if (_myPickerData ==nil) {
        NSMutableArray* tempQuantity= [[NSMutableArray alloc]initWithObjects:@"", nil];
        for(int i =1; i<10;i++)
            [tempQuantity addObject:[[NSNumber numberWithInt:i] description]] ;
        if(self.debug)
            NSLog(@"number Initialized%@", tempQuantity.description);
        NSMutableArray * tempUnit = [[NSMutableArray alloc] initWithObjects:@"", @"kg", @"pack",@"L",@"items", nil];
        
        _myPickerData = [[NSArray alloc]initWithObjects:tempQuantity ,tempUnit,nil];
        if(self.debug)
        NSLog(@"Array Initialized%@", _myPickerData.description);
        
    }
    return _myPickerData;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
    NSMutableArray * sectionSelected = [self.myPickerData objectAtIndex:component];
    UITextField* temp = nil;
    if(component ==0)
        temp = self.quantity;
    else if (component == 1)
        temp = self.unit;
    else
        temp = self.product;
    temp.text = [sectionSelected objectAtIndex:row];
}

// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSMutableArray * sectionSelected = [self.myPickerData objectAtIndex:component];
    
    return [sectionSelected count];
}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

// tell the picker the title for a given component
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *title;
    title = [[self.myPickerData objectAtIndex:component] objectAtIndex:row];
    
    return title;
}

// tell the picker the width of each row for a given component
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    int sectionWidth = 50;
    
    if (component ==1) {
        sectionWidth = 100;
    }
    
    return sectionWidth;
}



-(void) saveEditingIntoCoreData
{
    self.entry.tittle = self.product.text;
    self.entry.quantity = self.quantity.text;
    self.entry.unit = self.unit.text;
    self.entry.tag = self.tag.text;
    self.entry.note = self.note.text;
}



-(void)loadTextFromCoreDataToTextFields
{
    self.product.text =self.entry.tittle;
    self.quantity.text = self.entry.quantity;
    self.unit.text= self.entry.unit;
    self.tag.text= self.entry.tag;
    self.note.text= self.entry.note;
}
-(void)viewWillDisappear:(BOOL)animated{
    [self saveEditingIntoCoreData];
    [super viewWillDisappear:animated];
}

-(void) viewWillAppear:(BOOL)animated
{
    self.debug= true;
    [super viewWillAppear:animated];
    [self loadTextFromCoreDataToTextFields];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [self setProduct:nil];
    [self setQuantity:nil];
    [self setUnit:nil];
    [self setTag:nil];
    [self setPrice:nil];
    [self setNote:nil];
    [self setMyPickerView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
