//
//  HttpRequestHelper.m
//  YELASIHttpHelper
//
//  Created by rock on 13-7-16.
//  Copyright (c) 2013年 Ye Erliang. All rights reserved.
//

#import "HttpRequestHelper.h"

@interface HttpRequestHelper ()
{
    ASINetworkQueue *_requestQueue;
}
@end

@implementation HttpRequestHelper
static HttpRequestHelper *_defaultController = nil;

+(HttpRequestHelper *)defaultController
{
     @synchronized(_defaultController) {
         if (_defaultController == nil)
         {
             _defaultController = [[HttpRequestHelper alloc] init];
         }
     }
    return _defaultController;
}

- (id)init
{
    self = [super init];
    if (self) {
        _requestQueue=[[ASINetworkQueue alloc]init];
        [_requestQueue setDelegate:self];
        [_requestQueue setMaxConcurrentOperationCount:MaxConcurrentOperationCount];
        [_requestQueue setShowAccurateProgress:YES];
        [_requestQueue setUploadProgressDelegate:self];
        [_requestQueue setDownloadProgressDelegate:self];
        [_requestQueue setShouldCancelAllRequestsOnFailure:NO];
        [_requestQueue go];
    }
    return self;
}

- (ASIHTTPRequest *)requestWithUrl:(NSString *)urlStr{
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    [request setDefaultResponseEncoding:NSUTF8StringEncoding];

    [request setTimeOutSeconds:TimeOut];
    [request setShouldAttemptPersistentConnection:YES];
    [request setPersistentConnectionTimeoutSeconds:120];
    [request setNumberOfTimesToRetryOnTimeout:RetryTimes];

    return [request autorelease];
}

- (ASIFormDataRequest *)formRequestWithUrl:(NSString *)urlStr{
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];

    [request setTimeOutSeconds:TimeOut];
    [request setNumberOfTimesToRetryOnTimeout:RetryTimes];
    return [request autorelease];
}
#pragma mark - 发送异步Get请求
//返回文本数据 小数据
- (ASIHTTPRequest *)asyncGetRequest:(NSString *)url
                          parameter:(NSDictionary *)dictionary
                    requestStrComplete:(void (^)(NSString *responseStr))requestComplete
                      requestFailed:(void (^)(NSString *errorMsg))requestFailed{
    if (dictionary!=nil)
    {
        url=[self fillUrl:url fromDictionary:dictionary];
    }
    __block ASIHTTPRequest *request = [self requestWithUrl:url];
    //请求成功
    [request setCompletionBlock:^{
        switch (request.responseStatusCode) {
            case RequestStatus_OK:
                requestComplete(request.responseString);break;
            case RequestStatus_ErrorRequest:
                requestFailed(@"错误的请求");break;
            case RequestStatus_NotFound:
                requestFailed(@"找不到指定的资源");break;
            case RequestStatus_Error:
                requestFailed(@"内部服务器错误");break;
            default:
                requestFailed(@"服务器出错");break;
        }
    }];
    //请求失败
    [request setFailedBlock:^{
        requestFailed([NSString stringWithFormat:@"网络连接失败"]);
    }];
    [_requestQueue addOperation:request];
    return request;
}
//返回文件数据  大数据
- (ASIHTTPRequest *)asyncGetRequest:(NSString *)url
                          parameter:(NSDictionary *)dictionary
                requestDataComplete:(void (^)(NSData *responseData))requestComplete
                      requestFailed:(void (^)(NSString *errorMsg))requestFailed
{
    if (dictionary!=nil)
    {
        url=[self fillUrl:url fromDictionary:dictionary];
    }
    __block ASIHTTPRequest *request = [self requestWithUrl:url];
    //请求成功
    [request setCompletionBlock:^{
        switch (request.responseStatusCode) {
            case RequestStatus_OK:
                requestComplete(request.responseData);break;
            case RequestStatus_ErrorRequest:
                requestFailed(@"错误的请求");break;
            case RequestStatus_NotFound:
                requestFailed(@"找不到指定的资源");break;
            case RequestStatus_Error:
                requestFailed(@"内部服务器错误");break;
            default:
                requestFailed(@"服务器出错");break;
        }
    }];
    //请求失败
    [request setFailedBlock:^{
        requestFailed([NSString stringWithFormat:@"网络连接失败"]);
    }];
    [_requestQueue addOperation:request];
    return request;

}

- (NSString *)fillUrl:(NSString *)url
     fromDictionary:(NSDictionary *)postValueDic
{
    NSMutableString *urlStr = [NSMutableString stringWithFormat:@"%@?",url];
    
    for (int i=0;i<[postValueDic count];++i)
    {
        (i==0)?:[urlStr appendString:@"&"];
        NSString *key = [[postValueDic allKeys] objectAtIndex:i];
        NSString *value = [[postValueDic allValues] objectAtIndex:i];
        [urlStr appendFormat:@"%@=%@",key,value];
    }
    return urlStr;
}

- (void)dealloc
{
	[super dealloc];
}
@end
