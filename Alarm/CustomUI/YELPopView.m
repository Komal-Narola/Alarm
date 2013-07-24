//
//  YELPopView.m
//  Alarm
//
//  Created by YY on 13-7-23.
//  Copyright (c) 2013年 Ye Erliang. All rights reserved.
//

#import "YELPopView.h"

@implementation YELPopView

- (id)initWithFrame:(CGRect)frame array:(NSArray *)array target:(UIViewController*)target
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        for (int i=0; i<[array count]; i++) {
            UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
            [button setBackgroundColor:[UIColor clearColor]];
            [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
            [button setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"gou.png"] forState:UIControlStateSelected];
            [button setImage:[UIImage imageNamed:@"80.png"] forState:UIControlStateNormal];
            if (self.frame.size.width>100) {
                [button setImageEdgeInsets:UIEdgeInsetsMake(0, 130, 0, 0)];
            }else
            {
                [button setImageEdgeInsets:UIEdgeInsetsMake(0, 70, 0, 0)];
            }
            button.tag=i+100;
            [button addTarget:target action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
            button.frame=CGRectMake(0, i*30, self.bounds.size.width, 30);
            [self addSubview:button];
            if (i==0) {
                [button setSelected:YES];
            }
        }
        for (int y=0; y<[array count]-1; y++) {
            UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, (y+1)*(30), self.bounds.size.width, 1)];
            [imageview setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"xuxian.png"]]];
            [self addSubview:imageview];
        }
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
