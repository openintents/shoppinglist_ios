//
//  OptionsTableViewController.m
//  OIShoppingList
//
//  Created by Tian Hongyu on 18/5/12.
//  Copyright (c) 2012 OpenIntents. All rights reserved.
//
/*************
 this class presents a static table view for adjusting settings.
 Delegation protocal for changing font size and sorting order is also implemented.
 *************/
#import "OptionsTableViewController.h"

@interface OptionsTableViewController ()<MFMailComposeViewControllerDelegate,MFMessageComposeViewControllerDelegate,UIActionSheetDelegate>


@property(strong,nonatomic) ShoppingListSettingManager* mySettingManager;
@property (strong, nonatomic) IBOutlet UISwitch *autoHideChecked;
@property (strong, nonatomic) IBOutlet UITableViewCell *fontSizeCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *sortByCell;
@property (strong,nonatomic)UIActionSheet* factorySettingConfirm;

@end



@implementation OptionsTableViewController

@synthesize mySettingManager = _mySettingManager;
@synthesize autoHideChecked = _autoHideChecked;
@synthesize fontSizeCell = _fontSizeCell;
@synthesize sortByCell = _sortByCell;
@synthesize factorySettingConfirm = _factorySettingConfirm;

-(ShoppingListSettingManager*) mySettingManager
{
    if(!_mySettingManager)
    {
        _mySettingManager = [[ShoppingListSettingManager alloc]init];
    }
    return _mySettingManager;
}

# pragma mark - deligate methods for fontsize & sorting selectiong
-(ShoppingListSettingManager*)getSettingManager
{
    return self.mySettingManager;
}

-(void) applyFontSize:(NSString*)fontSize
{
    NSLog(@"font size set to %@", fontSize);
    self.mySettingManager.fontSize = fontSize;
    self.fontSizeCell.detailTextLabel.text = self.mySettingManager.fontSize;

}
-(void) applySortingRule:(NSArray*)sortBy
{
    self.mySettingManager.sortingOrder = sortBy;
    self.sortByCell.detailTextLabel.text = [self.mySettingManager showSortingOrder];
}

# pragma mark - action sheet
-(UIActionSheet*) factorySettingConfirm
{
    if (!_factorySettingConfirm) {
        _factorySettingConfirm = [[UIActionSheet alloc] initWithTitle:@"Are you sure you want to revert to factory setting" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"Cancel" otherButtonTitles:@"Yes, revert.",nil];
    }
    return _factorySettingConfirm;
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        [self resetAppSetting];
        self.fontSizeCell.detailTextLabel.text = self.mySettingManager.fontSize;
        self.sortByCell.detailTextLabel.text = [self.mySettingManager showSortingOrder];
    }
}

# pragma mark - action methods for upon user's selection

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController respondsToSelector:@selector(setDeligate:)]) {
        [segue.destinationViewController performSelector:@selector(setDeligate:) withObject:self];
    }
}

-(void) changeFontSizeSetting//:(NSString*)fontSize
{
    NSLog(@"font size");
}

-(void) changeSortingRuleSetting//:(NSString*)sortBy
{
    NSLog(@"sorting");
    
}
- (IBAction)autoHideSwitchChanged:(UISwitch *)sender {
    self.mySettingManager.whetherHideItemImediately = sender.on;
    NSLog(@"auto Hide changed:%@",(sender.on?@"yes":@"no"));
}

-(void) resetAppSetting
{
    [self.factorySettingConfirm showFromToolbar:self.navigationController.toolbar ];
     NSLog(@"reset");
}
-(void) shareViaSMS
{
    [self displaySMSComposerSheet];
    NSLog(@"SMS");
}
-(void) shareViaEmail
{
    [self displayMailComposerSheet];
    NSLog(@"email");
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        /*case 0:
        {
            switch (indexPath.row) {
                case 0:
                    [self shareViaSMS];
                    break;
                case 1:
                    [self shareViaEmail];
                    break;
                default:
                    NSLog(@"problem in selecting options at indexpath section: %d, row %d",indexPath.section,indexPath.row);
                    break;
            }
             break;
        }*/
           
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                    [self changeFontSizeSetting];
                    break;
                    
                case 1:
                    [self changeSortingRuleSetting];
                    break;
                    
                case 2:
                    NSLog(@"auto Hide Checked selected");
                    break;
                    
                default:
                    NSLog(@"problem in selecting options at indexpath section: %d, row %d",indexPath.section,indexPath.row);
                    break;
            }
            break;
        }
            
        case 1:
        {
            switch (indexPath.row) {
                case 0:
                    [self resetAppSetting];
                    break;
                    
                default:
                    NSLog(@"problem in selecting options at indexpath section: %d, row %d",indexPath.section,indexPath.row);
                    break;
            }
            break;
        }
            
        default:
            NSLog(@"problem in selecting options at indexpath section: %d, row %d",indexPath.section,indexPath.row);

            break;
    }
}
#pragma mark - SMS sharing

-(void)displaySMSComposerSheet
{
    if ([MFMessageComposeViewController canSendText]) {
        MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
        picker.messageComposeDelegate = self;
        
        NSString *smsBody = @"It is raining in sunny California!";
        [picker setBody:smsBody];
        [self presentModalViewController:picker animated:YES];

    }
}
- (void)messageComposeController:(MFMessageComposeViewController *)controller
          didFinishWithResult:(MessageComposeResult)result
                        error:(NSError *)error
{
    [self dismissModalViewControllerAnimated:YES];
}
#pragma mark - Mail sharing

-(void)displayMailComposerSheet
{
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
        picker.mailComposeDelegate = self;
        
        [picker setSubject:@"Hello from California!"];
        
               
        NSString *path = [[NSBundle mainBundle] pathForResource:@"ipodnano"
                                                         ofType:@"png"];
        NSData *myData = [NSData dataWithContentsOfFile:path];
        [picker addAttachmentData:myData mimeType:@"image/png"
                         fileName:@"ipodnano"];
        
        NSString *emailBody = @"It is raining in sunny California!";
        [picker setMessageBody:emailBody isHTML:NO];
        
        [self presentModalViewController:picker animated:YES];

    }        
}

// The mail compose view controller delegate method
- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError *)error
{
    [self dismissModalViewControllerAnimated:YES];
}
#pragma mark - LifeCycle


- (void)viewDidUnload {
    [self setAutoHideChecked:nil];
    [self setFontSizeCell:nil];
    [self setSortByCell:nil];
    [super viewDidUnload];
}
-(void) viewDidLoad
{
    [super viewDidLoad];
    self.fontSizeCell.detailTextLabel.text = self.mySettingManager.fontSize;
    self.sortByCell.detailTextLabel.text = [self.mySettingManager showSortingOrder];
    self.autoHideChecked.on = self.mySettingManager.whetherHideItemImediately;
}
@end
