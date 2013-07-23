//
//  YELSystemRunStateViewController.m
//  Alarm
//
//  Created by YY on 13-7-20.
//  Copyright (c) 2013年 Ye Erliang. All rights reserved.
//

#import "YELSystemRunStateViewController.h"
#import "YELSystemStateCell.h"
@interface YELSystemRunStateViewController ()
{
    NSArray *_dataSource;
}
@property (weak, nonatomic) IBOutlet UITableView *_myTableView;
- (IBAction)pressButton:(id)sender;

@end

@implementation YELSystemRunStateViewController
NSString *const HeadQuarters= @"总部";
NSString *const Province= @"省分";

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title=@"系统运行状态";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self sendRequest];
    // Do any additional setup after loading the view from its nib.
}
-(void)sendRequest
{
    NSDictionary *dict=[NSDictionary dictionaryWithObjectsAndKeys:HeadQuarters,@"domain",TOKEN,@"token", nil];
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
            [MBHUDView hudWithBody:@"网络不给力" type:MBAlertViewHUDTypeDefault hidesAfter:1.0 show:YES];
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
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
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
    NSString *dominStr=[[_dataSource objectAtIndex:indexPath.row]objectForKey:@"DOMAIN"];
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
    [super viewDidUnload];
}
- (IBAction)pressButton:(id)sender {
    UIButton *button=(UIButton *)sender;

}
@end
