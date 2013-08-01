//
//  YELNoticeViewController.m
//  Alarm
//
//  Created by rock on 13-8-1.
//  Copyright (c) 2013年 Ye Erliang. All rights reserved.
//

#import "YELNoticeViewController.h"
#import "YELTodoListCell.h"

@interface YELNoticeViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *myTableView;
    NSArray *dataSource;
}

@end

@implementation YELNoticeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.navigationItem.title=@"通知";
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    myTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, [UIScreen mainScreen].applicationFrame.size.height-49-44) ];
    myTableView.delegate=self;
    myTableView.dataSource=self;
    [myTableView setBackgroundColor:[UIColor clearColor]];
    [myTableView setBackgroundView:nil];
    [myTableView setSeparatorColor:[UIColor clearColor]];
    [myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:myTableView];
    [self sendRequest];
    // Do any additional setup after loading the view from its nib.
}
-(void)sendRequest
{
    NSDictionary *dict=[NSDictionary dictionaryWithObjectsAndKeys:
                        TOKEN,@"token",
                        nil];
    [[YELHttpHelper defaultHelper]getNoticeWithParamter:dict sucess:^(NSDictionary *dictionary) {
        int code=[[dictionary objectForKey:@"code"] intValue];
        if (code==0) {
            NSArray *array=[dictionary objectForKey:@"data"];
            dataSource=[NSArray arrayWithArray:array];
            [myTableView reloadData];
        }
        else
        {
            [MBHUDView hudWithBody:[dictionary objectForKey:@"msg"] type:MBAlertViewHUDTypeDefault hidesAfter:1.0 show:YES];
        }
    } falid:^(NSString *errorMsg) {
            [MBHUDView hudWithBody:@"网络链接超时" type:MBAlertViewHUDTypeDefault hidesAfter:1.0 show:YES];
    }];

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *titleStr=[[dataSource objectAtIndex:indexPath.row]objectForKey:@"NOTIFICATION"];
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
    NSString *titleStr=[[dataSource objectAtIndex:indexPath.row]objectForKey:@"NOTIFICATION"];
    NSString *nameStr=[[dataSource objectAtIndex:indexPath.row]objectForKey:@"USERNAME"];
    NSString *timeStr=[[dataSource objectAtIndex:indexPath.row]objectForKey:@"DATECREATED"];
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
    
    NSMutableAttributedString *timeAttriString=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"派发时间:%@",timeStr]];
        
    [timeAttriString addAttribute:NSForegroundColorAttributeName
                                value:[UIColor lightGrayColor]
                                range:NSMakeRange(5, [timeStr length])];
    cell.timeLabel.attributedText=timeAttriString;
    UIImage *image=LOADIMAGE(@"jinggao0@2x", @"png");
    cell.timeImageView.image=image;
    cell.timeImageView.frame=CGRectMake(9, cellHeight/2-image.size.height/2, image.size.width, image.size.height);
    cell.leftTimeLabel.hidden=YES;
    cell.backImageView.frame=CGRectMake(5, 2, 310, cellHeight-4);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
