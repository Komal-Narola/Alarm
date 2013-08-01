//
//  YELAlarmDetailViewController.m
//  Alarm
//
//  Created by YY on 13-7-24.
//  Copyright (c) 2013年 Ye Erliang. All rights reserved.
//

#import "YELAlarmDetailViewController.h"
#import "YELDetailCell.h"
#import "YELDoTableView.h"
#import "KGModal.h"
#define TOP 2
@interface YELAlarmDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@end

@implementation YELAlarmDetailViewController

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
        NSString *areaStr=[self.dataSource objectForKey:@"AREA"];
        NSString *dominStr=[self.dataSource objectForKey:@"DOMAIN"];
        NSString *contentStr=[self.dataSource objectForKey:@"CONTENT"];
        NSString *rangeStr=[self.dataSource objectForKey:@"RANGE"];
        NSString *levelStr=[self.dataSource objectForKey:@"ELEVEL"];
        NSString *sysStr=[self.dataSource objectForKey:@"SYS"];
        NSString *personStr=[self.dataSource objectForKey:@"MPERSON"];
        NSInteger contentheight=[YELDetailCell neededHeightForDescription:contentStr];
        NSInteger sysheight=[YELDetailCell neededHeightForDescription:sysStr];
        
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
        detailCell.dominContentLabel.frame=CGRectMake(rightorginX, detailCell.dominTitleLabel.frame.origin.y, rightwidth, height);
        detailCell.dominContentLabel.text=dominStr;
        
        detailCell.detailTitleLabel.frame=CGRectMake(orginX, detailCell.dominTitleLabel.frame.origin.y+height+TOP, width, height);
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
        
        detailCell.doButton.frame=CGRectMake(orginX, detailCell.personTitleLabel.frame.origin.y+height+5, 290, 30);
        [detailCell.doButton addTarget:self action:@selector(pressDoButton) forControlEvents:UIControlEventTouchUpInside];
        detailCell.timeTitleLabel.text=@"产生时间:";
        [detailCell.areaTitleLabel setText:@"归  属  地:"];
        [detailCell.dominTitleLabel setText:@"归  属  域:"];
        [detailCell.detailTitleLabel setText:@"事件描述:"];
        [detailCell.rangTitleLabel setText:@"事件范围:"];
        [detailCell.levelTitleLabel setText:@"事件级别:"];
        [detailCell.sysTitleLabel setText:@"所属系统:"];
        [detailCell.personTitleLabel setText:@"负  责  人:"];
        [detailCell.doButton setTitle:@"催  办" forState:UIControlStateNormal];
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
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setMyTableView:nil];
    [super viewDidUnload];
}

@end
