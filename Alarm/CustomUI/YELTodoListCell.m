//
//  YELTodoListCell.m
//  Alarm
//
//  Created by YY on 13-7-20.
//  Copyright (c) 2013年 Ye Erliang. All rights reserved.
//

#import "YELTodoListCell.h"

@implementation YELTodoListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _timeLabel = [[ UILabel alloc]initWithFrame:CGRectZero];
        _timeLabel.text=@"aaaaa";
        [_timeLabel setBackgroundColor:[UIColor yellowColor]];
        [self.contentView addSubview:_timeLabel];
        
        _nameLabel=[[UILabel alloc]initWithFrame:CGRectZero];
        [_timeLabel setBackgroundColor:[UIColor redColor]];
        _nameLabel.text=@"dddd";
        [self.contentView addSubview:_nameLabel];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    _timeLabel.frame=CGRectMake(0, 0, 100, 20);
    _nameLabel.frame=CGRectMake(20, 20, 100, 20);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (NSUInteger)neededHeightForDescription:(NSString *)description withTableWidth:(NSUInteger)tableWidth
{
	int tablePadding = 40;
	int offset = 0;
	int textSize = 13;
	if (tableWidth > 480) { // iPad
		tablePadding = 110;
		offset = 70;
		textSize = 14;
	}
	CGSize labelSize = [description sizeWithFont:[UIFont systemFontOfSize:textSize] constrainedToSize:CGSizeMake(tableWidth-tablePadding-offset,1000) lineBreakMode:UILineBreakModeWordWrap];
	if (labelSize.height < 48) {
		return 58;
	}
	return labelSize.height;
}
@end
