//
//  YELTopAnotherNumCell.m
//  Alarm
//
//  Created by rock on 13-7-26.
//  Copyright (c) 2013年 Ye Erliang. All rights reserved.
//

#import "YELTopAnotherNumCell.h"
#import "UIColor+String.h"
@implementation YELTopAnotherNumCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _topLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 63, 44)];
        [_topLabel setTextAlignment:NSTextAlignmentCenter];
        [_topLabel setFont:[UIFont systemFontOfSize:15.0]];
        [_topLabel setTextColor:[UIColor whiteColor]];
        [self.contentView addSubview:_topLabel];
        
        _sheLabel=[[UILabel alloc]initWithFrame:CGRectMake(64, 0, 63, 44)];
        [_sheLabel setTextAlignment:NSTextAlignmentCenter];
        [_sheLabel setFont:[UIFont systemFontOfSize:15.0]];
        [_sheLabel setNumberOfLines:0];
        [_sheLabel setLineBreakMode:NSLineBreakByCharWrapping];
        [_sheLabel setTextColor:[UIColor whiteColor]];
        [self.contentView addSubview:_sheLabel];
        
        _sysLabel=[[UILabel alloc]initWithFrame:CGRectMake(128, 0, 63, 44)];
        [_sysLabel setTextAlignment:NSTextAlignmentCenter];
        [_sysLabel setFont:[UIFont systemFontOfSize:15.0]];
        [_sysLabel setNumberOfLines:0];
        [_sysLabel setLineBreakMode:NSLineBreakByCharWrapping];
        [_sysLabel setTextColor:[UIColor whiteColor]];
        [self.contentView addSubview:_sysLabel];
        
        _jiLabel=[[UILabel alloc]initWithFrame:CGRectMake(192, 0, 63, 44)];
        [_jiLabel setTextAlignment:NSTextAlignmentCenter];
        [_jiLabel setFont:[UIFont systemFontOfSize:15.0]];
        [_jiLabel setNumberOfLines:0];
        [_jiLabel setLineBreakMode:NSLineBreakByCharWrapping];
        [_jiLabel setTextColor:[UIColor whiteColor]];
        [self.contentView addSubview:_jiLabel];
        
        _zongLabel=[[UILabel alloc]initWithFrame:CGRectMake(256, 0, 63, 44)];
        [_zongLabel setTextAlignment:NSTextAlignmentCenter];
        [_zongLabel setFont:[UIFont systemFontOfSize:15.0]];
        [_zongLabel setTextColor:[UIColor whiteColor]];
        [self.contentView addSubview:_zongLabel];
        
        UIImageView *sanjiaoImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"zuosanjiao.png"]];
        sanjiaoImageView.frame=CGRectMake(63-sanjiaoImageView.image.size.width, 22-sanjiaoImageView.image.size.height/2, sanjiaoImageView.image.size.width, sanjiaoImageView.image.size.height);
        [self.contentView addSubview:sanjiaoImageView];
        
        UIImageView *lineImageOne=[[UIImageView alloc]initWithFrame:CGRectMake(63, 0, 1, 44)];
        [lineImageOne setBackgroundColor:[UIColor colorWithHexString:@"#cfcfcf"]];
        [self.contentView addSubview:lineImageOne];
        
        UIImageView *lineImageTwo=[[UIImageView alloc]initWithFrame:CGRectMake(127, 0, 1, 44)];
        [lineImageTwo setBackgroundColor:[UIColor colorWithHexString:@"#cfcfcf"]];
        [self.contentView addSubview:lineImageTwo];
        
        UIImageView *lineImageThree=[[UIImageView alloc]initWithFrame:CGRectMake(191, 0, 1, 44)];
        [lineImageThree setBackgroundColor:[UIColor colorWithHexString:@"#cfcfcf"]];
        [self.contentView addSubview:lineImageThree];
        
        UIImageView *lineImageFour=[[UIImageView alloc]initWithFrame:CGRectMake(255, 0, 1, 44)];
        [lineImageFour setBackgroundColor:[UIColor colorWithHexString:@"#cfcfcf"]];
        [self.contentView addSubview:lineImageFour];
        
        UIImageView *bottomLine=[[UIImageView alloc]initWithFrame:CGRectMake(0, 43, 320, 1)];
        [bottomLine setBackgroundColor:[UIColor colorWithHexString:@"#cfcfcf"]];
        [self.contentView addSubview:bottomLine];
    }
    return self;
}
-(void)prepareForReuse
{
    [super prepareForReuse];
    _topLabel.text=nil;
    _sheLabel.text=nil;
    _sysLabel.text=nil;
    _jiLabel.text=nil;
    _zongLabel.text=nil;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
