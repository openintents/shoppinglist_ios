//
//  EditingItemDetailTableViewControllerViewController.m
//  OIShoppingList
//
//  Created by Tian Hongyu on 21/6/12.
//  Copyright (c) 2012 OpenIntents. All rights reserved.
//

#import "EditingItemDetailTableViewControllerViewController.h"

@interface EditingItemDetailTableViewControllerViewController ()

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

@implementation EditingItemDetailTableViewControllerViewController
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


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}
- (IBAction)finishTypingProduct:(id)sender {
    [sender resignFirstResponder];
    [self saveEditingIntoCoreData];
}
- (IBAction)finishTypingTag:(id)sender {
    [sender resignFirstResponder];
    [self saveEditingIntoCoreData];

}
- (IBAction)finishTypingPrioriety:(id)sender {
    [sender resignFirstResponder];
    [self saveEditingIntoCoreData];

}
- (IBAction)finishTypingQuantity:(id)sender {
    [sender resignFirstResponder];
    [self saveEditingIntoCoreData];
}

- (IBAction)finishTypingUnit:(id)sender {
    
    [self saveEditingIntoCoreData];
    [self.myPickerView reloadAllComponents];
    int myIndex;
    NSArray* data = self.myPickerData;
    for (Units* temp in data) {
        if ([temp.name isEqualToString:((UITextView*)sender).text]) {
            myIndex = [data indexOfObject:temp];
            break;
        }
    }
    
    [self.myPickerView selectRow: myIndex inComponent:0 animated:YES];
    [sender resignFirstResponder];
}


-(NSArray*)myPickerData
{
    NSManagedObjectContext* context=self.entry.managedObjectContext;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Units" inManagedObjectContext:context];
        [request setEntity:entity];
    NSError *error;
    _myPickerData = [context executeFetchRequest:request error:&error];
    return _myPickerData;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {    
    self.unit.text = ((Units*)[self.myPickerData objectAtIndex:row]).name;
}

// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.myPickerData.count;
}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// tell the picker the title for a given component
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *title;
    title = ((Units*)[self.myPickerData objectAtIndex:row]).name ;
    
    return title;
}

// tell the picker the width of each row for a given component
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    int sectionWidth = 150;
    return sectionWidth;
}



-(void) saveEditingIntoCoreData
{
    [self.entry undateQuantity:self.quantity.text prioriety:@"1" itemName:self.product.text unit:self.unit.text tags:self.tag.text];
}



-(void)loadTextFromCoreDataToTextFields
{    self.product.text =self.entry.item_id.name;
    self.quantity.text = [self.entry.quantity description];
    self.unit.text= self.entry.item_id.unit.name;
    self.tag.text= self.entry.item_id.tags;
    self.note.text= @"";
    self.entry.accessed =[NSDate date];
    
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
    int myIndex;
    NSArray* data = self.myPickerData;
    for (Units* temp in data) {
        if ([temp.name isEqualToString:self.unit.text]) {
            myIndex = [data indexOfObject:temp];
            break;
        }
    }
    
    [self.myPickerView selectRow: myIndex inComponent:0 animated:NO];
}

#pragma mark - Generated Livecycle Code


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}




@end
