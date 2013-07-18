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
@end
