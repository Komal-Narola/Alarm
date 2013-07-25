//
//  YELDetailCell.h
//  Alarm
//
//  Created by YY on 13-7-24.
//  Copyright (c) 2013年 Ye Erliang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YELDetailCell : UITableViewCell
@property (nonatomic,strong)UILabel *timeTitleLabel;
@property (nonatomic,strong)UILabel *areaTitleLabel;
@property (nonatomic,strong)UILabel *dominTitleLabel;
@property (nonatomic,strong)UILabel *detailTitleLabel;
@property (nonatomic,strong)UILabel *rangTitleLabel;
@property (nonatomic,strong)UILabel *levelTitleLabel;
@property (nonatomic,strong)UILabel *sysTitleLabel;
@property (nonatomic,strong)UILabel *personTitleLabel;
@property (nonatomic,strong)UILabel *timeContentLabel;
@property (nonatomic,strong)UILabel *areaContentLabel;
@property (nonatomic,strong)UILabel *dominContentLabel;
@property (nonatomic,strong)UILabel *detailContentLabel;
@property (nonatomic,strong)UILabel *rangContentLabel;
@property (nonatomic,strong)UILabel *levelContentLabel;
@property (nonatomic,strong)UILabel *sysContentLabel;
@property (nonatomic,strong)UILabel *personContentLabel;
@property (nonatomic,strong)UIButton *doButton;
@property (nonatomic,strong)UIButton *sureButton;
+(NSUInteger)neededHeightForCell:(NSString *)description sysStr:(NSString *)sysStr;
+ (NSUInteger)neededHeightForDescription:(NSString *)description;
@end
