

//
//  TestViewController.m
//  OIShoppingList
//
//  Created by Tian Hongyu on 18/5/12.
//  Copyright (c) 2012 OpenIntents. All rights reserved.
//

#import "MyTestViewController.h"
#import "ShoppingListSettingManager.h"

@interface MyTestViewController ()
@property (strong, nonatomic) NSString* typedText;
@property (strong, nonatomic) IBOutlet UITextField *myTextField;
@property (strong, nonatomic) IBOutlet UIButton *buttonLeftTop;
@property (strong, nonatomic) IBOutlet UIButton *buttonRightTop;
@property (strong, nonatomic) IBOutlet UIButton *buttonLeftBottom;
@property (strong, nonatomic) IBOutlet UIButton *buttonRightBottom;
@property (strong, nonatomic) IBOutlet UILabel *myLable;


@property (strong,nonatomic) ShoppingListSettingManager* mySettingManager;


@end

@implementation MyTestViewController
@synthesize typedText = _typedText;
@synthesize myTextField = _myTextField;
@synthesize buttonLeftTop= _buttonLeftTop;
@synthesize buttonRightTop= _buttonRightTop;
@synthesize buttonLeftBottom =_buttonLeftBottom;
@synthesize buttonRightBottom =_buttonRightBottom;
@synthesize myLable = _myLable;

@synthesize mySettingManager = _mySettingManager;

-(ShoppingListSettingManager*) mySettingManager
{
    if(!_mySettingManager)
        _mySettingManager = [[ShoppingListSettingManager alloc]init];
    return _mySettingManager;
}

-(void) setUpDisplay
{
    self.buttonLeftTop.titleLabel.text = @"set font";
    self.buttonRightTop.titleLabel.text = @"display";
    self.buttonLeftBottom.titleLabel.text = @"do nil";
    self.buttonRightBottom.titleLabel.text = @"do nil";
    
    self.myLable.text = self.mySettingManager.inspectSetting;
    
    
}
- (IBAction)bottomRight:(id)sender {
}
- (IBAction)rightTop:(id)sender {
    self.myLable.text = self.mySettingManager.inspectSetting;
}
- (IBAction)leftTop:(id)sender {
    self.mySettingManager.fontSize = self.typedText;
}

- (IBAction)finishTyping:(UITextField*)sender {
    self.typedText = sender.text;
    [sender resignFirstResponder];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    [self setUpDisplay];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setMyTextField:nil];
    [self setButtonLeftTop:nil];
    [self setButtonRightTop:nil];
    [self setButtonLeftBottom:nil];
    [self setButtonRightBottom:nil];
    [self setMyLable:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
