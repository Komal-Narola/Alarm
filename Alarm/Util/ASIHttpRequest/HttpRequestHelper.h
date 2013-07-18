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
//自定义POST求情
- (ASIHTTPRequest *)asyncCustomPostRequest:(NSString *)url
                                 parameter:(NSDictionary *)dictionary
                        requestStrComplete:(void (^)(NSString *responseStr))requestComplete
                             requestFailed:(void (^)(NSString *errorMsg))requestFailed;
//request体比较大时 使用流式读取
- (ASIHTTPRequest *)asyncCustomPostBigStreamRequest:(NSString *)url
                                          parameter:(NSDictionary *)dictionary
                                 requestStrComplete:(void (^)(NSString *responseStr))requestComplete
                                      requestFailed:(void (^)(NSString *errorMsg))requestFailed;
//OBJC类型POST请求
-(ASIFormDataRequest*)asyncPostObjRequest:(NSString*)url
                                parameter:(NSDictionary *)dictionary
                       requestStrComplete:(void(^)(NSString *responseStr))complete
                            requestFailed:(void(^)(NSString*errorMsg))failed;
//JOSN类型POST请求
-(ASIFormDataRequest*)asyncPostJsonRequest:(NSString*)url
                                 parameter:(NSDictionary *)dictionary
                        requestStrComplete:(void(^)(NSString *responseStr))complete
                             requestFailed:(void(^)(NSString*errorMsg))failed;
//下载文件 下载前判断文件是否存在
- (ASIHTTPRequest *)asyncDownloadDestinationRequest:(NSString *)url
                                           fileName:(NSString *)name
                                                Dir:(NSString *)pathName
                                 requestStrComplete:(void (^)(NSString *responseStr))requestComplete
                                      requestFailed:(void (^)(NSString *errorMsg))requestFailed;
//上传文件 从硬盘读取文件 OBJC类型 dictionary包含文本参数（可以为nil,只上传文件） filePath文件硬盘路径 fileKey文件KEY
//filePath 跟 fileData  二选一
-(ASIFormDataRequest*)asyncPostTextAndFileRequest:(NSString*)url
                                        parameter:(NSDictionary *)dictionary
                                         filePath:(NSString *)filePath
                                         fileData:(NSData *)fileData
                                          fileKey:(NSString *)fileKey
                               requestStrComplete:(void(^)(NSString *responseStr))complete
                                    requestFailed:(void(^)(NSString*errorMsg))failed;
//上传多个文件 同一个KEY
-(ASIFormDataRequest*)asyncPostTextAndSameFileRequest:(NSString*)url
                                            parameter:(NSDictionary *)dictionary
                                             filePath:(NSArray *)filePath
                                             fileData:(NSArray *)fileData
                                              fileKey:(NSString *)fileKey
                                   requestStrComplete:(void(^)(NSString *responseStr))complete
                                        requestFailed:(void(^)(NSString*errorMsg))failed;
//检查文件是否存在
+(BOOL)checkFileExsit:(NSString *)fileName Dir:(NSString *)fileDir;
@end
