//
//  YELUtil.m
//  Alarm
//
//  Created by YY on 13-7-20.
//  Copyright (c) 2013年 Ye Erliang. All rights reserved.
//

#import "YELUtil.h"

@implementation YELUtil
+(float)orginfromView:(UIView *)view
{
    float orgin=view.frame.origin.y;
    float height=view.frame.size.height;
    return orgin+height;
}
@end
