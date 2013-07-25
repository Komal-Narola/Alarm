//
//  YELProvinceAlarmStatisticsViewController.m
//  Alarm
//
//  Created by YY on 13-7-20.
//  Copyright (c) 2013年 Ye Erliang. All rights reserved.
//

#import "YELProvinceAlarmStatisticsViewController.h"
#import "YELProvinecCell.h"
#import "YELPopView.h"
#import "TSPopoverController.h"
@interface YELProvinceAlarmStatisticsViewController ()
{
    BOOL refreshing;
    NSInteger page;
    NSMutableArray *dataSource;
    PullingRefreshTableView *myTableView;
    NSString *level;
    YELPopView *levelPopView;
    TSPopoverController *popoverController;
}
@property (weak, nonatomic) IBOutlet UIButton *levelButton;
- (IBAction)pressLevelButton:(UIButton *)sender forEvent:(UIEvent *)event;


@end

@implementation YELProvinceAlarmStatisticsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title=@"省份告警统计分析";
        level=@"4";
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (page == 0)
    {
        [myTableView launchRefreshing];
    }
}
-(void)sendRequest
{
    NSDictionary *dict=[NSDictionary dictionaryWithObjectsAndKeys:TOKEN,@"token",
                        level,@"level",
                        PAGESIZE,@"pagesize",
                        [NSString stringWithFormat:@"%d",page],@"pageNo",
                        nil];
    [[YELHttpHelper defaultHelper]getAllProvincesWithParamter:dict sucess:^(NSDictionary *dictionary) {
        int code=[[dictionary objectForKey:@"code"] intValue];
        if (code==0) {
            NSArray *array=[dictionary objectForKey:@"data"];
            if (page==1) {
                [dataSource removeAllObjects];
            }
            [dataSource addObjectsFromArray:array];
            if ([dataSource count]<10) {
                [myTableView tableViewDidFinishedLoading];
                myTableView.reachedTheEnd  = YES;
                [myTableView reloadData];
            }else
            {
                [myTableView tableViewDidFinishedLoading];
                myTableView.reachedTheEnd  = NO;
                [myTableView reloadData];
            }
        }else
        {
            [MBHUDView hudWithBody:[dictionary objectForKey:@"msg"] type:MBAlertViewHUDTypeDefault hidesAfter:1.0 show:YES];
        }
    } falid:^(NSString *errorMsg) {
        [myTableView tableViewDidFinishedLoading];
        myTableView.reachedTheEnd  = YES;
        [MBHUDView hudWithBody:@"网络不给力" type:MBAlertViewHUDTypeDefault hidesAfter:1.0 show:YES];
        
    }];

}
//判断是刷新还是加载更多
- (void)loadData
{
    page++;
    if (refreshing)
    {
        page = 1;
        refreshing = NO;
        [self sendRequest];
    }
    else
    {
        [self sendRequest];
    }
}

-(void)initUiKit
{
    UIView *headView=[[UIView alloc]initWithFrame:CGRectMake(0, 30, 320, 30)];
    [headView setBackgroundColor:[UIColor whiteColor]];
    UILabel *dominLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 79, 30)];
    dominLabel.text=@"所在省";
    [dominLabel setTextAlignment:NSTextAlignmentCenter];
    [dominLabel setFont:[UIFont boldSystemFontOfSize:15.0]];
    [dominLabel setBackgroundColor:[UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1.0]];
    [headView addSubview:dominLabel];
    
    UILabel *systemLabel=[[UILabel alloc]initWithFrame:CGRectMake(81, 0, 79, 30)];
    systemLabel.text=@"上月";
    [systemLabel setTextAlignment:NSTextAlignmentCenter];
    [systemLabel setBackgroundColor:[UIColor lightGrayColor]];
    [systemLabel setFont:[UIFont boldSystemFontOfSize:15.0]];
    [headView addSubview:systemLabel];
    
    UILabel *platformsLabel=[[UILabel alloc]initWithFrame:CGRectMake(161, 0, 79, 30)];
    platformsLabel.text=@"上上月";
    [platformsLabel setTextAlignment:NSTextAlignmentCenter];
    [platformsLabel setBackgroundColor:[UIColor lightGrayColor]];
    [platformsLabel setFont:[UIFont boldSystemFontOfSize:15.0]];
    [headView addSubview:platformsLabel];
    
    UILabel *applyLabel=[[UILabel alloc]initWithFrame:CGRectMake(241, 0, 79, 30)];
    applyLabel.text=@"环比";
    [applyLabel setTextAlignment:NSTextAlignmentCenter];
    [applyLabel setBackgroundColor:[UIColor lightGrayColor]];
    [applyLabel setFont:[UIFont boldSystemFontOfSize:15.0]];
    [headView addSubview:applyLabel];
    [self.view addSubview:headView];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initUiKit];
    myTableView=[[PullingRefreshTableView alloc]initWithFrame:CGRectMake(0, 60, 320, [UIScreen mainScreen].applicationFrame.size.height-44-30) pullingDelegate:self];
    myTableView.delegate=self;
    myTableView.dataSource=self;
    [myTableView setBackgroundColor:[UIColor clearColor]];
    [myTableView setBackgroundView:nil];
    [myTableView setSeparatorColor:[UIColor clearColor]];
    [myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:myTableView];
    // Do any additional setup after loading the view from its nib.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataSource count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellWithIdentifier = @"ToDoList";
    YELProvinecCell *cell = (YELProvinecCell*)[tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    if (cell == nil)
    {
        cell=[[YELProvinecCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellWithIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return cell;
    
}
#pragma mark - PullingRefreshTableViewDelegate
- (void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView
{
    refreshing = YES;
    [self performSelector:@selector(loadData) withObject:nil afterDelay:1.f];
}

- (NSDate *)pullingTableViewRefreshingFinishedDate{
    NSDateFormatter *df = [[NSDateFormatter alloc] init ];
    df.dateFormat = @"yyyy-MM-dd HH:mm";
    NSDate *curDate = [NSDate date];
    NSString * curTime = [df stringFromDate:curDate];
    NSDate *date = [df dateFromString:curTime];
    return date;
}

- (void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView
{
    [self performSelector:@selector(loadData) withObject:nil afterDelay:1.f];
}
#pragma mark - Scroll

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [myTableView tableViewDidScroll:scrollView];
    
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [myTableView tableViewDidEndDragging:scrollView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setLevelButton:nil];
    [super viewDidUnload];
}
- (IBAction)pressLevelButton:(UIButton *)sender forEvent:(UIEvent *)event {
    if (!levelPopView) {
        NSArray *array=[NSArray arrayWithObjects:@"重要",@"紧急", nil];
        levelPopView=[[YELPopView alloc]initWithFrame:CGRectMake(0, 0, 100, [array count]*30) array:array target:self];
    }
    popoverController=[[TSPopoverController alloc]initWithView:levelPopView];
    popoverController.alpha=0.9;
    [popoverController showPopoverWithTouch:event];
}
-(void)pressButton:(UIButton *)sender
{
    sender.selected=!sender.selected;
    if (sender.selected) {
        for (UIView *bt in sender.superview.subviews) {
            if ([bt isKindOfClass:[UIButton class]]) {
                UIButton *button=(UIButton *)bt;
                if (button != sender) {
                    button.selected=NO;
                }
            }
            
        }
    }
    if (sender.tag==100) {
        [self.levelButton setTitle:@"重要" forState:UIControlStateNormal];
        level=@"4";
    }else if (sender.tag==101)
    {
        [self.levelButton setTitle:@"紧急" forState:UIControlStateNormal];
        level=@"5";
    }
    [myTableView launchRefreshing];
    [popoverController dismissPopoverAnimatd:YES];
}

@end
