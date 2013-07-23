//
//  YELSystemStateCell.h
//  Alarm
//
//  Created by rock on 13-7-23.
//  Copyright (c) 2013年 Ye Erliang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YELSystemStateCell : UITableViewCell
@property (nonatomic,strong)UILabel *dominLabel;
@property (nonatomic,strong)UILabel *systemLabel;
@property (nonatomic,strong)UIImageView *platformsImageView;
@property (nonatomic,strong)UIImageView *applyImageView;
@property (nonatomic,strong)UIImageView *businessImageView;
@property (nonatomic,strong)UIImageView *imageview;
@property (nonatomic,strong)UIImageView *lineImageView1;
@property (nonatomic,strong)UIImageView *lineImageView2;
@property (nonatomic,strong)UIImageView *lineImageView3;
@property (nonatomic,strong)UIImageView *lineImageView4;
@property (nonatomic,strong)UIImageView *bottomLine;
+ (NSUInteger)neededHeightForDescription:(NSString *)descriptio;
@end
