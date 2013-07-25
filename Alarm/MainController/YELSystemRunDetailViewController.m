//
//  YELSystemRunDetailViewController.m
//  Alarm
//
//  Created by rock on 13-7-25.
//  Copyright (c) 2013年 Ye Erliang. All rights reserved.
//

#import "YELSystemRunDetailViewController.h"
#import "YELAlarmListCell.h"
#import "YELAlarmDetailViewController.h"
@interface YELSystemRunDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_dataSource;
}
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@end

@implementation YELSystemRunDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title=@"告警列表";
        _dataSource=[[NSMutableArray alloc]init];
    }
    return self;
}

-(void)sendRequest
{
    NSDictionary *dict=[NSDictionary dictionaryWithObjectsAndKeys:TOKEN,@"token",
                        [self.dataSourceDictionary objectForKey:@"DOMAIN"],@"domain",
                        self.areaString,@"area",
                        [self.dataSourceDictionary objectForKey:@"SYS"],@"sys",
                        @"1000",@"pageSize",
                        @"1",@"pageNo",
                        nil];
    
    [[YELHttpHelper defaultHelper]getWarningWithParamter:dict sucess:^(NSDictionary *dictionary) {
        int code=[[dictionary objectForKey:@"code"] intValue];
        
        if (code==0)
        {
            
            NSArray *array=[dictionary objectForKey:@"data"];
            [_dataSource addObjectsFromArray:array];
            [self.myTableView reloadData];
            
        }else
        {
            [MBHUDView hudWithBody:[dictionary objectForKey:@"msg"] type:MBAlertViewHUDTypeDefault hidesAfter:1.0 show:YES];
        }
    } falid:^(NSString *errorMsg) {
        
        [MBHUDView hudWithBody:@"网络不给力" type:MBAlertViewHUDTypeDefault hidesAfter:1.0 show:YES];
        
    }];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self sendRequest];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *titleStr=[[_dataSource objectAtIndex:indexPath.row]objectForKey:@"EVENTTYP"];
    NSString *sysStr=[[_dataSource objectAtIndex:indexPath.row]objectForKey:@"SYS"];
    NSInteger height=[YELAlarmListCell neededHeightForCell:titleStr sysHeight:sysStr];
    return height;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataSource count];
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
    NSString *titleStr=[[_dataSource objectAtIndex:indexPath.row]objectForKey:@"EVENTTYP"];
    NSString *nameStr=[[_dataSource objectAtIndex:indexPath.row]objectForKey:@"AREA"];
    NSString *sysStr=[[_dataSource objectAtIndex:indexPath.row]objectForKey:@"SYS"];
    NSString *timeStr=[[_dataSource objectAtIndex:indexPath.row]objectForKey:@"TIME"];
    NSString *rnStr=[[_dataSource objectAtIndex:indexPath.row]objectForKey:@"RN"];
    
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YELAlarmDetailViewController *detailController=[[YELAlarmDetailViewController alloc]initWithNibName:@"YELAlarmDetailViewController" bundle:nil];
    detailController.dataSource=[_dataSource objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detailController animated:YES];
}
-(void)viewDidUnload
{
    [self setMyTableView:nil];
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
@end
