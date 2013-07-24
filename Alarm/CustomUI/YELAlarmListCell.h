//
//  YELAlarmListCell.h
//  Alarm
//
//  Created by rock on 13-7-24.
//  Copyright (c) 2013年 Ye Erliang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YELAlarmListCell : UITableViewCell
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *sysLabel;
@property (nonatomic,strong)UILabel *timeLabel;
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UIImageView *timeImageView;
@property (nonatomic,strong)UIImageView *backImageView;
+(NSUInteger)neededHeightForCell:(NSString *)description sysHeight:(NSString *)systext;
+ (NSUInteger)neededHeightForDescription:(NSString *)description font:(UIFont *)font;
@end
