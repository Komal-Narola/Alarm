//
//  YELAlarmListCell.m
//  Alarm
//
//  Created by rock on 13-7-24.
//  Copyright (c) 2013年 Ye Erliang. All rights reserved.
//

#import "YELAlarmListCell.h"
#define TITLESIZE_TOP 5
#define NAME_TOP 2
#define NAMESIZE 20
#define TIME_TOP 2
#define TIME 20
#define TIMEBOTTOM 5
#define CELL 2
#define SYS_TOP 2
@implementation YELAlarmListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImage *image=[UIImage imageNamed:@"16.png"];
        _backImageView=[[UIImageView alloc]initWithImage:[image stretchableImageWithLeftCapWidth:60 topCapHeight:10]];
        [self.contentView addSubview:_backImageView];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        [_titleLabel setBackgroundColor:[UIColor clearColor]];
        [_titleLabel setLineBreakMode:NSLineBreakByCharWrapping];
        [_titleLabel setFont:[UIFont systemFontOfSize:17.0f]];
        [_titleLabel setTextColor:[UIColor redColor]];
        [_titleLabel setNumberOfLines:0];
        [self.contentView addSubview:_titleLabel];
        
        _nameLabel=[[UILabel alloc]initWithFrame:CGRectZero];
        [_nameLabel setBackgroundColor:[UIColor clearColor]];
        [_nameLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [self.contentView addSubview:_nameLabel];
        
        _sysLabel=[[UILabel alloc]initWithFrame:CGRectZero];
        [_sysLabel setBackgroundColor:[UIColor clearColor]];
        [_sysLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [_sysLabel setLineBreakMode:NSLineBreakByCharWrapping];
        [_sysLabel setNumberOfLines:0];
        [self.contentView addSubview:_sysLabel];
        
        _timeLabel = [[ UILabel alloc]initWithFrame:CGRectZero];
        [_timeLabel setBackgroundColor:[UIColor clearColor]];
        [_timeLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [self.contentView addSubview:_timeLabel];
        
        _timeImageView=[[UIImageView alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:_timeImageView];
    }
    return self;
}
-(void)prepareForReuse
{
    [super prepareForReuse];
    _timeLabel.text=nil;
    _nameLabel.text=nil;
    _titleLabel.text=nil;
    _sysLabel.text=nil;
    _timeImageView.image=nil;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}
+(NSUInteger)neededHeightForCell:(NSString *)description sysHeight:(NSString *)systext
{
    CGSize size=[description sizeWithFont:[UIFont systemFontOfSize:17.0] constrainedToSize:CGSizeMake(225, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
    CGSize sysSize=[systext sizeWithFont:[UIFont systemFontOfSize:15.0] constrainedToSize:CGSizeMake(225, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
    return TITLESIZE_TOP+size.height+NAME_TOP+NAMESIZE+SYS_TOP+sysSize.height+TIME_TOP+TIME+TIMEBOTTOM+CELL+CELL;
}
+ (NSUInteger)neededHeightForDescription:(NSString *)description font:(UIFont *)font
{
    CGSize size=[description sizeWithFont:font constrainedToSize:CGSizeMake(225, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
    return size.height;
}

@end
