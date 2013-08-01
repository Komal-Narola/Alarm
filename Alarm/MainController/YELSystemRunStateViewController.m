//
//  YELSystemRunStateViewController.m
//  Alarm
//
//  Created by YY on 13-7-20.
//  Copyright (c) 2013年 Ye Erliang. All rights reserved.
//

#import "YELSystemRunStateViewController.h"
#import "YELSystemStateCell.h"
#import "YELSystemRunDetailViewController.h"
#import "YELPopView.h"
#import "TSPopoverController.h"

@interface YELSystemRunStateViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *_dataSource;
    NSString *_areaString;
    YELPopView *areaPopview;
    TSPopoverController *popoverController;
}
@property (weak, nonatomic) IBOutlet UITableView *_myTableView;
@property (weak, nonatomic) IBOutlet UIButton *stateButton;
- (IBAction)pressAreaButton:(UIButton *)sender forEvent:(UIEvent *)event;


@end

@implementation YELSystemRunStateViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title=@"系统运行状态";
        _areaString=@"总部";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self sendRequest];
}
-(void)sendRequest
{
    NSDictionary *dict=[NSDictionary dictionaryWithObjectsAndKeys:_areaString,@"domain",TOKEN,@"token", nil];
    [[YELHttpHelper defaultHelper]getSystemStateWithParamter:dict sucess:^(NSDictionary *dictionary) {
        int code=[[dictionary objectForKey:@"code"]intValue];
        if (code==0) {
            NSArray *array=[dictionary objectForKey:@"data"];
                _dataSource=[[NSArray alloc]initWithArray:array];
                [self._myTableView reloadData];
        }else
        {
            [MBHUDView hudWithBody:[dictionary objectForKey:@"msg"] type:MBAlertViewHUDTypeDefault hidesAfter:1.0 show:YES];
        }
    } falid:^(NSString *errorMsg) {
            [MBHUDView hudWithBody:@"网络链接超时" type:MBAlertViewHUDTypeDefault hidesAfter:1.0 show:YES];
    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataSource count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str=[[_dataSource objectAtIndex:indexPath.row]objectForKey:@"SYS"];
    NSInteger height=[YELSystemStateCell neededHeightForDescription:str];
    if (height<44) {
        height=44;
    }
    return height;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    [headView setBackgroundColor:[UIColor whiteColor]];
    UILabel *dominLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 72, 30)];
    dominLabel.text=@"所属域";
    [dominLabel setTextAlignment:NSTextAlignmentCenter];
    [dominLabel setFont:[UIFont boldSystemFontOfSize:15.0]];
    [dominLabel setBackgroundColor:[UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1.0]];
    [headView addSubview:dominLabel];
    
    UILabel *systemLabel=[[UILabel alloc]initWithFrame:CGRectMake(73, 0, 105, 30)];
    systemLabel.text=@"系统";
    [systemLabel setTextAlignment:NSTextAlignmentCenter];
    [systemLabel setBackgroundColor:[UIColor lightGrayColor]];
    [systemLabel setFont:[UIFont boldSystemFontOfSize:15.0]];
    [headView addSubview:systemLabel];
    
    UILabel *platformsLabel=[[UILabel alloc]initWithFrame:CGRectMake(179, 0, 46, 30)];
    platformsLabel.text=@"平台";
    [platformsLabel setTextAlignment:NSTextAlignmentCenter];
    [platformsLabel setBackgroundColor:[UIColor lightGrayColor]];
    [platformsLabel setFont:[UIFont boldSystemFontOfSize:15.0]];
    [headView addSubview:platformsLabel];
    
    UILabel *applyLabel=[[UILabel alloc]initWithFrame:CGRectMake(226, 0, 46, 30)];
    applyLabel.text=@"应用";
    [applyLabel setTextAlignment:NSTextAlignmentCenter];
    [applyLabel setBackgroundColor:[UIColor lightGrayColor]];
    [applyLabel setFont:[UIFont boldSystemFontOfSize:15.0]];
    [headView addSubview:applyLabel];
    
    UILabel *businessLabel=[[UILabel alloc]initWithFrame:CGRectMake(273, 0, 47, 30)];
    businessLabel.text=@"业务";
    [businessLabel setTextAlignment:NSTextAlignmentCenter];
    [businessLabel setBackgroundColor:[UIColor lightGrayColor]];
    [businessLabel setFont:[UIFont boldSystemFontOfSize:15.0]];
    [headView addSubview:businessLabel];
    return headView;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellWithIdentifier = @"systemState";
    YELSystemStateCell *cell = (YELSystemStateCell*)[tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    if (cell == nil)
    {
        cell=[[YELSystemStateCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellWithIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
        if (indexPath.row%2==0) {
            cell.contentView.backgroundColor=[UIColor whiteColor];
            
        }else
        {
            cell.contentView.backgroundColor=[UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0];
        }
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(YELSystemStateCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *sysStr=[[_dataSource objectAtIndex:indexPath.row]objectForKey:@"SYS"];
    NSString *dominStr=nil;
    if ([_areaString isEqualToString:@"总部"]) {
         dominStr=[[_dataSource objectAtIndex:indexPath.row]objectForKey:@"DOMAIN"];
    }else
    {
        dominStr=[[_dataSource objectAtIndex:indexPath.row]objectForKey:@"PROVINCE"];
    }

    int au=[[[_dataSource objectAtIndex:indexPath.row]objectForKey:@"AU"]intValue];
    int bu=[[[_dataSource objectAtIndex:indexPath.row]objectForKey:@"BU"]intValue];
    int pu=[[[_dataSource objectAtIndex:indexPath.row]objectForKey:@"PU"]intValue];
    NSInteger height=[YELSystemStateCell neededHeightForDescription:sysStr];
    if (height<44) {
        height=44;
    }
    cell.systemLabel.text=sysStr;
    cell.systemLabel.frame=CGRectMake(73, 0, 105, height);
    cell.dominLabel.text =dominStr;
    cell.dominLabel.frame=CGRectMake(0, 0, 72, height);
    cell.imageview.frame=CGRectMake(72-cell.imageview.image.size.width, cell.dominLabel.center.y-cell.imageview.image.size.height/2, cell.imageview.image.size.width, cell.imageview.image.size.height);
    cell.lineImageView1.frame=CGRectMake(0, height-1, 72, 1);
    cell.lineImageView2.frame=CGRectMake(178, 0, 1, height);
    cell.lineImageView3.frame=CGRectMake(225, 0, 1, height);
    cell.lineImageView4.frame=CGRectMake(272, 0, 1, height);
    
    cell.platformsImageView.image=[self getPic:pu];
    cell.platformsImageView.frame=CGRectMake(179+23-cell.platformsImageView.image.size.width/2, height/2-cell.platformsImageView.image.size.height/2, cell.platformsImageView.image.size.width, cell.platformsImageView.image.size.height);
    cell.applyImageView.image=[self getPic:au];
    cell.applyImageView.frame=CGRectMake(226+23-cell.applyImageView.image.size.width/2, height/2-cell.applyImageView.image.size.height/2, cell.applyImageView.image.size.width, cell.applyImageView.image.size.height);
    
    cell.businessImageView.image=[self getPic:bu];
    cell.businessImageView.frame=CGRectMake(273+23-cell.businessImageView.image.size.width/2, height/2-cell.businessImageView.image.size.height/2, cell.businessImageView.image.size.width, cell.businessImageView.image.size.height);
    cell.bottomLine.frame=CGRectMake(0, height-1, 320, 1);
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YELSystemRunDetailViewController *systemRunDetail=[[YELSystemRunDetailViewController alloc]initWithNibName:@"YELSystemRunDetailViewController" bundle:nil];
    systemRunDetail.dataSourceDictionary=[_dataSource objectAtIndex:indexPath.row];
    systemRunDetail.areaString=_areaString;
    [self.navigationController pushViewController:systemRunDetail animated:YES];
}

-(UIImage *)getPic :(int)pt
{
    switch (pt) {
        case -1:
            return LOADIMAGE(@"fuyi@2x", @"png");
        case 0:
            
            return LOADIMAGE(@"ling@2x", @"png");
        case 1:
            
            return LOADIMAGE(@"yi@2x", @"png");
        case 2:
            
            return LOADIMAGE(@"er@2x", @"png");
        case 3:
            
            return LOADIMAGE(@"san@2x", @"png");
        default:
            return LOADIMAGE(@"si@2x", @"png");
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload
{
    [self set_myTableView:nil];
    [self setStateButton:nil];
    [super viewDidUnload];
}

- (IBAction)pressAreaButton:(UIButton *)sender forEvent:(UIEvent *)event {
    if (!areaPopview) {
        NSArray *array=[NSArray arrayWithObjects:@"总部系统",@"省份系统", nil];
        areaPopview=[[YELPopView alloc]initWithFrame:CGRectMake(0, 0, 150, [array count]*30) array:array target:self];
    }
    popoverController=[[TSPopoverController alloc]initWithView:areaPopview];
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
        [self.stateButton setTitle:@"总部系统" forState:UIControlStateNormal];
        _areaString=@"总部";
    }else if (sender.tag==101)
    {
        [self.stateButton setTitle:@"省份系统" forState:UIControlStateNormal];
        _areaString=@"省分";
    }
    [self sendRequest];
    [popoverController dismissPopoverAnimatd:YES];
}
@end
