//
//  YELDetailCell.m
//  Alarm
//
//  Created by YY on 13-7-24.
//  Copyright (c) 2013年 Ye Erliang. All rights reserved.
//

#import "YELDetailCell.h"
#import <QuartzCore/QuartzCore.h>
@implementation YELDetailCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        _timeTitleLabel=[[UILabel alloc]init];
       
        [_timeTitleLabel setBackgroundColor:[UIColor clearColor]];
        [_timeTitleLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [self.contentView addSubview:_timeTitleLabel];
        
        _timeContentLabel=[[UILabel alloc]init];
        [_timeContentLabel setBackgroundColor:[UIColor clearColor]];
        [_timeContentLabel setFont:[UIFont systemFontOfSize:15.0]];
        [_timeContentLabel setTextColor:[UIColor blueColor]];
        [self.contentView addSubview:_timeContentLabel];
        
        _areaTitleLabel=[[UILabel alloc]init];
        [_areaTitleLabel setBackgroundColor:[UIColor clearColor]];
        [_areaTitleLabel setFont:[UIFont systemFontOfSize:15.0f]];
       
        [self.contentView addSubview:_areaTitleLabel];
        
        _areaContentLabel=[[UILabel alloc]init];
        [_areaContentLabel setBackgroundColor:[UIColor clearColor]];
        [_areaContentLabel setFont:[UIFont systemFontOfSize:15.0]];
        [_areaContentLabel setTextColor:[UIColor redColor]];
        [self.contentView addSubview:_areaContentLabel];
        
        _dominTitleLabel=[[UILabel alloc]init];
        [_dominTitleLabel setBackgroundColor:[UIColor clearColor]];
        [_dominTitleLabel setFont:[UIFont systemFontOfSize:15.0f]];
        
        [self.contentView addSubview:_dominTitleLabel];
        
        _dominContentLabel=[[UILabel alloc]init];
        [_dominContentLabel setBackgroundColor:[UIColor clearColor]];
        [_dominContentLabel setFont:[UIFont systemFontOfSize:15.0]];
        [_dominContentLabel setNumberOfLines:0];
        [_dominContentLabel setLineBreakMode:NSLineBreakByCharWrapping];
        [_dominContentLabel setTextColor:[UIColor redColor]];
        [self.contentView addSubview:_dominContentLabel];
        
        _detailTitleLabel=[[UILabel alloc]init];
        [_detailTitleLabel setBackgroundColor:[UIColor clearColor]];
        [_detailTitleLabel setFont:[UIFont systemFontOfSize:15.0f]];
       
        [self.contentView addSubview:_detailTitleLabel];
        
        _detailContentLabel=[[UILabel alloc]init];
        [_detailContentLabel setBackgroundColor:[UIColor clearColor]];
        [_detailContentLabel setFont:[UIFont systemFontOfSize:15.0]];
        [_detailContentLabel setNumberOfLines:0];
        [_detailContentLabel setLineBreakMode:NSLineBreakByCharWrapping];
        [_detailContentLabel setTextColor:[UIColor lightGrayColor]];
        [self.contentView addSubview:_detailContentLabel];
        
        _rangTitleLabel=[[UILabel alloc]init];
        [_rangTitleLabel setBackgroundColor:[UIColor clearColor]];
        [_rangTitleLabel setFont:[UIFont systemFontOfSize:15.0f]];
        
        [self.contentView addSubview:_rangTitleLabel];
        
        _rangContentLabel=[[UILabel alloc]init];
        [_rangContentLabel setBackgroundColor:[UIColor clearColor]];
        [_rangContentLabel setFont:[UIFont systemFontOfSize:15.0]];
        [_rangContentLabel setTextColor:[UIColor lightGrayColor]];
        [self.contentView addSubview:_rangContentLabel];
        
        _levelTitleLabel=[[UILabel alloc]init];
        [_levelTitleLabel setBackgroundColor:[UIColor clearColor]];
        [_levelTitleLabel setFont:[UIFont systemFontOfSize:15.0f]];
        
        [self.contentView addSubview:_levelTitleLabel];
        
        _levelContentLabel=[[UILabel alloc]init];
        [_levelContentLabel setBackgroundColor:[UIColor clearColor]];
        [_levelContentLabel setFont:[UIFont systemFontOfSize:15.0]];
        [_levelContentLabel setTextColor:[UIColor redColor]];
        [self.contentView addSubview:_levelContentLabel];
        
        _sysTitleLabel=[[UILabel alloc]init];
        [_sysTitleLabel setBackgroundColor:[UIColor clearColor]];
        [_sysTitleLabel setFont:[UIFont systemFontOfSize:15.0f]];
       
        [self.contentView addSubview:_sysTitleLabel];
        
        _sysContentLabel=[[UILabel alloc]init];
        [_sysContentLabel setBackgroundColor:[UIColor clearColor]];
        [_sysContentLabel setFont:[UIFont systemFontOfSize:15.0]];
        [_sysContentLabel setTextColor:[UIColor lightGrayColor]];
        [_sysContentLabel setNumberOfLines:0];
        [_sysContentLabel setLineBreakMode:NSLineBreakByCharWrapping];
        [self.contentView addSubview:_sysContentLabel];
        
        _personTitleLabel=[[UILabel alloc]init];
        [_personTitleLabel setBackgroundColor:[UIColor clearColor]];
        [_personTitleLabel setFont:[UIFont systemFontOfSize:15.0f]];
        
        [self.contentView addSubview:_personTitleLabel];
        
        _personContentLabel=[[UILabel alloc]init];
        [_personContentLabel setBackgroundColor:[UIColor clearColor]];
        [_personContentLabel setFont:[UIFont systemFontOfSize:15.0]];
        [_personContentLabel setTextColor:[UIColor greenColor]];
        [self.contentView addSubview:_personContentLabel];
        
        _doButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_doButton.layer setCornerRadius:5.0];
        [_doButton setBackgroundColor:[UIColor darkGrayColor]];
        [_doButton.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
        
        [_doButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.contentView addSubview:_doButton];
        
        _sureButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_sureButton.layer setCornerRadius:5.0];
        [_sureButton setBackgroundColor:[UIColor darkGrayColor]];
        [_sureButton.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
        
        [_sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.contentView addSubview:_sureButton];
    }
    return self;
}
-(void)prepareForReuse
{
    [super prepareForReuse];
    _timeContentLabel.text=nil;
    _areaContentLabel.text=nil;
    _dominContentLabel.text=nil;
    _detailContentLabel.text=nil;
    _rangContentLabel.text=nil;
    _levelContentLabel.text=nil;
    _sysContentLabel.text=nil;
    _personContentLabel.text=nil;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(NSUInteger)neededHeightForCell:(NSString *)description sysStr:(NSString *)sysStr
{
    CGSize size=[description sizeWithFont:[UIFont systemFontOfSize:15.0] constrainedToSize:CGSizeMake(215, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
    CGSize sysSize=[sysStr sizeWithFont:[UIFont systemFontOfSize:15.0] constrainedToSize:CGSizeMake(215, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
    return 5*2+6*20+7*2+size.height +5+30+sysSize.height;
}
+ (NSUInteger)neededHeightForDescription:(NSString *)description
{
    CGSize size=[description sizeWithFont:[UIFont systemFontOfSize:15.0] constrainedToSize:CGSizeMake(215, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
    return size.height;
}
@end
