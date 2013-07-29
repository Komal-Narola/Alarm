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
    //设置超时
    [request setTimeOutSeconds:TimeOut];//设置超时时间
    [request setShouldAttemptPersistentConnection:YES];//使用持久连接
    [request setPersistentConnectionTimeoutSeconds:120];//持久连接
    [request setNumberOfTimesToRetryOnTimeout:RetryTimes];//超时重试次数
//    [request setDownloadProgressDelegate:];
//    [request setUploadProgressDelegate:<#(id)#>];
    return [request autorelease];
}

- (ASIFormDataRequest *)formRequestWithUrl:(NSString *)urlStr{
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    //设置超时
    [request setTimeOutSeconds:TimeOut];//设置超时时间
    [request setNumberOfTimesToRetryOnTimeout:RetryTimes];//超时重试次数
    //设置缓存
    //    [request setDownloadCache:[ASIDownloadCache sharedCache]];//设置下载缓存
    //    [request setCachePolicy:ASIAskServerIfModifiedWhenStaleCachePolicy];//缓存策略
    //    [request setCacheStoragePolicy:ASICacheForSessionDurationCacheStoragePolicy];//缓存存储方式
    //    [request setSecondsToCache:60*60*24*30];// 缓存30天
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
#pragma mark- 自定义POST请求
//从内存上传
- (ASIHTTPRequest *)asyncCustomPostRequest:(NSString *)url
                          parameter:(NSDictionary *)dictionary
                 requestStrComplete:(void (^)(NSString *responseStr))requestComplete
                      requestFailed:(void (^)(NSString *errorMsg))requestFailed{
    __block ASIHTTPRequest *request = [self requestWithUrl:url];
    //[request setRequestMethod:@"PUT"];PUT方法
    [request setRequestMethod:@"POST"];
    if (dictionary!=nil)
    {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:nil];
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        [request appendPostData:[jsonString  dataUsingEncoding:NSUTF8StringEncoding]];
    }
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
//request体比较大时 使用流式读取
- (ASIHTTPRequest *)asyncCustomPostBigStreamRequest:(NSString *)url
                                 parameter:(NSDictionary *)dictionary
                        requestStrComplete:(void (^)(NSString *responseStr))requestComplete
                             requestFailed:(void (^)(NSString *errorMsg))requestFailed{
    __block ASIHTTPRequest *request = [self requestWithUrl:url];
    [request setShouldStreamPostDataFromDisk:YES];
    [request setRequestMethod:@"PUT"];
    if (dictionary!=nil)
    {
        //KEY值 乱写的   二选一
        [request setPostBodyFilePath:[dictionary objectForKey:@"fileName"]];
//        [request appendPostDataFromFile:[dictionary objectForKey:@"fileName"]];
    }
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

#pragma mark - 异步Post请求
//OBJC类型POST请求
-(ASIFormDataRequest*)asyncPostObjRequest:(NSString*)url
                             parameter:(NSDictionary *)dictionary
                       requestStrComplete:(void(^)(NSString *responseStr))complete
                         requestFailed:(void(^)(NSString*errorMsg))failed{
    
    __block ASIFormDataRequest *request = [self formRequestWithUrl:url];
    //设置请求参数
	if (dictionary != nil)
    {
		NSArray *parameterKeys_ = [dictionary allKeys];
		for (int i=0; i<[parameterKeys_ count]; i++) {
			id key_ = [parameterKeys_ objectAtIndex:i];
			id value_ = [dictionary objectForKey:key_];
            [request setPostValue:value_ forKey:key_];
		}
	}
    
    //请求成功
    [request setCompletionBlock:^{
        switch (request.responseStatusCode) {
            case RequestStatus_OK:
                complete(request.responseString);
                break;
            case RequestStatus_ErrorRequest:
                failed(@"错误的请求");break;
            case RequestStatus_NotFound:
                failed(@"找不到指定的资源");break;
            case RequestStatus_Error:
                failed(@"内部服务器错误");break;
            default:
                failed(@"服务器出错");break;
        }
    }];
    //请求失败
    [request setFailedBlock:^{
        failed([NSString stringWithFormat:@"内部错误,请稍后在试..."]);
    }];
    [_requestQueue addOperation:request];
    return request;
    
}
//JOSN类型POST请求
-(ASIFormDataRequest*)asyncPostJsonRequest:(NSString*)url
                                parameter:(NSDictionary *)dictionary
                       requestStrComplete:(void(^)(NSString *responseStr))complete
                            requestFailed:(void(^)(NSString*errorMsg))failed
{
    __block ASIFormDataRequest *request = [self formRequestWithUrl:url];
    //设置请求参数
	if (dictionary != nil)
    {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:nil];
        NSMutableData *data = [NSMutableData dataWithData:jsonData];
        [request setPostBody:data];
	}
    //请求成功
    [request setCompletionBlock:^{
        switch (request.responseStatusCode) {
            case RequestStatus_OK:
                complete(request.responseString);
                break;
            case RequestStatus_ErrorRequest:
                failed(@"错误的请求");break;
            case RequestStatus_NotFound:
                failed(@"找不到指定的资源");break;
            case RequestStatus_Error:
                failed(@"内部服务器错误");break;
            default:
                failed(@"服务器出错");break;
        }
    }];
    //请求失败
    [request setFailedBlock:^{
        failed([NSString stringWithFormat:@"内部错误,请稍后在试..."]);
    }];
    [_requestQueue addOperation:request];
    return request;
}
//上传文件 从硬盘读取文件 OBJC类型 dictionary包含文本参数（可以为nil,只上传文件） filePath文件硬盘路径 fileKey文件KEY
//filePath 跟 fileData  二选一 
-(ASIFormDataRequest*)asyncPostTextAndFileRequest:(NSString*)url
                                        parameter:(NSDictionary *)dictionary
                                         filePath:(NSString *)filePath
                                         fileData:(NSData *)fileData
                                          fileKey:(NSString *)fileKey
                               requestStrComplete:(void(^)(NSString *responseStr))complete
                                    requestFailed:(void(^)(NSString*errorMsg))failed
{
    __block ASIFormDataRequest *request = [self formRequestWithUrl:url];
    //设置请求参数
	if (dictionary != nil)
    {
        NSArray *parameterKeys_ = [dictionary allKeys];
		for (int i=0; i<[parameterKeys_ count]; i++) {
			id key_ = [parameterKeys_ objectAtIndex:i];
			id value_ = [dictionary objectForKey:key_];
            [request setPostValue:value_ forKey:key_];
		}
	}
    if (filePath!=nil) {
        //数据的mime头自动判定
        [request setFile:filePath forKey:fileKey];
        //自己定义mime头
        //    [request setFile:filePath withFileName:@"myPhoto.jpg" andContentType:@"image/jpeg" forKey:fileKey];
    }
    if (fileData!=nil) {
        [request setData:fileData forKey:fileKey];
        //自己定义mime头
//        [request setData:fileData withFileName:@"myPhoto.jpg" andContentType:@"image/jpeg" forKey:fileKey];

    }
    //请求成功
    [request setCompletionBlock:^{
        switch (request.responseStatusCode) {
            case RequestStatus_OK:
                complete(request.responseString);
                break;
            case RequestStatus_ErrorRequest:
                failed(@"错误的请求");break;
            case RequestStatus_NotFound:
                failed(@"找不到指定的资源");break;
            case RequestStatus_Error:
                failed(@"内部服务器错误");break;
            default:
                failed(@"服务器出错");break;
        }
    }];
    //请求失败
    [request setFailedBlock:^{
        failed([NSString stringWithFormat:@"内部错误,请稍后在试..."]);
    }];
    [_requestQueue addOperation:request];
    return request;
}
//上传多个文件 同一个KEY
-(ASIFormDataRequest*)asyncPostTextAndSameFileRequest:(NSString*)url
                                        parameter:(NSDictionary *)dictionary
                                         filePath:(NSArray *)filePath
                                         fileData:(NSArray *)fileData
                                          fileKey:(NSString *)fileKey
                               requestStrComplete:(void(^)(NSString *responseStr))complete
                                    requestFailed:(void(^)(NSString*errorMsg))failed
{
    __block ASIFormDataRequest *request = [self formRequestWithUrl:url];
    //设置请求参数
	if (dictionary != nil)
    {
        NSArray *parameterKeys_ = [dictionary allKeys];
		for (int i=0; i<[parameterKeys_ count]; i++) {
			id key_ = [parameterKeys_ objectAtIndex:i];
			id value_ = [dictionary objectForKey:key_];
            [request setPostValue:value_ forKey:key_];
		}
	}
    if (filePath!=nil) {
        //数据的mime头自动判定
        for (int i=0; i<[filePath count]; i++) {
            [request addFile:[filePath objectAtIndex:i] forKey:fileKey];
        }
    }
    if (fileData!=nil) {
        for (int i=0; i<[fileData count]; i++) {
            [request addData:[fileData objectAtIndex:i] forKey:fileKey];
        }
    }
    //请求成功
    [request setCompletionBlock:^{
        switch (request.responseStatusCode) {
            case RequestStatus_OK:
                complete(request.responseString);
                break;
            case RequestStatus_ErrorRequest:
                failed(@"错误的请求");break;
            case RequestStatus_NotFound:
                failed(@"找不到指定的资源");break;
            case RequestStatus_Error:
                failed(@"内部服务器错误");break;
            default:
                failed(@"服务器出错");break;
        }
    }];
    //请求失败
    [request setFailedBlock:^{
        failed([NSString stringWithFormat:@"内部错误,请稍后在试..."]);
    }];
    [_requestQueue addOperation:request];
    return request;
}
//下载文件
- (ASIHTTPRequest *)asyncDownloadDestinationRequest:(NSString *)url
                                           fileName:(NSString *)name
                                                Dir:(NSString *)pathName
                        requestStrComplete:(void (^)(NSString *responseStr))requestComplete
                             requestFailed:(void (^)(NSString *errorMsg))requestFailed{
    __block ASIHTTPRequest *request = [self requestWithUrl:url];
    [request setDownloadCache:[ASIDownloadCache sharedCache]];//打开缓存机制
    //ASICacheForSessionDurationCacheStoragePolicy是默认值。相应数据只会在会话期间被存储，在第一次使用cache时，或者在调用 [ASIHTTPRequest clearSession]时，数据会被清除。
    //使用ASICachePermanentlyCacheStoragePolicy，缓存的相应数据会被永久存储
    //要手动清除cache，调用函数clearCachedResponsesForStoragePolicy:,传入要清除的cache数据的存储策略：
    //[[ASIDownloadCache sharedCache] clearCachedResponsesForStoragePolicy:ASICachePermanentlyCacheStoragePolicy];
    [request setCacheStoragePolicy:ASICacheForSessionDurationCacheStoragePolicy];//存储策略
    
    //缓存策略
    [request setCachePolicy:ASIAskServerIfModifiedWhenStaleCachePolicy|ASIFallbackToCacheIfLoadFailsCachePolicy];
    if ([name rangeOfString:@"/"].location!=NSNotFound) {
        NSArray *fArray = [name componentsSeparatedByString:@"/"];
        name= [fArray lastObject];
    }
    [request setDownloadDestinationPath:[[ASIDownloadCache sharedCache] pathToStoreCachedResponseDataForRequest:request]];
//    [request setDownloadDestinationPath:[self getFilePath:name Dir:pathName]];
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
//文件路径
- (NSString *)getFilePath:(NSString *)filename Dir:(NSString *)dir{
    //创建文档文件夹
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];

    NSString *imageDir = [documentsDirectory stringByAppendingPathComponent:dir];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:imageDir]) {
        [fileManager createDirectoryAtPath:imageDir
               withIntermediateDirectories:YES
                                attributes:nil
                                     error:nil];
    }
    return [imageDir stringByAppendingPathComponent:filename];
}
//检查文件是否存在
+(BOOL)checkFileExsit:(NSString *)fileName Dir:(NSString *)fileDir{
    BOOL result = NO;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    //ASI缓存路径 未测试路径是否正确
//    NSString *testPath = [[documentDirectory stringByAppendingPathComponent:[[ASIDownloadCache sharedCache]storagePath]] stringByAppendingPathComponent:fileName];
    NSString *testPath = [[documentDirectory stringByAppendingPathComponent:fileDir] stringByAppendingPathComponent:fileName];
    NSFileManager *fm = [NSFileManager defaultManager];
    if([fm fileExistsAtPath:testPath]){
        result = YES;
    }
    return result;
}

- (void)dealloc
{
	[super dealloc];
}
@end
