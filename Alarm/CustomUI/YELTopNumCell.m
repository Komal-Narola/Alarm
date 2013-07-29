//
//  YELTopNumCell.m
//  Alarm
//
//  Created by rock on 13-7-26.
//  Copyright (c) 2013年 Ye Erliang. All rights reserved.
//

#import "YELTopNumCell.h"
#import "UIColor+String.h"
@implementation YELTopNumCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _topLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 70, 44)];
        [_topLabel setTextAlignment:NSTextAlignmentCenter];
        [_topLabel setFont:[UIFont systemFontOfSize:15.0]];
        [_topLabel setTextColor:[UIColor whiteColor]];
        [self.contentView addSubview:_topLabel];
        
        _contentLabel=[[UILabel alloc]initWithFrame:CGRectMake(71, 0, 178, 44)];
        [_contentLabel setTextAlignment:NSTextAlignmentCenter];
        [_contentLabel setFont:[UIFont systemFontOfSize:15.0]];
        [_contentLabel setNumberOfLines:0];
        [_contentLabel setLineBreakMode:NSLineBreakByCharWrapping];
        [_contentLabel setAdjustsFontSizeToFitWidth:YES];
        [self.contentView addSubview:_contentLabel];
        
        _numLabel=[[UILabel alloc]initWithFrame:CGRectMake(250, 0, 70, 44)];
        [_numLabel setTextAlignment:NSTextAlignmentCenter];
        [_numLabel setFont:[UIFont systemFontOfSize:15.0]];
        [_numLabel setTextColor:[UIColor redColor]];
        [self.contentView addSubview:_numLabel];
        
        UIImageView *sanjiaoImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"zuosanjiao.png"]];
        sanjiaoImageView.frame=CGRectMake(70-sanjiaoImageView.image.size.width, 22-sanjiaoImageView.image.size.height/2, sanjiaoImageView.image.size.width, sanjiaoImageView.image.size.height);
        [self.contentView addSubview:sanjiaoImageView];
        
        UIImageView *lineImageOne=[[UIImageView alloc]initWithFrame:CGRectMake(70, 0, 1, 44)];
        [lineImageOne setBackgroundColor:[UIColor colorWithHexString:@"#cfcfcf"]];
        [self.contentView addSubview:lineImageOne];
        
        UIImageView *lineImageTwo=[[UIImageView alloc]initWithFrame:CGRectMake(249, 0, 1, 44)];
        [lineImageTwo setBackgroundColor:[UIColor colorWithHexString:@"#cfcfcf"]];
        [self.contentView addSubview:lineImageTwo];
        
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
    _contentLabel.text=nil;
    _numLabel.text=nil;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
