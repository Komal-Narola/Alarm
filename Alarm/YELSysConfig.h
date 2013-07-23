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
#define PAGESIZE @"10"

//wangjc
//123456
//读取本地图片
#define LOADIMAGE(file,png) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:png]]

//定义UIImage对象
#define IMAGE(A) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:A ofType:nil]]

//定义一个API
#define APIURL                @"http://202.99.45.117:20881/minf/api/"
//图片下载地址
#define IMAGEURL                @"http://202.99.45.117:20881/minf/"
//登陆API
#define APILogin              [APIURL stringByAppendingString:@"user/login.json"]
//修改密码API
#define APIChangePwd              [APIURL stringByAppendingString:@"user/modifyPwd.json"]
//获取图片API
#define APIGetImage              [APIURL stringByAppendingString:@"image/getImages.json"]
//获取系统运行状态API
#define APIGetgetSystemState              [APIURL stringByAppendingString:@"systemstate/getSystemState.json"]
//获取待办事项API
#define APIGetOrderList              [APIURL stringByAppendingString:@"waitOrder/getOrderList.json"]
#endif