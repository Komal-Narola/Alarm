//
//  YELSysConfig.h
//  Alarm
//
//  Created by rock on 13-7-18.
//  Copyright (c) 2013年 Ye Erliang. All rights reserved.
//


#ifndef YELSysConfig_h
#define YELSysConfig_h

//DEBUG  模式下打印日志,当前行
#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif
//NSUserDefaults 实例化
#define USER_DEFAULT [NSUserDefaults standardUserDefaults]
#define PLATFORM @"1"
#define ACCOUNT @"account"
#define PWD @"passWord"
#define TOKEN [USER_DEFAULT objectForKey:@"token"]
#define DEVICETOKEN [USER_DEFAULT objectForKey:@"deviceToken"]
#define PAGESIZE @"10"

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define max( a, b ) ( a > b ? a : b )
//wangjc
//123456
//读取本地图片
#define LOADIMAGE(file,png) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:png]]

//定义UIImage对象
#define IMAGE(A) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:A ofType:nil]]

//定义一个API
//测试接口
//#define APIURL                @"http://202.99.45.117:20880/minf/api/"
//正式接口
#define APIURL                @"http://202.99.45.117:20881/minf/api/"
//图片下载地址
//正式接口
#define IMAGEURL                @"http://202.99.45.117:20881/minf/"
//测试接口
//#define IMAGEURL              @"http://202.99.45.117:20880/minf/"
//登陆API
#define APILogin                [APIURL stringByAppendingString:@"user/login.json"]
//修改密码API
#define APIChangePwd            [APIURL stringByAppendingString:@"user/modifyPwd.json"]
//获取图片API
#define APIGetImage             [APIURL stringByAppendingString:@"image/getImages.json"]
//获取系统运行状态API
#define APIGetgetSystemState    [APIURL stringByAppendingString:@"systemstate/getSystemState.json"]
//获取省份
#define APIGetgetAllProvinces   [APIURL stringByAppendingString:@"allprovinces/allprovince.json"]
//获取告警列表API
#define APIGetWaring            [APIURL stringByAppendingString:@"warning/getWarning.json"]
//获取我的告警列表API
#define APIGetMyWaring          [APIURL stringByAppendingString:@"eventDisposeController/getEventList.json"]
//获取催办列表API
#define APIGetWaringUser        [APIURL stringByAppendingString:@"warning/getWarningUsers.json"]
//获取待办事项API
#define APIGetOrderList         [APIURL stringByAppendingString:@"waitOrder/getOrderList.json"]
//获取当月集团频发告警的系统前十名
#define APIGetTopPin            [APIURL stringByAppendingString:@"warningtopten/getCentralSystemWarning.json"]
//本月集团频发告警设备top10
#define APIGetTopShe            [APIURL stringByAppendingString:@"warningtopten/getCentralEquipmentWarning.json"]
//本月集团频发告警类别top10
#define APIGetTopLei            [APIURL stringByAppendingString:@"warningtopten/getCentralCategoryWarning.json"]
//本月集团频发告警机房top10
#define APIGetTopJi             [APIURL stringByAppendingString:@"warningtopten/getCentralRoomWarning.json"]
//本月省分频发告警类别top10
#define APIGetTopSheng          [APIURL stringByAppendingString:@"warningtopten/getProvinceCategoryWarning.json"]
//趋势图API
#define APIGetTrend             [APIURL stringByAppendingString:@"trend/getTrend.json"]
//TOKEN API
#define APIPostToken            [APIURL stringByAppendingString:@"notification/addDeviceToken.json"]
//deviceToken
//参数
//通知接口 API
#define APIPostToken            [APIURL stringByAppendingString:@"notification/getHistoryNotification.json?"]
//参数token
#endif