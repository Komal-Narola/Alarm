//
//  YELSystemStateCell.m
//  Alarm
//
//  Created by rock on 13-7-23.
//  Copyright (c) 2013年 Ye Erliang. All rights reserved.
//

#import "YELSystemStateCell.h"
#import "UIColor+String.h"
@implementation YELSystemStateCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _dominLabel=[[UILabel alloc]init];
        [_dominLabel setBackgroundColor:[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0]];
        [_dominLabel setTextColor:[UIColor whiteColor]];
        [_dominLabel setAdjustsFontSizeToFitWidth:YES];
        [_dominLabel setTextAlignment:NSTextAlignmentCenter];
        [_dominLabel setFont:[UIFont systemFontOfSize:15.0]];
        [_dominLabel setNumberOfLines:0];
        [_dominLabel setLineBreakMode:NSLineBreakByCharWrapping];
        [self.contentView addSubview:_dominLabel];
    
        _lineImageView1=[[UIImageView alloc]init];
        [_lineImageView1 setBackgroundColor:[UIColor lightGrayColor]];
        [self.contentView addSubview:_lineImageView1];
        _lineImageView2=[[UIImageView alloc]init];
        [_lineImageView2 setBackgroundColor:[UIColor colorWithHexString:@"#cfcfcf"]];
        [self.contentView addSubview:_lineImageView2];
        _lineImageView3=[[UIImageView alloc]init];
        [_lineImageView3 setBackgroundColor:[UIColor colorWithHexString:@"#cfcfcf"]];
        [self.contentView addSubview:_lineImageView3];
        _lineImageView4=[[UIImageView alloc]init];
        [_lineImageView4 setBackgroundColor:[UIColor colorWithHexString:@"#cfcfcf"]];
        [self.contentView addSubview:_lineImageView4];
        
         _imageview=[[UIImageView alloc]initWithImage:LOADIMAGE(@"zuosanjiao@2x", @"png")];
        [_dominLabel addSubview:_imageview];
        
        _systemLabel=[[UILabel alloc]init];
        [_systemLabel setTextColor:[UIColor blackColor]];
        [_systemLabel setBackgroundColor:[UIColor clearColor]];
        [_systemLabel setTextAlignment:NSTextAlignmentCenter];
        [_systemLabel setNumberOfLines:0];
        [_systemLabel setLineBreakMode:NSLineBreakByCharWrapping];
        [_systemLabel setFont:[UIFont systemFontOfSize:15.0]];
        [self.contentView addSubview:_systemLabel];
        
        _platformsImageView =[[UIImageView alloc]init];
        [self.contentView addSubview:_platformsImageView];
        
        _applyImageView =[[UIImageView alloc]init];
        [self.contentView addSubview:_applyImageView];
        
        _businessImageView =[[UIImageView alloc]init];
        [self.contentView addSubview:_businessImageView];
        
    }
    return self;
}
-(void)prepareForReuse
{
    [super prepareForReuse];
    _businessImageView.image=nil;
    _applyImageView.image=nil;
    _platformsImageView.image=nil;
    _dominLabel.text=nil;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}
+ (NSUInteger)neededHeightForDescription:(NSString *)description
{
    CGSize size=[description sizeWithFont:[UIFont systemFontOfSize:17.0] constrainedToSize:CGSizeMake(125, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
    return size.height;
}
@end
