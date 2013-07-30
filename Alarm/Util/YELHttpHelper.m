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
//告警列表接口
- (void)getWarningWithParamter:(NSMutableDictionary *)dictionary sucess:(void (^) (NSDictionary *dictionary))sucess falid:(void (^) (NSString *errorMsg))faild{
    
    [[HttpRequestHelper defaultController]asyncGetRequest:APIGetWaring parameter:dictionary requestStrComplete:^(NSString *responseStr) {
        NSData *data = [responseStr dataUsingEncoding: NSUTF8StringEncoding];
        NSDictionary *dictionary=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        if (dictionary) {
            sucess(dictionary);
        }
    } requestFailed:^(NSString *errorMsg) {
        faild(errorMsg);
    }];
}
//我的告警列表接口
- (void)getMyWarningWithParamter:(NSDictionary *)dictionary sucess:(void (^) (NSDictionary *dictionary))sucess falid:(void (^) (NSString *errorMsg))faild{
    
    [[HttpRequestHelper defaultController]asyncGetRequest:APIGetMyWaring parameter:dictionary requestStrComplete:^(NSString *responseStr) {
        NSData *data = [responseStr dataUsingEncoding: NSUTF8StringEncoding];
        NSDictionary *dictionary=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        if (dictionary) {
            sucess(dictionary);
        }
    } requestFailed:^(NSString *errorMsg) {
        faild(errorMsg);
    }];
}
//催办接口列表
- (void)getDoPersonWithParamter:(NSDictionary *)dictionary sucess:(void (^) (NSDictionary *dictionary))sucess falid:(void (^) (NSString *errorMsg))faild{
    
    [[HttpRequestHelper defaultController]asyncGetRequest:APIGetWaringUser parameter:dictionary requestStrComplete:^(NSString *responseStr) {
        NSData *data = [responseStr dataUsingEncoding: NSUTF8StringEncoding];
        NSDictionary *dictionary=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        if (dictionary) {
            sucess(dictionary);
        }
    } requestFailed:^(NSString *errorMsg) {
        faild(errorMsg);
    }];
}
//获取当月集团频发告警的系统前十名
- (void)getTopPinWithParamter:(NSDictionary *)dictionary sucess:(void (^) (NSDictionary *dictionary))sucess falid:(void (^) (NSString *errorMsg))faild{
    
    [[HttpRequestHelper defaultController]asyncGetRequest:APIGetTopPin parameter:dictionary requestStrComplete:^(NSString *responseStr) {
        NSData *data = [responseStr dataUsingEncoding: NSUTF8StringEncoding];
        NSDictionary *dictionary=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        if (dictionary) {
            sucess(dictionary);
        }
    } requestFailed:^(NSString *errorMsg) {
        faild(errorMsg);
    }];
}
//本月集团频发告警设备top10
- (void)getTopSheWithParamter:(NSDictionary *)dictionary sucess:(void (^) (NSDictionary *dictionary))sucess falid:(void (^) (NSString *errorMsg))faild{
    
    [[HttpRequestHelper defaultController]asyncGetRequest:APIGetTopShe parameter:dictionary requestStrComplete:^(NSString *responseStr) {
        NSData *data = [responseStr dataUsingEncoding: NSUTF8StringEncoding];
        NSDictionary *dictionary=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        if (dictionary) {
            sucess(dictionary);
        }
    } requestFailed:^(NSString *errorMsg) {
        faild(errorMsg);
    }];
}
//本月集团频发告警类别top10
- (void)getTopLeiWithParamter:(NSDictionary *)dictionary sucess:(void (^) (NSDictionary *dictionary))sucess falid:(void (^) (NSString *errorMsg))faild{
    
    [[HttpRequestHelper defaultController]asyncGetRequest:APIGetTopLei parameter:dictionary requestStrComplete:^(NSString *responseStr) {
        NSData *data = [responseStr dataUsingEncoding: NSUTF8StringEncoding];
        NSDictionary *dictionary=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        if (dictionary) {
            sucess(dictionary);
        }
    } requestFailed:^(NSString *errorMsg) {
        faild(errorMsg);
    }];
}
//本月集团频发告警机房top10
- (void)getTopJiWithParamter:(NSDictionary *)dictionary sucess:(void (^) (NSDictionary *dictionary))sucess falid:(void (^) (NSString *errorMsg))faild{
    
    [[HttpRequestHelper defaultController]asyncGetRequest:APIGetTopJi parameter:dictionary requestStrComplete:^(NSString *responseStr) {
        NSData *data = [responseStr dataUsingEncoding: NSUTF8StringEncoding];
        NSDictionary *dictionary=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        if (dictionary) {
            sucess(dictionary);
        }
    } requestFailed:^(NSString *errorMsg) {
        faild(errorMsg);
    }];
}
//本月省分频发告警类别top10
- (void)getTopShengWithParamter:(NSDictionary *)dictionary sucess:(void (^) (NSDictionary *dictionary))sucess falid:(void (^) (NSString *errorMsg))faild{
    
    [[HttpRequestHelper defaultController]asyncGetRequest:APIGetTopSheng parameter:dictionary requestStrComplete:^(NSString *responseStr) {
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
//趋势图
- (void)getTrendWithParamter:(NSDictionary *)dictionary sucess:(void (^) (NSDictionary *dictionary))sucess falid:(void (^) (NSString *errorMsg))faild{
    
    [[HttpRequestHelper defaultController]asyncGetRequest:APIGetTrend parameter:dictionary requestStrComplete:^(NSString *responseStr) {
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
