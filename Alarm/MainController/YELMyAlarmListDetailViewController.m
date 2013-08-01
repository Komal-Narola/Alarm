//
//  YELMyAlarmListDetailViewController.m
//  Alarm
//
//  Created by rock on 13-7-25.
//  Copyright (c) 2013年 Ye Erliang. All rights reserved.
//
#import "YELMyAlarmListDetailViewController.h"
#import "YELDetailCell.h"
#import "YELDoTableView.h"
#import "KGModal.h"
#define TOP 2
@interface YELMyAlarmListDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@end

@implementation YELMyAlarmListDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title=@"告警详情";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 30;
    }
    NSString *contentStr=[self.dataSource objectForKey:@"CONTENT"];
    NSString *sysStr=[self.dataSource objectForKey:@"SYS"];
    NSInteger height=[YELDetailCell neededHeightForCell:contentStr sysStr:sysStr];
    return height;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row==1) {
        static NSString *CellWithIdentifier = @"detailCell";
        YELDetailCell *cell = (YELDetailCell*)[tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
        if (cell == nil)
        {
            cell=[[YELDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellWithIdentifier];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        return cell;
    }else
    {
        static NSString *CellWithIdentifier = @"easyCell";
        UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
        if (cell == nil)
        {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellWithIdentifier];
            UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 30)];
            label.tag=50;
            [label setTextAlignment:NSTextAlignmentCenter];
            [label setAdjustsFontSizeToFitWidth:YES];
            [label setBackgroundColor:[UIColor clearColor]];
            [cell.contentView addSubview:label];
            [cell.contentView setBackgroundColor:[UIColor lightGrayColor]];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        return cell;
    }
    
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        UILabel *label=(UILabel *)[cell.contentView viewWithTag:50];
        label.text=[self.dataSource objectForKey:@"EVENTTYP"];
    }else
    {
        NSString *timeStr=[self.dataSource objectForKey:@"TIME"];
        NSString *areaStr=[self.dataSource objectForKey:@"DOMAIN"];
        NSString *dominStr=[self.dataSource objectForKey:@"CONTENT"];
        NSString *contentStr=[self.dataSource objectForKey:@"RANGE"];
        NSString *rangeStr=[self.dataSource objectForKey:@"ELEVEL"];
        NSString *levelStr=[self.dataSource objectForKey:@"FAULTTYPE"];
        NSString *sysStr=[self.dataSource objectForKey:@"SYS"];
        NSString *personStr=[self.dataSource objectForKey:@"MPERSON"];
        NSInteger contentheight=[YELDetailCell neededHeightForDescription:contentStr];
        NSInteger sysheight=[YELDetailCell neededHeightForDescription:sysStr];
        NSInteger dominHeight=[YELDetailCell neededHeightForDescription:dominStr];
        
        YELDetailCell *detailCell=(YELDetailCell *)cell;
        detailCell.timeTitleLabel.frame=CGRectMake(5, 5, 70, 20);
        float orginX=CGRectGetMinX(detailCell.timeTitleLabel.frame);
        float width=CGRectGetWidth(detailCell.timeTitleLabel.frame);
        float height=CGRectGetHeight(detailCell.timeTitleLabel.frame);
        detailCell.timeContentLabel.frame=CGRectMake(78, 5, 215, 20);
        float rightorginX=CGRectGetMinX(detailCell.timeContentLabel.frame);
        float rightwidth=CGRectGetWidth(detailCell.timeContentLabel.frame);
        detailCell.timeContentLabel.text=timeStr;
        
        detailCell.areaTitleLabel.frame=CGRectMake(orginX, detailCell.timeTitleLabel.frame.origin.y +height+TOP, width,height);
        detailCell.areaContentLabel.frame=CGRectMake(rightorginX, detailCell.areaTitleLabel.frame.origin.y, rightwidth, height);
        detailCell.areaContentLabel.text=areaStr;
        
        detailCell.dominTitleLabel.frame=CGRectMake(orginX, detailCell.areaTitleLabel.frame.origin.y+height+TOP, width, height);
        detailCell.dominContentLabel.frame=CGRectMake(rightorginX, detailCell.dominTitleLabel.frame.origin.y, rightwidth, dominHeight);
        detailCell.dominContentLabel.text=dominStr;
        
        detailCell.detailTitleLabel.frame=CGRectMake(orginX, detailCell.dominTitleLabel.frame.origin.y+dominHeight+TOP, width, height);
        detailCell.detailContentLabel.frame=CGRectMake(rightorginX, detailCell.detailTitleLabel.frame.origin.y, rightwidth, contentheight);
        detailCell.detailContentLabel.text=contentStr;
        
        detailCell.rangTitleLabel.frame=CGRectMake(orginX, detailCell.detailContentLabel.frame.origin.y+detailCell.detailContentLabel.frame.size.height+TOP, width, height);
        detailCell.rangContentLabel.frame=CGRectMake(rightorginX, detailCell.rangTitleLabel.frame.origin.y, rightwidth, height);
        detailCell.rangContentLabel.text=rangeStr;
        
        detailCell.levelTitleLabel.frame=CGRectMake(orginX, detailCell.rangTitleLabel.frame.origin.y+height+TOP, width, height);
        detailCell.levelContentLabel.frame=CGRectMake(rightorginX, detailCell.levelTitleLabel.frame.origin.y, rightwidth, height);
        detailCell.levelContentLabel.text=levelStr;
        
        detailCell.sysTitleLabel.frame=CGRectMake(orginX, detailCell.levelTitleLabel.frame.origin.y+height+TOP, width, height);
        detailCell.sysContentLabel.frame=CGRectMake(rightorginX, detailCell.sysTitleLabel.frame.origin.y, rightwidth, sysheight);
        detailCell.sysContentLabel.text=sysStr;
        
        detailCell.personTitleLabel.frame=CGRectMake(orginX, detailCell.sysTitleLabel.frame.origin.y+sysheight+TOP, width, height);
        detailCell.personContentLabel.frame=CGRectMake(rightorginX, detailCell.personTitleLabel.frame.origin.y, rightwidth, height);
        detailCell.personContentLabel.text=personStr;
        
        detailCell.doButton.frame=CGRectMake(65, detailCell.personTitleLabel.frame.origin.y+height+5, 60, 30);
        [detailCell.doButton setTitle:@"认领" forState:UIControlStateNormal];
        [detailCell.doButton addTarget:self action:@selector(pressDoButton) forControlEvents:UIControlEventTouchUpInside];
        detailCell.doButton.enabled=NO;
        
        detailCell.sureButton.frame=CGRectMake(185, detailCell.personTitleLabel.frame.origin.y+height+5, 60, 30);
        [detailCell.sureButton setTitle:@"确认" forState:UIControlStateNormal];
        [detailCell.sureButton addTarget:self action:@selector(pressDoButton) forControlEvents:UIControlEventTouchUpInside];
        detailCell.sureButton.enabled=NO;
        
        detailCell.timeTitleLabel.text=@"产生时间:";
        [detailCell.areaTitleLabel setText:@"归  属  域:"];
        [detailCell.dominTitleLabel setText:@"事件描述:"];
        [detailCell.detailTitleLabel setText:@"事件范围:"];
        [detailCell.rangTitleLabel setText:@"事件级别:"];
        [detailCell.levelTitleLabel setText:@"事件性质:"];
        [detailCell.sysTitleLabel setText:@"所属系统:"];
        [detailCell.personTitleLabel setText:@"负  责  人:"];
    }
}
-(void)pressDoButton
{
    [MBHUDView dismissCurrentHUD];
    [MBHUDView hudWithBody:@"请等待" type:MBAlertViewHUDTypeDefault hidesAfter:0 show:YES];
    NSString *eventId=[self.dataSource objectForKey:@"EVENTID"];
    NSDictionary *dict=[NSDictionary dictionaryWithObjectsAndKeys:TOKEN,@"token",eventId,@"id", nil];
    [[YELHttpHelper defaultHelper]getDoPersonWithParamter:dict sucess:^(NSDictionary *dictionary) {
        [MBHUDView dismissCurrentHUD];
        int code=[[dictionary objectForKey:@"code"] intValue];
        if (code==0) {
            NSArray *array=[dictionary objectForKey:@"data"];
            int height=[array count]*44;
            int screenHeight=[UIScreen mainScreen].applicationFrame.size.height;
            if (height>screenHeight-100) {
                height=screenHeight-100;
            }
            YELDoTableView *doView=[[YELDoTableView alloc]initWithFrame:CGRectMake(0, 0, 280, height) array:array];
            [[KGModal sharedInstance]showWithContentView:doView andAnimated:YES];
            
        }else
        {
            [MBHUDView hudWithBody:[dictionary objectForKey:@"msg"] type:MBAlertViewHUDTypeDefault hidesAfter:1.0 show:YES];
        }
    } falid:^(NSString *errorMsg) {
        [MBHUDView dismissCurrentHUD];
        [MBHUDView hudWithBody:@"网络链接超时" type:MBAlertViewHUDTypeDefault hidesAfter:1.0 show:YES];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [self setMyTableView:nil];
    [super viewDidUnload];
}

@end
