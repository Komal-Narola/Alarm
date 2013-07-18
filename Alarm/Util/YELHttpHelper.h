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
- (void)loginWithParamter:(NSDictionary *)dictionary sucess:(void (^) (NSDictionary *))sucess falid:(void (^) (NSString *errorMsg))faild;
//修改密码
- (void)changePwdWithParamter:(NSDictionary *)dictionary sucess:(void (^) (NSDictionary *))sucess falid:(void (^) (NSString *errorMsg))faild;
//下载首页图片
- (void)getImageWithParamter:(NSDictionary *)dictionary sucess:(void (^) (NSDictionary *))sucess falid:(void (^) (NSString *errorMsg))faild;
@end
