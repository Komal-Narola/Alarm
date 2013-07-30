//
//  YELTodoListViewController.m
//  Alarm
//
//  Created by YY on 13-7-20.
//  Copyright (c) 2013年 Ye Erliang. All rights reserved.
//

#import "YELTodoListViewController.h"
#import "YELTodoListCell.h"
@interface YELTodoListViewController ()
{
    BOOL refreshing;
    NSInteger page;
    NSMutableArray *dataSource;
    PullingRefreshTableView *myTableView;
}

@end

@implementation YELTodoListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title=@"待办事项";
        dataSource=[[NSMutableArray alloc]init];
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
    NSDictionary *dict=[NSDictionary dictionaryWithObjectsAndKeys:
                        TOKEN,@"token",
                        PAGESIZE,@"pageSize",
                        [NSString stringWithFormat:@"%d",page],@"pageNo",
                        nil];
    [[YELHttpHelper defaultHelper]getTodoListWithParamter:dict sucess:^(NSDictionary *dictionary) {
        int code=[[dictionary objectForKey:@"code"] intValue];
        if (code==0) {
            NSArray *array=[dictionary objectForKey:@"data"];
            if (page==1) {
                [dataSource removeAllObjects];
            }
            [dataSource addObjectsFromArray:array];
            if ([dataSource count]<10) {
                [myTableView reloadData];
                [myTableView tableViewDidFinishedLoading];
                myTableView.reachedTheEnd  = YES;
                
            }else
            {
                [myTableView reloadData];
                [myTableView tableViewDidFinishedLoading];
                myTableView.reachedTheEnd  = NO;
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

- (void)viewDidLoad
{
    [super viewDidLoad];

    myTableView=[[PullingRefreshTableView alloc]initWithFrame:CGRectMake(0, 0, 320, [UIScreen mainScreen].applicationFrame.size.height-44 ) pullingDelegate:self];
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
    NSString *titleStr=[[dataSource objectAtIndex:indexPath.row]objectForKey:@"TITLE"];
    NSInteger height=[YELTodoListCell neededHeightForCell:titleStr];
    return height;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataSource count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellWithIdentifier = @"ToDoList";
    YELTodoListCell *cell = (YELTodoListCell*)[tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    if (cell == nil)
    {
        cell=[[YELTodoListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellWithIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(YELTodoListCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *titleStr=[[dataSource objectAtIndex:indexPath.row]objectForKey:@"TITLE"];
    NSString *nameStr=[[dataSource objectAtIndex:indexPath.row]objectForKey:@"USERNAME"];
    NSString *timeStr=[[dataSource objectAtIndex:indexPath.row]objectForKey:@"ORDERDATE"];
    NSInteger cellHeight=[YELTodoListCell neededHeightForCell:titleStr];
    NSInteger titleHeight=[YELTodoListCell neededHeightForDescription:titleStr];
    cell.titleLabel.text=titleStr;
    cell.titleLabel.frame=CGRectMake(70, 2+5, 225, titleHeight);
    
    NSMutableAttributedString *attriString=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"派单人:%@",nameStr]];
    [attriString addAttribute:NSForegroundColorAttributeName
                        value:[UIColor redColor]
                        range:NSMakeRange(4, [nameStr length])];
    
    cell.nameLabel.attributedText=attriString;

    
    cell.nameLabel.frame=CGRectMake(cell.titleLabel.frame.origin.x, cell.titleLabel.frame.size.height+cell.titleLabel.frame.origin.y+2, cell.titleLabel.frame.size.width, 20);
    
    cell.timeLabel.frame=CGRectMake(cell.titleLabel.frame.origin.x, cell.nameLabel.frame.size.height+cell.nameLabel.frame.origin.y+2, cell.titleLabel.frame.size.width, 20);
    
    if (timeStr!=nil && [timeStr length]==19) {
        NSString *dataStr=[timeStr substringWithRange:NSMakeRange(0, 10)];
        NSMutableAttributedString *timeAttriString=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"派发时间:%@",dataStr]];

        [timeAttriString addAttribute:NSForegroundColorAttributeName
                            value:[UIColor lightGrayColor]
                            range:NSMakeRange(5, [dataStr length])];
        cell.timeLabel.attributedText=timeAttriString;
        NSString *minStr=[timeStr substringWithRange:NSMakeRange(11, 8)];
        cell.leftTimeLabel.text=[NSString stringWithFormat:@"%@",minStr];
    }
    cell.backImageView.frame=CGRectMake(5, 2, 310, cellHeight-4);
}
#pragma mark - PullingRefreshTableViewDelegate
- (void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView
{
    refreshing = YES;
    [self performSelector:@selector(loadData) withObject:nil afterDelay:0];
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
    [self performSelector:@selector(loadData) withObject:nil afterDelay:0];
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

}
/*去掉多余的分割线
- (void)setExtraCellLineHidden: (UITableView *)tableView{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
//    [tableView setTableHeaderView:view];

}
 */
- (void)viewDidUnload {
    myTableView=nil;
    [super viewDidUnload];
}
@end
