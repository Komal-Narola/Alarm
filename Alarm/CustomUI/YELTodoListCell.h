//
//  YELTodoListCell.h
//  Alarm
//
//  Created by YY on 13-7-20.
//  Copyright (c) 2013年 Ye Erliang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YELTodoListCell : UITableViewCell
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *timeLabel;
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UIImageView *timeImageView;
@property (nonatomic,strong)UILabel *leftTimeLabel;
@property (nonatomic,strong)UIImageView *backImageView;
+(NSUInteger)neededHeightForDescription:(NSString *)description;
+(NSUInteger)neededHeightForCell:(NSString *)description;
@end
