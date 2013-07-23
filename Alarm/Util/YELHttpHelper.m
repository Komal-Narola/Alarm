//
//  YELHttpHelper.m
//  Alarm
//
//  Created by rock on 13-7-18.
//  Copyright (c) 2013年 Ye Erliang. All rights reserved.
//

#import "YELHttpHelper.h"

@implementation YELHttpHelper
static YELHttpHelper *_httpHelper = nil;

+(YELHttpHelper *)defaultHelper
{
    @synchronized(_httpHelper) {
        if (_httpHelper == nil)
        {
            _httpHelper = [[YELHttpHelper alloc] init];
        }
    }
    return _httpHelper;
}
#pragma mark - 登陆
- (void)loginWithParamter:(NSDictionary *)dictionary sucess:(void (^) (NSDictionary *dictionary))sucess falid:(void (^) (NSString *errorMsg))faild{
    
    [[HttpRequestHelper defaultController]asyncGetRequest:APILogin parameter:dictionary requestStrComplete:^(NSString *responseStr) {
        NSData *data = [responseStr dataUsingEncoding: NSUTF8StringEncoding];
        NSDictionary *dictionary=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        if (dictionary) {
            sucess(dictionary);
        }
    } requestFailed:^(NSString *errorMsg) {
        faild(errorMsg);
    }];
}
//修改密码
- (void)changePwdWithParamter:(NSDictionary *)dictionary sucess:(void (^) (NSDictionary *dictionary))sucess falid:(void (^) (NSString *errorMsg))faild{
    
    [[HttpRequestHelper defaultController]asyncGetRequest:APIChangePwd parameter:dictionary requestStrComplete:^(NSString *responseStr) {
        NSData *data = [responseStr dataUsingEncoding: NSUTF8StringEncoding];
        NSDictionary *dictionary=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        if (dictionary) {
            sucess(dictionary);
        }
    } requestFailed:^(NSString *errorMsg) {
        faild(errorMsg);
    }];
}
//下载首页图片
- (void)getImageWithParamter:(NSDictionary *)dictionary sucess:(void (^) (NSDictionary *dictionary))sucess falid:(void (^) (NSString *errorMsg))faild{
    
    [[HttpRequestHelper defaultController]asyncGetRequest:APIGetImage parameter:dictionary requestStrComplete:^(NSString *responseStr) {
        NSData *data = [responseStr dataUsingEncoding: NSUTF8StringEncoding];
        NSDictionary *dictionary=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        if (dictionary) {
            sucess(dictionary);
        }
    } requestFailed:^(NSString *errorMsg) {
        faild(errorMsg);
    }];
}
//系统运行状态
- (void)getSystemStateWithParamter:(NSDictionary *)dictionary sucess:(void (^) (NSDictionary *dictionary))sucess falid:(void (^) (NSString *errorMsg))faild{
    
    [[HttpRequestHelper defaultController]asyncGetRequest:APIGetgetSystemState parameter:dictionary requestStrComplete:^(NSString *responseStr) {
        NSData *data = [responseStr dataUsingEncoding: NSUTF8StringEncoding];
        NSDictionary *dictionary=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        if (dictionary) {
            sucess(dictionary);
        }
    } requestFailed:^(NSString *errorMsg) {
        faild(errorMsg);
    }];
}
//各省分告警统计分析接口
- (void)getAllProvincesWithParamter:(NSDictionary *)dictionary sucess:(void (^) (NSDictionary *dictionary))sucess falid:(void (^) (NSString *errorMsg))faild{
    
    [[HttpRequestHelper defaultController]asyncGetRequest:APIGetgetAllProvinces parameter:dictionary requestStrComplete:^(NSString *responseStr) {
        NSData *data = [responseStr dataUsingEncoding: NSUTF8StringEncoding];
        NSDictionary *dictionary=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        if (dictionary) {
            sucess(dictionary);
        }
    } requestFailed:^(NSString *errorMsg) {
        faild(errorMsg);
    }];
}
//待办事项
- (void)getTodoListWithParamter:(NSDictionary *)dictionary sucess:(void (^) (NSDictionary *dictionary))sucess falid:(void (^) (NSString *errorMsg))faild{
    
    [[HttpRequestHelper defaultController]asyncGetRequest:APIGetOrderList parameter:dictionary requestStrComplete:^(NSString *responseStr) {
        NSData *data = [responseStr dataUsingEncoding: NSUTF8StringEncoding];
        NSDictionary *dictionary=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        if (dictionary) {
            sucess(dictionary);
        }
    } requestFailed:^(NSString *errorMsg) {
        faild(errorMsg);
    }];
}
@end
