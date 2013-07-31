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
#import "YELTopNumCell.h"
#import "YELTopAnotherNumCell.h"
@interface YELAlarmNumberViewController ()
{
    YELPopView *topPopView;
    TSPopoverController *popoverController;
    NSArray *dataSource;
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
        dataSource=[[NSArray alloc]init];
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
    UIView *headView=[[UIView alloc]initWithFrame:CGRectMake(0, 30, 320, 30)];
    [headView setBackgroundColor:[UIColor whiteColor]];
    if (type==1)
    {
        //排名 设备 系统 机房 总数
        for (int i=0; i<5; i++)
        {
            UILabel *dominLabel=[[UILabel alloc]initWithFrame:CGRectMake(i*64, 0, 63, 30)];
            if (i==0) {
                dominLabel.text=@"排名";
                [dominLabel setBackgroundColor:[UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1.0]];
            }
            else if (i==1)
            {
                dominLabel.text=@"设备";
                [dominLabel setBackgroundColor:[UIColor lightGrayColor]];
            }
            else if (i==2)
            {
                dominLabel.text=@"系统";
                [dominLabel setBackgroundColor:[UIColor lightGrayColor]];
            }
            else if (i==3)
            {
                dominLabel.text=@"机房";
                [dominLabel setBackgroundColor:[UIColor lightGrayColor]];
            }
            else if (i==4)
            {
                dominLabel.text=@"总数";
                [dominLabel setBackgroundColor:[UIColor lightGrayColor]];
            }
            [dominLabel setTextAlignment:NSTextAlignmentCenter];
            [headView addSubview:dominLabel];
        }
        
    }
    else
    {
        UILabel *dominLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
        dominLabel.text=@"排名";
        [dominLabel setTextAlignment:NSTextAlignmentCenter];
        [dominLabel setFont:[UIFont boldSystemFontOfSize:15.0]];
        [dominLabel setBackgroundColor:[UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1.0]];
        [headView addSubview:dominLabel];
        
        UILabel *systemLabel=[[UILabel alloc]initWithFrame:CGRectMake(71, 0, 178, 30)];
        [systemLabel setTextAlignment:NSTextAlignmentCenter];
        [systemLabel setBackgroundColor:[UIColor lightGrayColor]];
        [systemLabel setFont:[UIFont boldSystemFontOfSize:15.0]];
        [headView addSubview:systemLabel];
        
        UILabel *platformsLabel=[[UILabel alloc]initWithFrame:CGRectMake(250, 0, 70, 30)];
        [platformsLabel setTextAlignment:NSTextAlignmentCenter];
        [platformsLabel setBackgroundColor:[UIColor lightGrayColor]];
        [platformsLabel setFont:[UIFont boldSystemFontOfSize:15.0]];
        [headView addSubview:platformsLabel];
        
        if (type==0) {
            systemLabel.text=@"所属系统";
            platformsLabel.text=@"告警数量";
        }
        else if (type==2)
        {
            systemLabel.text=@"类型";
            platformsLabel.text=@"总数";
            
        }
        else if (type==3)
        {
            systemLabel.text=@"机房";
            platformsLabel.text=@"总数";
            
        }else if (type==4)
        {
            systemLabel.text=@"类型";
            platformsLabel.text=@"总数";
        }
    }
     return headView;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataSource count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (type==1) {

        static NSString *CellWithIdentifier = @"topAnotherCell";
        YELTopAnotherNumCell *cell = (YELTopAnotherNumCell*)[tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
        if (cell == nil)
        {
            cell=[[YELTopAnotherNumCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellWithIdentifier];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        return cell;
    }
    else
    {
        static NSString *CellWithIdentifier = @"topNumCell";
        YELTopNumCell *cell = (YELTopNumCell*)[tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
        if (cell == nil)
        {
            cell=[[YELTopNumCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellWithIdentifier];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        return cell;
    }

}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (type==1)
    {
        YELTopAnotherNumCell *anotherCell=(YELTopAnotherNumCell *)cell;
        if (indexPath.row==0)
        {
            [anotherCell.topLabel setBackgroundColor:[UIColor colorWithRed:128/255.0f green:0 blue:0 alpha:1.0]];
        }
        else if (indexPath.row==1)
        {
            [anotherCell.topLabel setBackgroundColor:[UIColor colorWithRed:255/255.0f green:0 blue:0 alpha:1.0]];
        }
        else if (indexPath.row==2)
        {
            [anotherCell.topLabel setBackgroundColor:[UIColor colorWithRed:255/255.0f green:102/255.0 blue:102/255.0 alpha:1.0]];
        }
        else
        {
            [anotherCell.topLabel setBackgroundColor:[UIColor darkGrayColor]];
        }
        NSNumber *topnumber=[[dataSource objectAtIndex:indexPath.row]objectForKey:@"POSITION"];
        anotherCell.topLabel.text=[NSString stringWithFormat:@"%@",topnumber];
        anotherCell.sheLabel.text=[[dataSource objectAtIndex:indexPath.row]objectForKey:@"DEVICE"];
        anotherCell.sysLabel.text=[[dataSource objectAtIndex:indexPath.row]objectForKey:@"SYS"];
        anotherCell.jiLabel.text=[[dataSource objectAtIndex:indexPath.row]objectForKey:@"CROOM"];
        NSNumber *number=[[dataSource objectAtIndex:indexPath.row]objectForKey:@"TOTAL"];
        anotherCell.zongLabel.text=[NSString stringWithFormat:@"%@",number];
    }
    else
    {
        YELTopNumCell *topCell=(YELTopNumCell*)cell;
        if (indexPath.row==0) {
            [topCell.topLabel setBackgroundColor:[UIColor colorWithRed:128/255.0f green:0 blue:0 alpha:1.0]];
        }else if (indexPath.row==1)
        {
            [topCell.topLabel setBackgroundColor:[UIColor colorWithRed:255/255.0f green:0 blue:0 alpha:1.0]];
        }else if (indexPath.row==2)
        {
            [topCell.topLabel setBackgroundColor:[UIColor colorWithRed:255/255.0f green:102/255.0 blue:102/255.0 alpha:1.0]];
        }else
        {
            [topCell.topLabel setBackgroundColor:[UIColor darkGrayColor]];
        }
        NSNumber *topnumber=[[dataSource objectAtIndex:indexPath.row]objectForKey:@"POSITION"];
        topCell.topLabel.text=[NSString stringWithFormat:@"%@",topnumber];
        if (type==0) {
            
            topCell.contentLabel.text=[[dataSource objectAtIndex:indexPath.row]objectForKey:@"SYS"];
            
        }else if (type==2) {
            
            topCell.contentLabel.text=[[dataSource objectAtIndex:indexPath.row]objectForKey:@"TYPE"];
            
        }else if (type==3)
        {
            topCell.contentLabel.text=[[dataSource objectAtIndex:indexPath.row]objectForKey:@"CROOM"];
        }
        else if (type==4)
        {
            topCell.contentLabel.text=[[dataSource objectAtIndex:indexPath.row]objectForKey:@"TYPE"];
        }
        
        NSNumber *number=[[dataSource objectAtIndex:indexPath.row]objectForKey:@"TOTAL"];
        topCell.numLabel.text=[NSString stringWithFormat:@"%@",number];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [self setTopButton:nil];
    [self setMyTableView:nil];
    [super viewDidUnload];
}
- (IBAction)pressTopButton:(UIButton *)sender forEvent:(UIEvent *)event {
    if (!topPopView) {
        NSArray *array=[NSArray arrayWithObjects:@"本月集团频发告警系统",@"本月集团频发告警设备",@"本月集团频发告警类别",@"本月集团频发告警机房",@"本月省份频发告警类别", nil];
        topPopView=[[YELPopView alloc]initWithFrame:CGRectMake(0, 0, 223, [array count]*30) array:array target:self];
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
                dataSource=array;
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
                DLog(@"ads=%@",array);
                dataSource=array;
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
                dataSource=array;
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
                dataSource=array;
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
                dataSource=array;
                [self.myTableView reloadData];
            }else
            {
                [MBHUDView hudWithBody:[dictionary objectForKey:@"msg"] type:MBAlertViewHUDTypeDefault hidesAfter:1.0 show:YES];
            }
        } falid:^(NSString *errorMsg)
        {
            [MBHUDView hudWithBody:@"网络不给力" type:MBAlertViewHUDTypeDefault hidesAfter:1.0 show:YES];
        }];
    }
}

@end
