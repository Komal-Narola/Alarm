//
//  YELDoTableView.m
//  Alarm
//
//  Created by rock on 13-7-25.
//  Copyright (c) 2013年 Ye Erliang. All rights reserved.
//

#import "YELDoTableView.h"

@implementation YELDoTableView

- (id)initWithFrame:(CGRect)frame array:(NSArray *)array
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
        self.dataSource=[NSArray arrayWithArray:array];
        UITableView *tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height) style:UITableViewStylePlain];
        tableview.delegate=self;
        tableview.dataSource=self;
        [tableview setBackgroundView:nil];
        [self addSubview:tableview];
    }
    return self;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellWithIdentifier = @"DoTableViewCell";
    UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    if (cell == nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellWithIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    cell.textLabel.text=[[self.dataSource objectAtIndex:indexPath.row]objectForKey:@"NAME"];
    cell.detailTextLabel.text=[[self.dataSource objectAtIndex:indexPath.row]objectForKey:@"PHONE"];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *phoneNum=[[self.dataSource objectAtIndex:indexPath.row]objectForKey:@"PHONE"];
    NSString *phone=[NSString stringWithFormat:@"telprompt://%@",phoneNum];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phone]];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
