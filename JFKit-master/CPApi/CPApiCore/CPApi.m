//
// Created by Jeffrey on 2018/9/13.
// Copyright (c) 2018 Jeffrey. All rights reserved.
//

#import "CPApi.h"
#import "CPApiError.h"

static NSString *const kAppKey = @"4740860db0d0fcd49666663ae5f97f0e";

@interface CPApi ()
@property(nonatomic, strong) JFNetManager *netManager;
@end

@implementation CPApi
- (RACSignal *)signal {
    @weakify(self);
    if (!_signal) {
        _netManager = [JFNetManager managerWithDomain:@"https://apis.juhe.cn/cook/category" subUrl:nil requestMethod:JFRequestMethodPOST];
        self.netManager.responseDataStyle = JFDataStyleJson;
        _signal = [_netManager.coldSignal tryMap:^CPApiResponse *(id response, NSError **errorPtr) {
            /**将网络信号转化为api信号(转化成功情况下的错误)*/
            return [self signalWithNetResponse:response error:errorPtr];
        }];
    }
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    NSDictionary *staticParameters = @{
            @"key": kAppKey,
    };
    [parameters setValuesForKeysWithDictionary:staticParameters];
    if (self.parameters) {
        [parameters setValuesForKeysWithDictionary:self.parameters];
    }
    _netManager.parameters = staticParameters;
    return _signal;
}

#pragma mark - 主要加密方式

#pragma mark - 主要解析方式

/**网络转化为新的Api信号*/
- (CPApiResponse *)signalWithNetResponse:(id)response error:(NSError **)error {
    CPApiResponse *apiResponse = [CPApiResponse modelWithJSON:response];
    id result = response[@"result"];
    if (self.responseTypeClass) {
        if ([result isKindOfClass:NSArray.class]) {
            apiResponse.result = [NSArray modelArrayWithClass:self.responseTypeClass json:result];
        } else {
            apiResponse.result = [self.responseTypeClass modelWithJSON:result];
        }
    } else {
        apiResponse.result = result;
    }
    CPApiErrorType errorType = (CPApiErrorType) [response[@"error_code"] integerValue];
    if (errorType != CPApiErrorTypeNone) {
        *error = [CPApiError errorWithErrorType:(CPApiErrorType) apiResponse.errorType response:apiResponse];
        return nil;
    }
    return apiResponse;
}


@end