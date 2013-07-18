//
//  YELChangePwdViewController.m
//  Alarm
//
//  Created by YY on 13-7-18.
//  Copyright (c) 2013年 Ye Erliang. All rights reserved.
//

#import "YELChangePwdViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface YELChangePwdViewController ()
@property (weak, nonatomic) IBOutlet UIView *pwdView;
@property (weak, nonatomic) IBOutlet UITextField *oldPwdTextField;
@property (weak, nonatomic) IBOutlet UITextField *changePwdTextField;
@property (weak, nonatomic) IBOutlet UITextField *againPwdTextField;


- (IBAction)savePwd:(UIButton *)sender;

@end

@implementation YELChangePwdViewController

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
    [self.pwdView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.pwdView.layer setBorderWidth:1.0];
    [self.pwdView.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.pwdView.layer setShadowOpacity:0.5];
    [self.pwdView.layer setShadowOffset:CGSizeMake(1, 1)];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setPwdView:nil];
    [self setOldPwdTextField:nil];
    [self setChangePwdTextField:nil];
    [self setAgainPwdTextField:nil];
    [self setAgainPwdTextField:nil];
    [super viewDidUnload];
}
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
- (IBAction)savePwd:(UIButton *)sender {
    if ([self.oldPwdTextField.text isEqualToString:@""]||self.oldPwdTextField.text==nil) {
        
        [MBHUDView hudWithBody:@"请输入旧密码" type:MBAlertViewHUDTypeDefault hidesAfter:1.0 show:YES];
        return;
        
    }else if ([self.changePwdTextField.text isEqualToString:@""]||self.changePwdTextField.text==nil)
    {
        [MBHUDView hudWithBody:@"请输入新密码" type:MBAlertViewHUDTypeDefault hidesAfter:1.0 show:YES];
        return;
        
    }else if ([self.changePwdTextField.text isEqualToString:self.againPwdTextField.text])
    {
        [MBHUDView hudWithBody:@"新密码不相同" type:MBAlertViewHUDTypeDefault hidesAfter:1.0 show:YES];
        return;
    }
    [self sendChangePwdRequest];
    
}
-(void)sendChangePwdRequest
{
    NSString *account=[USER_DEFAULT objectForKey:ACCOUNT];
    NSDictionary *dict=[NSDictionary dictionaryWithObjectsAndKeys:account,@"userName",
                                                self.oldPwdTextField.text,@"oldPassword",
                                                self.changePwdTextField.text,@"newPassword",
                                                nil];
    [[YELHttpHelper defaultHelper]changePwdWithParamter:dict sucess:^(NSDictionary *dict) {
        int code=[[dict objectForKey:@"code"] intValue];
        if (code==0) {
            [MBHUDView hudWithBody:@"密码修改成功" type:MBAlertViewHUDTypeDefault hidesAfter:1.0 show:YES];
        }else
        {
            [MBHUDView hudWithBody:[dict objectForKey:@"msg"] type:MBAlertViewHUDTypeDefault hidesAfter:1.0 show:YES];
        }
    } falid:^(NSString *errorMsg) {
        [MBHUDView hudWithBody:@"网络不给力" type:MBAlertViewHUDTypeDefault hidesAfter:1.0 show:YES];
    }];
    
}
@end
