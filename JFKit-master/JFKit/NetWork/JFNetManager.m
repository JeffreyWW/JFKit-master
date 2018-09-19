//
// Created by Jeffrey on 2018/9/12.
// Copyright (c) 2018 Jeffrey. All rights reserved.
//

#import <ReactiveObjC/UITextField+RACSignalSupport.h>
#import "JFNetManager.h"
#import "RACSignal.h"
#import "ReactiveObjC.h"
#import "RACMulticastConnection.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnonnull"

@interface JFNetManager ()
@property(nonatomic, strong) AFHTTPSessionManager *sectionManager;
@property(nonatomic, strong) NSURLSessionDataTask *task;
@end

@implementation JFNetManager

- (instancetype)initWithDomain:(NSString *)domain subUrl:(NSString *)subUrl requestMethod:(JFRequestMethod)requestMethod {
    self = [super init];
    if (self) {
        _domain = [domain copy];
        _subUrl = [subUrl copy];
        _requestMethod = requestMethod;
        _sectionManager = [[AFHTTPSessionManager alloc] init];
        _sectionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", @"charset=utf-8", @"multipart/form-data", nil];
    }

    return self;
}

+ (instancetype)managerWithDomain:(NSString *)domain subUrl:(NSString *)subUrl requestMethod:(JFRequestMethod)requestMethod {
    return [[self alloc] initWithDomain:domain subUrl:subUrl requestMethod:requestMethod];
}

- (void)cancel {
    if (self.task) {
        [self.task cancel];
    }
}

- (void)setRequestDataStyle:(JFDataStyle)requestDataStyle {
    _requestDataStyle = requestDataStyle;
    AFHTTPRequestSerializer *serializer = nil;
    switch (_requestDataStyle) {
        case JFDataStyleHTTP:
            serializer = [AFHTTPRequestSerializer serializer];
            break;
        case JFDataStyleJson:
            serializer = [AFJSONRequestSerializer serializer];
            break;
    }
    self.sectionManager.requestSerializer = serializer;
}

- (void)setResponseDataStyle:(JFDataStyle)responseDataStyle {
    _responseDataStyle = responseDataStyle;
    AFHTTPResponseSerializer *serializer = nil;
    switch (_responseDataStyle) {
        case JFDataStyleHTTP:
            serializer = [AFHTTPResponseSerializer serializer];
            break;
        case JFDataStyleJson:
            serializer = [AFJSONResponseSerializer serializer];
            break;
    }
    serializer.acceptableContentTypes = self.sectionManager.responseSerializer.acceptableContentTypes;
    self.sectionManager.responseSerializer = serializer;
}

- (void)requestProgress:(void (^)(NSProgress *_Nonnull))progress
                success:(void (^)(NSURLSessionDataTask *_Nonnull, id _Nullable response))success
                failure:(void (^)(NSURLSessionDataTask *_Nullable, NSError *_Nonnull))failure {
    NSString *url = [self.domain stringByAppendingPathComponent:self.subUrl];
    switch (self.requestMethod) {
        case JFRequestMethodGET:
            self.task = [self.sectionManager GET:url parameters:self.parameters progress:progress success:success failure:failure];
            break;
        case JFRequestMethodPOST:
            self.task = [self.sectionManager POST:url parameters:self.parameters progress:progress success:success failure:failure];
            break;
        case JFRequestMethodHEAD: {
            self.task = [self.sectionManager HEAD:url parameters:self.parameters success:^(NSURLSessionDataTask *task) {
                success(task, nil);
            }                             failure:failure];
        }
            break;
        case JFRequestMethodPUT:
            self.task = [self.sectionManager PUT:url parameters:self.parameters success:success failure:failure];
            break;
        case JFRequestMethodDELETE:
            self.task = [self.sectionManager DELETE:url parameters:self.parameters success:success failure:failure];
            break;
        case JFRequestMethodPATCH:
            self.task = [self.sectionManager PATCH:url parameters:self.parameters success:success failure:failure];
            break;
    }
}

- (RACSignal *)coldSignal {
    if (!_coldSignal) {
        @weakify(self);
        _coldSignal = [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
            [self requestProgress:nil success:^(NSURLSessionDataTask *task, id response) {

                [subscriber sendNext:response];
                NSLog(@"INFO:success");
                [subscriber sendCompleted];
            }             failure:^(NSURLSessionDataTask *task, NSError *error) {
                [subscriber sendError:error];
            }];
            return nil;
        }];
    }
    return _coldSignal;
}

@end


#pragma clang diagnostic pop