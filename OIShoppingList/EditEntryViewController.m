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

@end

@implementation EditEntryViewController
@synthesize product = _product;
@synthesize quantity = _quantity;
@synthesize unit = _unit;
@synthesize tag = _tag;
@synthesize price = _price;
@synthesize note = _note;

@synthesize entry = _entry;

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
