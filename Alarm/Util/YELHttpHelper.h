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
- (void)getWarningWithParamter:(NSDictionary *)dictionary sucess:(void (^) (NSDictionary *dictionary))sucess falid:(void (^) (NSString *errorMsg))faild;
//我的告警列表接口
- (void)getMyWarningWithParamter:(NSDictionary *)dictionary sucess:(void (^) (NSDictionary *dictionary))sucess falid:(void (^) (NSString *errorMsg))faild;
//催办接口列表
- (void)getDoPersonWithParamter:(NSDictionary *)dictionary sucess:(void (^) (NSDictionary *dictionary))sucess falid:(void (^) (NSString *errorMsg))faild;
//各省分告警统计分析接口
- (void)getAllProvincesWithParamter:(NSDictionary *)dictionary sucess:(void (^) (NSDictionary *dictionary))sucess falid:(void (^) (NSString *errorMsg))faild;
//待办事项
- (void)getTodoListWithParamter:(NSDictionary *)dictionary sucess:(void (^) (NSDictionary *dictionary))sucess falid:(void (^) (NSString *errorMsg))faild;
@end
