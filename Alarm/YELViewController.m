//
//  YELViewController.m
//  Alarm
//
//  Created by rock on 13-7-17.
//  Copyright (c) 2013年 Ye Erliang. All rights reserved.
//

#import "YELViewController.h"
#import "UIColor+String.h"
#import <QuartzCore/QuartzCore.h>
#import "YELMainControllerViewController.h"
#import "OpenUDID.h"
#import "YELMainControllerViewController.h"
@interface YELViewController ()

@property (weak, nonatomic) IBOutlet UIButton *rememberButton;
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
@property (weak, nonatomic) IBOutlet UIImageView *redBackGroundImageView;
- (IBAction)rememberPwd:(UIButton *)sender;
- (IBAction)pushMainController:(id)sender;
@end

@implementation YELViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=YES;
    //存在密码 进行登录请求 如果成功直接进入主页面 不成功停留在登录页面
    
    NSString *pwd=[USER_DEFAULT objectForKey:PWD];
    if(pwd!=nil) {
        [self.rememberButton setSelected:YES];
        [self sendRequest:pwd];
    }
    
//    YELMainControllerViewController *mainController=[[YELMainControllerViewController alloc]initWithNibName:@"YELMainControllerViewController" bundle:nil];
//    [self.navigationController pushViewController:mainController animated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initUiKit];
	// Do any additional setup after loading the view, typically from a nib.
}
-(void)initUiKit
{
    [self.redBackGroundImageView setBackgroundColor:[UIColor colorWithHexString:@"#C61111"]];
    [self.redBackGroundImageView.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.redBackGroundImageView.layer setShadowOffset:CGSizeMake(0, 3)];
    [self.redBackGroundImageView.layer setShadowOpacity:0.5];
    NSString *pwd=[USER_DEFAULT objectForKey:PWD];
    NSString *account=[USER_DEFAULT objectForKey:ACCOUNT];
    self.accountTextField.text=account;
    self.pwdTextField.text=pwd;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setRedBackGroundImageView:nil];
    [self setPwdTextField:nil];
    [self setAccountTextField:nil];
    [self setRememberButton:nil];
    [super viewDidUnload];
}

- (IBAction)rememberPwd:(UIButton *)sender {
    sender.selected=!sender.selected;
}

- (IBAction)pushMainController:(id)sender {
    if ([self.accountTextField.text isEqualToString:@""]||self.accountTextField.text==nil) {
        
        [MBHUDView hudWithBody:@"请输入用户名" type:MBAlertViewHUDTypeDefault hidesAfter:1.0 show:YES];
        return;
        
    }else if ([self.pwdTextField.text isEqualToString:@""]||self.pwdTextField.text==nil)
    {
        [MBHUDView hudWithBody:@"请输入密码" type:MBAlertViewHUDTypeDefault hidesAfter:1.0 show:YES];
        return;
    }
    if (self.rememberButton.selected) {
        
        [USER_DEFAULT setObject:self.accountTextField.text forKey:ACCOUNT];
        [USER_DEFAULT setObject:self.pwdTextField.text forKey:PWD];
        [USER_DEFAULT synchronize];
    }else
    {
        [USER_DEFAULT setObject:self.accountTextField.text forKey:ACCOUNT];
        [USER_DEFAULT removeObjectForKey:PWD];
        [USER_DEFAULT synchronize];
    }
    [self sendRequest:self.pwdTextField.text];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden=NO;
}
#pragma mark TextFiled Delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}
-(void)sendRequest :(NSString *)pwd
{
    NSString *account=[USER_DEFAULT objectForKey:ACCOUNT];
    NSString *udid=[OpenUDID value];
    NSDictionary*dict=[NSDictionary dictionaryWithObjectsAndKeys:account,@"name",
                       pwd,@"pwd",
                       PLATFORM,@"platform",
                       udid,@"imei",
                       nil];
    [[YELHttpHelper defaultHelper]loginWithParamter:dict sucess:^(NSDictionary *dict) {
        if ([[dict objectForKey:@"code"] intValue]==0) {
            NSString *token=[dict objectForKey:@"data"];
            if (token!=nil) {
                [USER_DEFAULT setObject:token forKey:@"token"];
                [USER_DEFAULT synchronize];
            }
            YELMainControllerViewController *mainController=[[YELMainControllerViewController alloc]initWithNibName:@"YELMainControllerViewController" bundle:nil];
            [self .navigationController pushViewController:mainController animated:YES];
        }else
        {
            NSString *msg=[dict objectForKey:@"msg"];
            [MBHUDView hudWithBody:msg type:MBAlertViewHUDTypeDefault hidesAfter:1.0 show:YES];
        }
    } falid:^(NSString *errorMsg) {
        [MBHUDView hudWithBody:@"网络不给力" type:MBAlertViewHUDTypeDefault hidesAfter:1.0 show:YES];
    }];
}
@end
