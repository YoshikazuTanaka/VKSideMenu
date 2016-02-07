//
//  ViewController.m
//  VKSideMenuExample
//
//  Created by Vladislav Kovalyov on 2/7/16.
//  Copyright © 2016 WOOPSS.com (http://woopss.com/)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "ViewController.h"
#import "VKSideMenu.h"

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:(v) options:NSNumericSearch] != NSOrderedAscending)

@interface ViewController () <VKSideMenuDelegate, VKSideMenuDataSource>

@property (nonatomic, strong) VKSideMenu *menuLeft;
@property (nonatomic, strong) VKSideMenu *menuRight;

@property (strong, nonatomic) IBOutlet UIImageView *avatar;

@end

@implementation ViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Init default left-side menu with custom width
    self.menuLeft = [[VKSideMenu alloc] initWithWidth:220 andDirection:VKSideMenuDirectionLeftToRight];
    self.menuLeft.dataSource = self;
    self.menuLeft.delegate   = self;
    
    // Init custom right-side menu
    self.menuRight = [[VKSideMenu alloc] initWithWidth:180 andDirection:VKSideMenuDirectionRightToLeft];
    self.menuRight.dataSource       = self;
    self.menuRight.delegate         = self;
    self.menuRight.textColor        = [UIColor lightTextColor];
    self.menuRight.enableOverlay    = NO;
    self.menuRight.hideOnSelection  = NO;
    self.menuRight.selectionColor   = [UIColor colorWithWhite:.0 alpha:.3];
    self.menuRight.iconsColor       = nil;
    /* See more options in VKSideMenu.h */
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))
        self.menuRight.blurEffectStyle = UIBlurEffectStyleDark;
    else
        self.menuRight.backgroundColor = [UIColor colorWithWhite:0. alpha:0.8];
    
    // Make stormtrooper image to be cool
    self.avatar.layer.cornerRadius  = self.avatar.frame.size.width * .5;
    self.avatar.layer.masksToBounds = YES;
    self.avatar.layer.borderColor   = [UIColor whiteColor].CGColor;
    self.avatar.layer.borderWidth   = 5.;
}

-(IBAction)buttonMenuLeft:(id)sender
{
    [self.menuLeft show];
}

- (IBAction)buttonMenuRight:(id)sender
{
    [self.menuRight show];
}

#pragma mark - VKSideMenuDataSource

-(NSInteger)numberOfSectionsInSideMenu:(VKSideMenu *)sideMenu
{
    return sideMenu == self.menuLeft ? 1 : 2;
}

-(NSInteger)sideMenu:(VKSideMenu *)sideMenu numberOfRowsInSection:(NSInteger)section
{
    if (sideMenu == self.menuLeft)
        return 4;
    
    return section == 0 ? 1 : 2;
}

-(VKSideMenuItem *)sideMenu:(VKSideMenu *)sideMenu itemForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // This solution is provided for DEMO propose only
    // It's beter to store all items in separate arrays like you do it in your UITableView's. Right?
    VKSideMenuItem *item = [VKSideMenuItem new];
    
    if (sideMenu == self.menuLeft) // All LEFT menu items
    {
        switch (indexPath.row)
        {
            case 0:
                item.title = @"Profile";
                item.icon  = [UIImage imageNamed:@"ic_option_1"];
                break;
                
            case 1:
                item.title = @"Messages";
                item.icon  = [UIImage imageNamed:@"ic_option_2"];
                break;
                
            case 2:
                item.title = @"Cart";
                item.icon  = [UIImage imageNamed:@"ic_option_3"];
                break;
                
            case 3:
                item.title = @"Settings";
                item.icon  = [UIImage imageNamed:@"ic_option_4"];
                break;
                
            default:
                break;
        }
    }
    else if (indexPath.section == 0) // RIGHT menu first section items
    {
        item.title = @"Login";
        item.icon  = [UIImage imageNamed:@"ic_login"];
    }
    else // RIGHT menu second section items
    {
        switch (indexPath.row)
        {
            case 0:
                item.title = @"Like";
                break;
                
            case 1:
                item.title = @"Share";
                break;
            default:
                break;
        }
    }
    
    return item;
}

#pragma mark - VKSideMenuDelegate

-(void)sideMenu:(VKSideMenu *)sideMenu didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"SideMenu didSelectRow: %@", indexPath);
}

-(void)sideMenuDidShow:(VKSideMenu *)sideMenu
{
    NSLog(@"%@ VKSideMenue did show", sideMenu == self.menuLeft ? @"LEFT" : @"RIGHT");
}

-(void)sideMenuDidHide:(VKSideMenu *)sideMenu
{
    NSLog(@"%@ VKSideMenue did hide", sideMenu == self.menuLeft ? @"LEFT" : @"RIGHT");
}

-(NSString *)sideMenu:(VKSideMenu *)sideMenu titleForHeaderInSection:(NSInteger)section
{
    if (sideMenu == self.menuLeft)
        return nil;

    switch (section)
    {
        case 0:
            return @"Profile";
            break;
            
        case 1:
            return @"Actions";
            break;
            
        default:
            return nil;
            break;
    }
}

@end
