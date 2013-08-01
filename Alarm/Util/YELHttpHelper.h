//
//  YELHttpHelper.h
//  Alarm
//
//  Created by rock on 13-7-18.
//  Copyright (c) 2013年 Ye Erliang. All rights reserved.
//
#import "HttpRequestHelper.h"
@interface YELHttpHelper : NSObject

+(YELHttpHelper *)defaultHelper;
- (void)loginWithParamter:(NSDictionary *)dictionary sucess:(void (^) (NSDictionary *dictionary))sucess falid:(void (^) (NSString *errorMsg))faild;
//修改密码
- (void)changePwdWithParamter:(NSDictionary *)dictionary sucess:(void (^) (NSDictionary *dictionary))sucess falid:(void (^) (NSString *errorMsg))faild;
//下载首页图片
- (void)getImageWithParamter:(NSDictionary *)dictionary sucess:(void (^) (NSDictionary *dictionary))sucess falid:(void (^) (NSString *errorMsg))faild;
//系统运行状态
- (void)getSystemStateWithParamter:(NSDictionary *)dictionary sucess:(void (^) (NSDictionary *dictionary))sucess falid:(void (^) (NSString *errorMsg))faild;
//告警列表接口
- (void)getWarningWithParamter:(NSMutableDictionary *)dictionary sucess:(void (^) (NSDictionary *dictionary))sucess falid:(void (^) (NSString *errorMsg))faild;
//我的告警列表接口
- (void)getMyWarningWithParamter:(NSDictionary *)dictionary sucess:(void (^) (NSDictionary *dictionary))sucess falid:(void (^) (NSString *errorMsg))faild;
//催办接口列表
- (void)getDoPersonWithParamter:(NSDictionary *)dictionary sucess:(void (^) (NSDictionary *dictionary))sucess falid:(void (^) (NSString *errorMsg))faild;
//各省分告警统计分析接口
- (void)getAllProvincesWithParamter:(NSDictionary *)dictionary sucess:(void (^) (NSDictionary *dictionary))sucess falid:(void (^) (NSString *errorMsg))faild;
//待办事项
- (void)getTodoListWithParamter:(NSDictionary *)dictionary sucess:(void (^) (NSDictionary *dictionary))sucess falid:(void (^) (NSString *errorMsg))faild;
//获取当月集团频发告警的系统前十名
- (void)getTopPinWithParamter:(NSDictionary *)dictionary sucess:(void (^) (NSDictionary *dictionary))sucess falid:(void (^) (NSString *errorMsg))faild;
//本月集团频发告警设备top10
- (void)getTopSheWithParamter:(NSDictionary *)dictionary sucess:(void (^) (NSDictionary *dictionary))sucess falid:(void (^) (NSString *errorMsg))faild;
//本月集团频发告警类别top10
- (void)getTopLeiWithParamter:(NSDictionary *)dictionary sucess:(void (^) (NSDictionary *dictionary))sucess falid:(void (^) (NSString *errorMsg))faild;
//本月集团频发告警机房top10
- (void)getTopJiWithParamter:(NSDictionary *)dictionary sucess:(void (^) (NSDictionary *dictionary))sucess falid:(void (^) (NSString *errorMsg))faild;
//本月省分频发告警类别top10
- (void)getTopShengWithParamter:(NSDictionary *)dictionary sucess:(void (^) (NSDictionary *dictionary))sucess falid:(void (^) (NSString *errorMsg))faild;
//趋势图
- (void)getTrendWithParamter:(NSDictionary *)dictionary sucess:(void (^) (NSDictionary *dictionary))sucess falid:(void (^) (NSString *errorMsg))faild;
//通知接口
- (void)getNoticeWithParamter:(NSDictionary *)dictionary sucess:(void (^) (NSDictionary *dictionary))sucess falid:(void (^) (NSString *errorMsg))faild;
//通知token
- (void)getDeviceTokenWithParamter:(NSDictionary *)dictionary sucess:(void (^) (NSDictionary *dictionary))sucess falid:(void (^) (NSString *errorMsg))faild;
@end
