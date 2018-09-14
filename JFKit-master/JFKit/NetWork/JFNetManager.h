//
// Created by Jeffrey on 2018/9/12.
// Copyright (c) 2018 Jeffrey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import <ReactiveObjC/ReactiveObjC.h>


#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnullability-completeness"
typedef NS_ENUM(NSInteger, JFRequestMethod) {
    JFRequestMethodGET,
    JFRequestMethodPOST,
    JFRequestMethodHEAD,
    JFRequestMethodPUT,
    JFRequestMethodDELETE,
    JFRequestMethodPATCH,
};
typedef NS_ENUM(NSInteger, JFDataStyle) {
    JFDataStyleHTTP,
    JFDataStyleJson,
};

@interface JFNetManager : NSObject
/**域名*/
@property(nonatomic, copy) NSString *domain;
/**子域名*/
@property(nonatomic, copy) NSString *subUrl;
/**参数*/
@property(nonatomic, strong) id parameters;
/**方法名*/
@property(nonatomic, assign) JFRequestMethod requestMethod;
/**请求格式*/
@property(nonatomic, assign) JFDataStyle requestDataStyle;
/**结果格式*/
@property(nonatomic, assign) JFDataStyle responseDataStyle;
@property(nonatomic, strong) RACMulticastConnection *connection;
@property(nonatomic, strong) RACCommand *command;
/**外部api通过此信号转化为新的信号,入参为解析类,方法名等,先通过加密赋值parameters,最后的筛选结果通过soruceSignal筛选,*/
@property(nonatomic, strong) RACSignal *coldSignal;


+ (instancetype)managerWithDomain:(NSString *)domain subUrl:(NSString *)subUrl requestMethod:(JFRequestMethod)requestMethod;

- (void)cancel;

- (void)requestProgress:(void (^)(NSProgress *_Nonnull))progress success:(void (^)(NSURLSessionDataTask *_Nonnull, id _Nullable response))success failure:(void (^)(NSURLSessionDataTask *_Nullable, NSError *_Nonnull))failure;
@end

#pragma clang diagnostic pop