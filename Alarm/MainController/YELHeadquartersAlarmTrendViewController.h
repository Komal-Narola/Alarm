//
//  YELHeadquartersAlarmTrendViewController.h
//  Alarm
//
//  Created by YY on 13-7-20.
//  Copyright (c) 2013年 Ye Erliang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"
@interface YELHeadquartersAlarmTrendViewController : UIViewController<CPTPlotDataSource>
{
    CPTXYGraph   *graph;             //画板
}
@end
