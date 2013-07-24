//
//  YELAlarmListViewController.m
//  Alarm
//
//  Created by YY on 13-7-20.
//  Copyright (c) 2013年 Ye Erliang. All rights reserved.
//

#import "YELAlarmListViewController.h"
#import "PullingRefreshTableView.h"
#import "YELAlarmListCell.h"
#import "TSPopoverController.h"
#import "YELPopView.h"
@interface YELAlarmListViewController ()<PullingRefreshTableViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    BOOL refreshing;
    NSInteger page;
    NSMutableArray *dataSource;
    PullingRefreshTableView *myTableView;
    NSString *level;
    NSString *area;
    NSString *domain;
    
}
- (IBAction)pressLevelButton:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)pressSysButton:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)pressAreaButton:(UIButton *)sender forEvent:(UIEvent *)event;


@end

@implementation YELAlarmListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        dataSource=[[NSMutableArray alloc]init];
        self.title=@"集团告警列表";
        area=@"总部";
        level=@"";
        domain=@"";
    }
    return self;
}
-(void)sendRequest
{
    NSDictionary *dict=[NSDictionary dictionaryWithObjectsAndKeys:TOKEN,@"token",
                        level,@"level",
                        domain,@"domain",
                        area,@"area",
                        PAGESIZE,@"pageSize",
                        [NSString stringWithFormat:@"%d",page],@"pageNo",
                        nil];
    
    [[YELHttpHelper defaultHelper]getWarningWithParamter:dict sucess:^(NSDictionary *dictionary) {
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
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (page == 0)
    {
        [myTableView launchRefreshing];
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    myTableView=[[PullingRefreshTableView alloc]initWithFrame:CGRectMake(0, 34, 320, [UIScreen mainScreen].applicationFrame.size.height-34-49-44 ) pullingDelegate:self];
    myTableView.delegate=self;
    myTableView.dataSource=self;
    [myTableView setBackgroundColor:[UIColor clearColor]];
    [myTableView setBackgroundView:nil];
    [myTableView setSeparatorColor:[UIColor clearColor]];
    [myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:myTableView];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *titleStr=[[dataSource objectAtIndex:indexPath.row]objectForKey:@"CONTENT"];
    NSString *sysStr=[[dataSource objectAtIndex:indexPath.row]objectForKey:@"SYS"];
    NSInteger height=[YELAlarmListCell neededHeightForCell:titleStr sysHeight:sysStr];
    return height;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataSource count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellWithIdentifier = @"AlarmListCell";
    YELAlarmListCell *cell = (YELAlarmListCell*)[tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    if (cell == nil)
    {
        cell=[[YELAlarmListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellWithIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(YELAlarmListCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *titleStr=[[dataSource objectAtIndex:indexPath.row]objectForKey:@"CONTENT"];
    NSString *nameStr=[[dataSource objectAtIndex:indexPath.row]objectForKey:@"AREA"];
    NSString *sysStr=[[dataSource objectAtIndex:indexPath.row]objectForKey:@"SYS"];
    NSString *timeStr=[[dataSource objectAtIndex:indexPath.row]objectForKey:@"TIME"];
    NSString *rnStr=[[dataSource objectAtIndex:indexPath.row]objectForKey:@"RN"];
    
    NSInteger titleHeight=[YELAlarmListCell neededHeightForDescription:titleStr font:[UIFont systemFontOfSize:17.0]];
    NSInteger sysHeight=[YELAlarmListCell neededHeightForDescription:sysStr font:[UIFont systemFontOfSize:15.0]];
    cell.titleLabel.text=titleStr;
    cell.titleLabel.frame=CGRectMake(70, 2+5, 225, titleHeight);
    
    NSMutableAttributedString *attriString=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"归属地:%@",nameStr]];
    [attriString addAttribute:NSForegroundColorAttributeName
                        value:[UIColor lightGrayColor]
                        range:NSMakeRange(4, [nameStr length])];
    cell.nameLabel.attributedText=attriString;
    
    cell.nameLabel.frame=CGRectMake(cell.titleLabel.frame.origin.x, cell.titleLabel.frame.size.height+cell.titleLabel.frame.origin.y+2, cell.titleLabel.frame.size.width, 20);
    
    NSMutableAttributedString *sysAttriString=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"归属系统:%@",sysStr]];
    [sysAttriString addAttribute:NSForegroundColorAttributeName
                        value:[UIColor lightGrayColor]
                        range:NSMakeRange(5, [sysStr length])];
    
    cell.sysLabel.attributedText=sysAttriString;
    cell.sysLabel.frame=CGRectMake(cell.titleLabel.frame.origin.x, cell.nameLabel.frame.size.height+cell.nameLabel.frame.origin.y+2, cell.titleLabel.frame.size.width, sysHeight);
    
    cell.timeLabel.frame=CGRectMake(cell.titleLabel.frame.origin.x, cell.sysLabel.frame.size.height+cell.sysLabel.frame.origin.y+2, cell.titleLabel.frame.size.width, 20);
    
    NSMutableAttributedString *timeAttriString=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"产生事件:%@",timeStr]];
        
    [timeAttriString addAttribute:NSForegroundColorAttributeName
                                value:[UIColor lightGrayColor]
                                range:NSMakeRange(5, [timeStr length])];
    cell.timeLabel.attributedText=timeAttriString;
    
    NSInteger height=[YELAlarmListCell neededHeightForCell:titleStr sysHeight:sysStr];
    cell.backImageView.frame=CGRectMake(5, 2, 310, height-4);
    
    UIImage *leftImage=[self getImage:[rnStr intValue]];
    cell.timeImageView.image=leftImage;
    cell.timeImageView.frame=CGRectMake(22, height/2-leftImage.size.height/2, leftImage.size.width, leftImage.size.height);
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
-(void)viewDidUnload
{
    myTableView=nil;
    [super viewDidUnload];
    
}
-(UIImage *)getImage :(int)rn
{
    switch (rn) {
        case 0:
            return LOADIMAGE(@"jinggao0@2x", @"png");
        case 1:
            return LOADIMAGE(@"jinggao1@2x", @"png");
        case 2:
            return LOADIMAGE(@"jinggao2@2x", @"png");
        case 3:
            return LOADIMAGE(@"jinggao3@2x", @"png");
        case 4:
            return LOADIMAGE(@"jinggao4@2x", @"png");
        case 5:
            return LOADIMAGE(@"jinggao5@2x", @"png");
        case 6:
            return LOADIMAGE(@"jinggao6@2x", @"png");
        case 7:
            return LOADIMAGE(@"jinggao7@2x", @"png");
        case 8:
            return LOADIMAGE(@"jinggao8@2x", @"png");
        default:
            return LOADIMAGE(@"jinggao9@2x", @"png");
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
- (IBAction)pressLevelButton:(UIButton *)sender forEvent:(UIEvent *)event {
    NSArray *array=[NSArray arrayWithObjects:@"全部",@"重要",@"紧急", nil];
    YELPopView *popview=[[YELPopView alloc]initWithFrame:CGRectMake(0, 0, 100, [array count]*30) array:array target:self];
    TSPopoverController *popoverController=[[TSPopoverController alloc]initWithView:popview];
    popoverController.alpha=0.7;
    [popoverController showPopoverWithTouch:event];
}

- (IBAction)pressSysButton:(UIButton *)sender forEvent:(UIEvent *)event {
}

- (IBAction)pressAreaButton:(UIButton *)sender forEvent:(UIEvent *)event {
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
    DLog(@"dsds=%d",sender.tag);
}
@end
