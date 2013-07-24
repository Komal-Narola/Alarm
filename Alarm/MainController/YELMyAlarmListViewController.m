//
//  YELMyAlarmListViewController.m
//  Alarm
//
//  Created by rock on 13-7-24.
//  Copyright (c) 2013年 Ye Erliang. All rights reserved.
//

#import "YELMyAlarmListViewController.h"

@interface YELMyAlarmListViewController ()

@end

@implementation YELMyAlarmListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title=@"我的告警列表";
        
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
