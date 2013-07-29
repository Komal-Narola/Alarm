//
//  YELHeadquartersAlarmTrendViewController.m
//  Alarm
//
//  Created by YY on 13-7-20.
//  Copyright (c) 2013年 Ye Erliang. All rights reserved.
//

#import "YELHeadquartersAlarmTrendViewController.h"

@interface YELHeadquartersAlarmTrendViewController ()
{
    NSString *domain;
    NSString *level;
    NSArray *dataSource;
}
@end

@implementation YELHeadquartersAlarmTrendViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        domain=@"001";
        level=@"4";
    }
    return self;
}
-(void)sendRequest
{
    NSDictionary *dict=[NSDictionary dictionaryWithObjectsAndKeys:
                        domain,@"domain",
                        level,@"level",
                        TOKEN,@"token",
                        nil];
    [[YELHttpHelper defaultHelper]getTrendWithParamter:dict sucess:^(NSDictionary *dictionary) {
        int code=[[dictionary objectForKey:@"code"] intValue];
        if (code==0) {
            NSArray *array=[dictionary objectForKey:@"data"];
            dataSource=array;
        }else
        {
            [MBHUDView hudWithBody:[dictionary objectForKey:@"msg"] type:MBAlertViewHUDTypeDefault hidesAfter:1.0 show:YES];
        }
    } falid:^(NSString *errorMsg) {
        [MBHUDView hudWithBody:@"网络不给力" type:MBAlertViewHUDTypeDefault hidesAfter:1.0 show:YES];
        
    }];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self sendRequest];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
