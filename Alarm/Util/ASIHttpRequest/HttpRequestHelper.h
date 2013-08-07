//
//  HttpRequestHelper.h
//  YELASIHttpHelper
//
//  Created by rock on 13-7-16.
//  Copyright (c) 2013年 Ye Erliang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASINetworkQueue.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "ASIDownloadCache.h"
//#define UserAgent  @"Chinaunicom 1.0"
#define TimeOut 10
#define RetryTimes 1
#define MaxConcurrentOperationCount 4

//定义服务器响应码
typedef enum {
	RequestStatus_OK = 200,
    RequestStatus_ErrorRequest = 400,
    RequestStatus_NotFound = 404,
    RequestStatus_Error = 500,
}RequestStatus;
@interface HttpRequestHelper : NSObject

+(HttpRequestHelper *)defaultController;
#pragma mark - 发送异步Get请求
//GET方法 返回文本数据 小数据
- (ASIHTTPRequest *)asyncGetRequest:(NSString *)url
                          parameter:(NSDictionary *)dictionary
                 requestStrComplete:(void (^)(NSString *responseStr))requestComplete
                      requestFailed:(void (^)(NSString *errorMsg))requestFailed;
//GET方法 返回文件数据  大数据
- (ASIHTTPRequest *)asyncGetRequest:(NSString *)url
                          parameter:(NSDictionary *)dictionary
                 requestDataComplete:(void (^)(NSData *responseData))requestComplete
                      requestFailed:(void (^)(NSString *errorMsg))requestFailed;
@end
