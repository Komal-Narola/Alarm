//
//  YELAlarmNumberViewController.m
//  Alarm
//
//  Created by YY on 13-7-20.
//  Copyright (c) 2013年 Ye Erliang. All rights reserved.
//

#import "YELAlarmNumberViewController.h"
#import "YELPopView.h"
#import "TSPopoverController.h"
@interface YELAlarmNumberViewController ()
{
    YELPopView *topPopView;
    TSPopoverController *popoverController;
    NSMutableArray *dataSource;
    int type;
}
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UIButton *topButton;
- (IBAction)pressTopButton:(UIButton *)sender forEvent:(UIEvent *)event;

@end

@implementation YELAlarmNumberViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title=@"告警排名Top10";
        dataSource=[[NSMutableArray alloc]init];
        type=0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self sendRequest];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (type==1) {
        
    }else
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
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataSource count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellWithIdentifier = @"ProvinecCell";
    UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    if (cell == nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellWithIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.row==0) {
//        [cell.provinecLabel setBackgroundColor:[UIColor colorWithRed:128/255.0f green:0 blue:0 alpha:1.0]];
//    }else if (indexPath.row==1)
//    {
//        [cell.provinecLabel setBackgroundColor:[UIColor colorWithRed:255/255.0f green:0 blue:0 alpha:1.0]];
//    }else if (indexPath.row==2)
//    {
//        [cell.provinecLabel setBackgroundColor:[UIColor colorWithRed:255/255.0f green:102/255.0 blue:102/255.0 alpha:1.0]];
//    }else
//    {
//        [cell.provinecLabel setBackgroundColor:[UIColor darkGrayColor]];
//    }
//    cell.provinecLabel.text=[[dataSource objectAtIndex:indexPath.row]objectForKey:@"PROVINCE"];
//    NSNumber *monthNum=[[dataSource objectAtIndex:indexPath.row]objectForKey:@"MONTH1"];
//    cell.monthLabel.text=[NSString stringWithFormat:@"%@",monthNum];
//    NSNumber *preMonthNum=[[dataSource objectAtIndex:indexPath.row]objectForKey:@"MONTH2"];
//    cell.preMonthLabel.text=[NSString stringWithFormat:@"%@",preMonthNum];
//    NSString *ratioStr=[[dataSource objectAtIndex:indexPath.row]objectForKey:@"RATIO"];
//    NSRange range=[ratioStr rangeOfString:@"↑"];
//    if (range.location!=NSNotFound) {
//        [cell.biLabel setTextColor:[UIColor redColor]];
//    }
//    NSRange xRange=[ratioStr rangeOfString:@"↓"];
//    if (xRange.location!=NSNotFound) {
//        [cell.biLabel setTextColor:[UIColor greenColor]];
//    }
//    if (range.location==NSNotFound && xRange.location==NSNotFound) {
//        [cell.biLabel setTextColor:[UIColor blackColor]];
//    }
//    cell.biLabel.text=ratioStr;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setTopButton:nil];
    [self setMyTableView:nil];
    [super viewDidUnload];
}
- (IBAction)pressTopButton:(UIButton *)sender forEvent:(UIEvent *)event {
    if (!topPopView) {
        NSArray *array=[NSArray arrayWithObjects:@"本月集团频发告警系统",@"本月集团频发告警设备",@"本月集团频发告警类别",@"本月集团频发告警机房",@"本月省份频发告警类别", nil];
        topPopView=[[YELPopView alloc]initWithFrame:CGRectMake(0, 0, 200, [array count]*30) array:array target:self];
    }
    popoverController=[[TSPopoverController alloc]initWithView:topPopView];
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
        [self.topButton setTitle:@"本月集团频发告警系统" forState:UIControlStateNormal];
        type=0;
    }else if (sender.tag==101)
    {
        [self.topButton setTitle:@"本月集团频发告警设备" forState:UIControlStateNormal];
        type=1;
    }else if (sender.tag==102)
    {
        [self.topButton setTitle:@"本月集团频发告警类别" forState:UIControlStateNormal];
        type=2;
    }
    else if(sender.tag==103)
    {
        [self.topButton setTitle:@"本月集团频发告警机房" forState:UIControlStateNormal];
        type=3;
    }
    else if (sender.tag==104)
    {
        [self.topButton setTitle:@"本月省份频发告警类别" forState:UIControlStateNormal];
        type=4;
    }
    [self sendRequest];
    [popoverController dismissPopoverAnimatd:YES];
}
-(void)sendRequest
{
    NSDictionary *dict=[NSDictionary dictionaryWithObjectsAndKeys:TOKEN,@"token",nil];
    if (type==0)
    {
        //获取当月集团频发告警的系统前十名
        [[YELHttpHelper defaultHelper]getTopPinWithParamter:dict sucess:^(NSDictionary *dictionary) {
            int code=[[dictionary objectForKey:@"code"] intValue];
            if (code==0) {
                NSArray *array=[dictionary objectForKey:@"data"];
                [dataSource addObjectsFromArray:array];
                [self.myTableView reloadData];
            }else
            {
                [MBHUDView hudWithBody:[dictionary objectForKey:@"msg"] type:MBAlertViewHUDTypeDefault hidesAfter:1.0 show:YES];
            }
        } falid:^(NSString *errorMsg) {
            [MBHUDView hudWithBody:@"网络不给力" type:MBAlertViewHUDTypeDefault hidesAfter:1.0 show:YES];
            
        }];

    }
    else if (type==1)
    {
        //本月集团频发告警设备top10
        [[YELHttpHelper defaultHelper]getTopSheWithParamter:dict sucess:^(NSDictionary *dictionary) {
            int code=[[dictionary objectForKey:@"code"] intValue];
            if (code==0) {
                NSArray *array=[dictionary objectForKey:@"data"];
                [dataSource addObjectsFromArray:array];
                [self.myTableView reloadData];
            }else
            {
                [MBHUDView hudWithBody:[dictionary objectForKey:@"msg"] type:MBAlertViewHUDTypeDefault hidesAfter:1.0 show:YES];
            }
        } falid:^(NSString *errorMsg) {
            [MBHUDView hudWithBody:@"网络不给力" type:MBAlertViewHUDTypeDefault hidesAfter:1.0 show:YES];
        }];
    }
    else if (type==2)
    {
        //本月集团频发告警类别top10
        [[YELHttpHelper defaultHelper]getTopLeiWithParamter:dict sucess:^(NSDictionary *dictionary) {
            int code=[[dictionary objectForKey:@"code"] intValue];
            if (code==0) {
                NSArray *array=[dictionary objectForKey:@"data"];
                [dataSource addObjectsFromArray:array];
                [self.myTableView reloadData];
            }else
            {
                [MBHUDView hudWithBody:[dictionary objectForKey:@"msg"] type:MBAlertViewHUDTypeDefault hidesAfter:1.0 show:YES];
            }
        } falid:^(NSString *errorMsg) {
            [MBHUDView hudWithBody:@"网络不给力" type:MBAlertViewHUDTypeDefault hidesAfter:1.0 show:YES];
        }];
    }
    else if (type==3)
    {
        //本月集团频发告警机房top10
        [[YELHttpHelper defaultHelper]getTopJiWithParamter:dict sucess:^(NSDictionary *dictionary) {
            int code=[[dictionary objectForKey:@"code"] intValue];
            if (code==0) {
                NSArray *array=[dictionary objectForKey:@"data"];
                [dataSource addObjectsFromArray:array];
                [self.myTableView reloadData];
                
            }else
            {
                [MBHUDView hudWithBody:[dictionary objectForKey:@"msg"] type:MBAlertViewHUDTypeDefault hidesAfter:1.0 show:YES];
            }
        } falid:^(NSString *errorMsg) {
            [MBHUDView hudWithBody:@"网络不给力" type:MBAlertViewHUDTypeDefault hidesAfter:1.0 show:YES];
        }];
    }
    else if (type==4)
    {
        //本月省分频发告警类别top10
        [[YELHttpHelper defaultHelper]getTopShengWithParamter:dict sucess:^(NSDictionary *dictionary) {
            int code=[[dictionary objectForKey:@"code"] intValue];
            if (code==0) {
                NSArray *array=[dictionary objectForKey:@"data"];
                [dataSource addObjectsFromArray:array];
                [self.myTableView reloadData];
            }else
            {
                [MBHUDView hudWithBody:[dictionary objectForKey:@"msg"] type:MBAlertViewHUDTypeDefault hidesAfter:1.0 show:YES];
            }
        } falid:^(NSString *errorMsg) {
            [MBHUDView hudWithBody:@"网络不给力" type:MBAlertViewHUDTypeDefault hidesAfter:1.0 show:YES];
        }];
    }
}

@end
