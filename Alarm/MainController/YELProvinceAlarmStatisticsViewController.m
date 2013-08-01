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
    NSMutableArray *dataSource;
    NSString *level;
    YELPopView *levelPopView;
    TSPopoverController *popoverController;
}
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UIButton *levelButton;
- (IBAction)pressLevelButton:(UIButton *)sender forEvent:(UIEvent *)event;

@end

@implementation YELProvinceAlarmStatisticsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title=@"省份告警统计分析";
        dataSource=[[NSMutableArray alloc]init];
        level=@"4";
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self sendRequest];
}
-(void)sendRequest
{
    NSDictionary *dict=[NSDictionary dictionaryWithObjectsAndKeys:TOKEN,@"token",
                        level,@"level",
                        @"100",@"pageSize",
                        @"1",@"pageNo",
                        nil];
    [[YELHttpHelper defaultHelper]getAllProvincesWithParamter:dict sucess:^(NSDictionary *dictionary) {
        int code=[[dictionary objectForKey:@"code"] intValue];
        if (code==0) {
            NSArray *array=[dictionary objectForKey:@"data"];
            [dataSource removeAllObjects];
            [dataSource addObjectsFromArray:array];
            [self scrollToTop:YES];
            [self.myTableView reloadData];
            
        }else
        {
            [MBHUDView hudWithBody:[dictionary objectForKey:@"msg"] type:MBAlertViewHUDTypeDefault hidesAfter:1.0 show:YES];
        }
    } falid:^(NSString *errorMsg) {
        [MBHUDView hudWithBody:@"网络链接超时" type:MBAlertViewHUDTypeDefault hidesAfter:1.0 show:YES];
        
    }];

}
- (void)scrollToTop:(BOOL)animated {
    [self.myTableView setContentOffset:CGPointMake(0,0) animated:animated];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
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
    return headView;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataSource count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellWithIdentifier = @"ProvinecCell";
    YELProvinecCell *cell = (YELProvinecCell*)[tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    if (cell == nil)
    {
        cell=[[YELProvinecCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellWithIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(YELProvinecCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        [cell.provinecLabel setBackgroundColor:[UIColor colorWithRed:128/255.0f green:0 blue:0 alpha:1.0]];
    }else if (indexPath.row==1)
    {
        [cell.provinecLabel setBackgroundColor:[UIColor colorWithRed:255/255.0f green:0 blue:0 alpha:1.0]];
    }else if (indexPath.row==2)
    {
        [cell.provinecLabel setBackgroundColor:[UIColor colorWithRed:255/255.0f green:102/255.0 blue:102/255.0 alpha:1.0]];
    }else
    {
        [cell.provinecLabel setBackgroundColor:[UIColor darkGrayColor]];
    }
    cell.provinecLabel.text=[[dataSource objectAtIndex:indexPath.row]objectForKey:@"PROVINCE"];
    NSNumber *monthNum=[[dataSource objectAtIndex:indexPath.row]objectForKey:@"MONTH1"];
    cell.monthLabel.text=[NSString stringWithFormat:@"%@",monthNum];
    NSNumber *preMonthNum=[[dataSource objectAtIndex:indexPath.row]objectForKey:@"MONTH2"];
    cell.preMonthLabel.text=[NSString stringWithFormat:@"%@",preMonthNum];
    NSString *ratioStr=[[dataSource objectAtIndex:indexPath.row]objectForKey:@"RATIO"];
    NSRange range=[ratioStr rangeOfString:@"↑"];
    if (range.location!=NSNotFound) {
        [cell.biLabel setTextColor:[UIColor redColor]];
    }
    NSRange xRange=[ratioStr rangeOfString:@"↓"];
    if (xRange.location!=NSNotFound) {
        [cell.biLabel setTextColor:[UIColor greenColor]];
    }
    if (range.location==NSNotFound && xRange.location==NSNotFound) {
        [cell.biLabel setTextColor:[UIColor blackColor]];
    }
    cell.biLabel.text=ratioStr;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setLevelButton:nil];
    [self setMyTableView:nil];
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
    [self sendRequest];
    [popoverController dismissPopoverAnimatd:YES];
}

@end
