//
//  YELDoTableView.h
//  Alarm
//
//  Created by rock on 13-7-25.
//  Copyright (c) 2013年 Ye Erliang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YELDoTableView : UIView<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)NSArray *dataSource;
- (id)initWithFrame:(CGRect)frame array:(NSArray *)array;
@end
