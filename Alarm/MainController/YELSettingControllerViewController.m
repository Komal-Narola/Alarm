//
//  YELSettingControllerViewController.m
//  Alarm
//
//  Created by rock on 13-7-18.
//  Copyright (c) 2013年 Ye Erliang. All rights reserved.
//

#import "YELSettingControllerViewController.h"
#import <QuartzCore/QuartzCore.h>
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
    DLog(@"aaaaa=%@",NSStringFromCGRect(self.setView.frame));
    [self.setView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.setView.layer setBorderWidth:1.0];
    [self.setView.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.setView.layer setShadowOpacity:0.5];
    [self.setView.layer setShadowOffset:CGSizeMake(1, 1)];
    // Do any additional setup after loading the view from its nib.
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
}

- (IBAction)changePwd:(UIButton *)sender {
}
@end
