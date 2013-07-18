//
//  YELMainControllerViewController.m
//  Alarm
//
//  Created by rock on 13-7-18.
//  Copyright (c) 2013年 Ye Erliang. All rights reserved.
//

#import "YELMainControllerViewController.h"
#import "YELSettingControllerViewController.h"
@interface YELMainControllerViewController ()

@end

@implementation YELMainControllerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title=@"IT服务支撑平台";
        self.navigationItem.rightBarButtonItem=[self createHomeButton];
        self.navigationItem.hidesBackButton=YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
-(void)setController
{
    YELSettingControllerViewController *setController=[[YELSettingControllerViewController alloc]initWithNibName:@"YELSettingControllerViewController" bundle:nil];
    [self.navigationController pushViewController:setController animated:YES];
}
-(UIBarButtonItem *)createHomeButton
{
    UIImage* image          = [UIImage imageNamed:@"set.png"];
//   UIImage *imageh        = [UIImage imageNamed:@"homeh.png"];
    CGRect backframe        = CGRectMake(0, 0, 44, 44);
    UIButton* setButton     = [UIButton buttonWithType:UIButtonTypeCustom];
    setButton.frame         = backframe;
    [setButton setImage:image forState:UIControlStateNormal];
//   [backButton setBackgroundImage:imageh forState:UIControlStateHighlighted];
    [setButton addTarget:self action:@selector(setController) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:setButton];
    return rightBarButtonItem;
}
@end
