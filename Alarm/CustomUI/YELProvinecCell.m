//
//  YELProvinecCell.m
//  Alarm
//
//  Created by YY on 13-7-23.
//  Copyright (c) 2013年 Ye Erliang. All rights reserved.
//

#import "YELProvinecCell.h"
#import "UIColor+String.h"
#define CELLHEIGHT 44
#define LABELWIDTH 79
@implementation YELProvinecCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _provinecLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, LABELWIDTH, CELLHEIGHT)];
        [_provinecLabel setTextAlignment:NSTextAlignmentCenter];
        [_provinecLabel setTextColor:[UIColor whiteColor]];
        [_provinecLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [_provinecLabel setAdjustsFontSizeToFitWidth:YES];
        [self.contentView addSubview:_provinecLabel];
        
        _monthLabel=[[UILabel alloc]initWithFrame:CGRectMake(81, 0, LABELWIDTH, CELLHEIGHT)];
        [_monthLabel setTextAlignment:NSTextAlignmentCenter];
        [_monthLabel setTextColor:[UIColor blackColor]];
        [_monthLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [_monthLabel setAdjustsFontSizeToFitWidth:YES];
        [self.contentView addSubview:_monthLabel];
        
        _preMonthLabel=[[UILabel alloc]initWithFrame:CGRectMake(161, 0, LABELWIDTH, CELLHEIGHT)];
        [_preMonthLabel setTextAlignment:NSTextAlignmentCenter];
        [_preMonthLabel setTextColor:[UIColor blackColor]];
        [_preMonthLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [_preMonthLabel setAdjustsFontSizeToFitWidth:YES];
        [self.contentView addSubview:_preMonthLabel];
        
        _biLabel=[[UILabel alloc]initWithFrame:CGRectMake(241, 0, LABELWIDTH, CELLHEIGHT)];
        [_biLabel setTextAlignment:NSTextAlignmentCenter];
        [_biLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [_biLabel setAdjustsFontSizeToFitWidth:YES];
        [self.contentView addSubview:_biLabel];
        
        UIImageView *sanjiaoImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"zuosanjiao.png"]];
        sanjiaoImageView.frame=CGRectMake(79-sanjiaoImageView.image.size.width, 22-sanjiaoImageView.image.size.height/2, sanjiaoImageView.image.size.width, sanjiaoImageView.image.size.height);
        [self.contentView addSubview:sanjiaoImageView];
        
        UIImageView *lineImageOne=[[UIImageView alloc]initWithFrame:CGRectMake(80, 0, 1, CELLHEIGHT)];
        [lineImageOne setBackgroundColor:[UIColor colorWithHexString:@"#cfcfcf"]];
        [self.contentView addSubview:lineImageOne];
        
        UIImageView *lineImageTwo=[[UIImageView alloc]initWithFrame:CGRectMake(160, 0, 1, CELLHEIGHT)];
        [lineImageTwo setBackgroundColor:[UIColor colorWithHexString:@"#cfcfcf"]];
        [self.contentView addSubview:lineImageTwo];
        
        UIImageView *lineImageThree=[[UIImageView alloc]initWithFrame:CGRectMake(240, 0, 1, CELLHEIGHT)];
        [lineImageThree setBackgroundColor:[UIColor colorWithHexString:@"#cfcfcf"]];
        [self.contentView addSubview:lineImageThree];
    }
    return self;
}
-(void)prepareForReuse
{
    [super prepareForReuse];
    self.provinecLabel.text=nil;
    self.monthLabel.text=nil;
    self.provinecLabel.text=nil;
    self.biLabel.text=nil;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
