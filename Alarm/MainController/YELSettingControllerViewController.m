//
//  YELSettingControllerViewController.m
//  Alarm
//
//  Created by rock on 13-7-18.
//  Copyright (c) 2013年 Ye Erliang. All rights reserved.
//

#import "YELSettingControllerViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "YELChangePwdViewController.h"
@interface YELSettingControllerViewController ()
@property (weak, nonatomic) IBOutlet UIView *setView;
- (IBAction)logOut:(UIButton *)sender;
- (IBAction)changePwd:(UIButton *)sender;

@end

@implementation YELSettingControllerViewController

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
    [self initUiKit];
    
    // Do any additional setup after loading the view from its nib.
}
-(void)initUiKit
{
    [self.setView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.setView.layer setBorderWidth:1.0];
    [self.setView.layer setCornerRadius:5.0];
    [self.setView.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.setView.layer setShadowOpacity:0.5];
    [self.setView.layer setShadowOffset:CGSizeMake(1, 1)];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setSetView:nil];
    [super viewDidUnload];
}
- (IBAction)logOut:(UIButton *)sender {
    UIActionSheet *actionSheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"退出登录" otherButtonTitles:nil, nil];
    [actionSheet showInView:self.view];

}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        [USER_DEFAULT removeObjectForKey:PWD];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}
- (IBAction)changePwd:(UIButton *)sender {
    YELChangePwdViewController *changePwdController=[[YELChangePwdViewController alloc]initWithNibName:@"YELChangePwdViewController" bundle:nil];
    [self.navigationController pushViewController:changePwdController animated:YES];
}
@end
