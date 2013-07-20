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
    NSDictionary *dict=[NSDictionary dictionaryWithObjectsAndKeys:TOKEN,@"token",PAGESIZE,@"pageSize",page,@"pageNo", nil];
    [[YELHttpHelper defaultHelper]getTodoListWithParamter:dict sucess:^(NSDictionary *dictionary) {
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
//        [self sendRequest];
    }
    else
    {
//        [self sendRequest];
    }
    [myTableView tableViewDidFinishedLoading];
    myTableView.reachedTheEnd  = NO;
    [myTableView reloadData];
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
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
