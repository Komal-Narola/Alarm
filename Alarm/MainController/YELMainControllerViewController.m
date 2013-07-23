//
//  YELMainControllerViewController.m
//  Alarm
//
//  Created by rock on 13-7-18.
//  Copyright (c) 2013年 Ye Erliang. All rights reserved.
//

#import "YELMainControllerViewController.h"
#import "YELSettingControllerViewController.h"
#import "UIImageView+WebCache.h"
#import "StyledPageControl.h"
#import "YELSystemRunStateViewController.h"
#import "YELAlarmNumberViewController.h"
#import "YELAlarmListViewController.h"
#import "YELProvinceAlarmStatisticsViewController.h"
#import "YELTodoListViewController.h"
#import "YELHeadquartersAlarmTrendViewController.h"

@interface YELMainControllerViewController ()
{
    StyledPageControl *pageControl;
}
@property (weak, nonatomic) IBOutlet UIScrollView *bottomScrollview;
@property (weak, nonatomic) IBOutlet UIScrollView *topScrollview;
@property (weak, nonatomic) IBOutlet UIImageView *bottomBackImage;
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

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *token=[USER_DEFAULT objectForKey:@"token"];
    if (token!=nil) {
        NSDictionary *dict=[NSDictionary dictionaryWithObject:token forKey:@"token"];
        [[YELHttpHelper defaultHelper]getImageWithParamter:dict sucess:^(NSDictionary *dictionary) {
            int code=[[dictionary objectForKey:@"code"] intValue];
            if (code==0) {
                NSArray *array=[dictionary objectForKey:@"data"];
                [self initTopScrollView:[array count]];
                for (int i=0; i<[array count]; i++) {
                    NSString *path=[[array objectAtIndex:i]objectForKey:@"URI"];
                    NSString *url=[IMAGEURL stringByAppendingString:path];
                    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(320*i, 0, 320, 120)];
                    [imageView setImageWithURL:[NSURL URLWithString:url]];
                    [self.topScrollview addSubview:imageView];
                }
            }
            
        } falid:^(NSString *errorMsg) {
            
        }];
    }
    [self initTopScrollView:3];
    [self initBottomScrollview];
}
-(void)initTopScrollView:(int)count
{
    [self.topScrollview setContentSize:CGSizeMake(320*count, 120)];
    [self.topScrollview setBackgroundColor:[UIColor greenColor]];
    //pageControl
    pageControl = [[StyledPageControl alloc] initWithFrame:CGRectMake(136, 103, 50, 15)];
    [pageControl setPageControlStyle:PageControlStyleThumb];
    [pageControl setThumbImage:[UIImage imageNamed:@"pagecontrol-thumb-normal.png"]];
    [pageControl setSelectedThumbImage:[UIImage imageNamed:@"pagecontrol-thumb-selected.png"]];
    [pageControl setNumberOfPages:count];
//    [pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:pageControl];
}
- (void)changePage:(id)sender
{
    int page = pageControl.currentPage;
    
	// update the scroll view to the appropriate page
    CGRect frame = self.topScrollview.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [self.topScrollview scrollRectToVisible:frame animated:YES];
    
	// Set the boolean used when scrolls originate from the UIPageControl. See scrollViewDidScroll: above.
//    pageControlUsed = YES;
}

-(void)initBottomScrollview
{

    UIImage *image=[LOADIMAGE(@"mainPageBackGround@2x",@"png") resizableImageWithCapInsets:UIEdgeInsetsMake(50, 1, 1, 1) resizingMode:UIImageResizingModeStretch];
    self.bottomBackImage.image=image;
    [self.bottomScrollview setContentSize:CGSizeMake(640, self.bottomScrollview.frame.size.height)];
    int num=1;
    for (int i =0; i<3; i++) {
        for (int y =0 ; y<2; y++) {
            UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
            button.frame=CGRectMake(20*(i+1) + (i*80), 10+(y*120), 80, 80);
            [button setBackgroundColor:[UIColor redColor]];
            NSArray *buttonArray=[NSArray arrayWithObjects:
                            [NSArray arrayWithObjects:@"",@"", nil],
                            [NSArray arrayWithObjects:@"",@"",nil],
                            [NSArray arrayWithObjects:@"",@"", nil],
                            nil];
//            [button setBackgroundImage:LOADIMAGE([[buttonArray objectAtIndex:i] objectAtIndex:y], @"png") forState:UIControlStateNormal];
            [button setBackgroundColor:[UIColor yellowColor]];
            [button addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
            button.tag=num;
            num++;
            [self.bottomScrollview addSubview:button];
            
            float orgin= [YELUtil orginfromView:button];
            UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(20*(i+1) + (i*80),orgin+5, 80, 20)];
            NSArray *array=[NSArray arrayWithObjects:
                             [NSArray arrayWithObjects:@"系统运行状态",@"告警排名", nil],
                             [NSArray arrayWithObjects:@"当前告警列表",@"省份告警统计",nil],
                             [NSArray arrayWithObjects:@"待办事项",@"总部告警趋势", nil],
                             nil];
            [label setFont:[UIFont systemFontOfSize:13]];
            [label setTextAlignment:NSTextAlignmentCenter];
            [label setBackgroundColor:[UIColor clearColor]];
            label.text=[[array objectAtIndex:i]objectAtIndex:y];
            [self.bottomScrollview addSubview:label];
        }
    }
    
}
-(void)pressButton:(UIButton *)sender
{
    if (sender.tag==1) {
        
        YELSystemRunStateViewController *system=[[YELSystemRunStateViewController alloc]initWithNibName:@"YELSystemRunStateViewController" bundle:nil];
        [self.navigationController pushViewController:system animated:YES];
        
    }else if (sender.tag==2)
    {
        YELAlarmNumberViewController *alarmNumber=[[YELAlarmNumberViewController alloc]initWithNibName:@"YELAlarmNumberViewController" bundle:nil];
        [self.navigationController pushViewController:alarmNumber animated:YES];
        
    }else if (sender.tag==3)
    {
        YELAlarmListViewController *alarmList=[[YELAlarmListViewController alloc]initWithNibName:@"YELAlarmListViewController" bundle:nil];
        [self.navigationController pushViewController:alarmList animated:YES];
        
    }else if (sender.tag==4)
    {
        YELProvinceAlarmStatisticsViewController *province=[[YELProvinceAlarmStatisticsViewController alloc]initWithNibName:@"YELProvinceAlarmStatisticsViewController" bundle:nil];
        [self.navigationController pushViewController:province animated:YES];
        
    }else if (sender.tag==5)
    {
        YELTodoListViewController *todoList=[[YELTodoListViewController alloc]initWithNibName:@"YELTodoListViewController" bundle:nil];
        [self.navigationController pushViewController:todoList animated:YES];
        
    }else if (sender.tag==6)
    {
        YELHeadquartersAlarmTrendViewController *headquarters=[[YELHeadquartersAlarmTrendViewController alloc]initWithNibName:@"YELHeadquartersAlarmTrendViewController" bundle:nil];
        [self.navigationController pushViewController:headquarters animated:YES];
        
    }
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

- (void)viewDidUnload {
    [self setTopScrollview:nil];
    [self setBottomScrollview:nil];
    [self setBottomBackImage:nil];
    [super viewDidUnload];
}
#pragma mark Scorllview Delegate
- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    if (sender==self.topScrollview) {
        CGFloat pageWidth = sender.frame.size.width;
        int page = floor((sender.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        pageControl.currentPage = page;
    }

}

@end
