//
// Created by Jeffrey on 2018/9/13.
// Copyright (c) 2018 Jeffrey. All rights reserved.
//

#import "CPApi.h"
#import "CPApiError.h"

@implementation CPApi
- (RACSignal *)signal {
    @weakify(self);
    if (!_signal) {
        JFNetManager *netManager = [JFNetManager managerWithDomain:@"https://route.showapi.com/1164-2" subUrl:nil requestMethod:JFRequestMethodPOST];
        netManager.responseDataStyle = JFDataStyleJson;
        _signal = [netManager.coldSignal tryMap:^CPApiResponse *(id response, NSError **errorPtr) {
            return [self signalWithNetResponse:response error:errorPtr];
        }];
    }
    return _signal;
}

#pragma mark - 主要加密方式

#pragma mark - 主要解析方式

/**网络转化为新的Api信号*/
- (CPApiResponse *)signalWithNetResponse:(id)response error:(NSError **)error {
    CPApiResponse *apiResponse = [CPApiResponse modelWithJSON:response];
    if (apiResponse.responseCode != 0) {
        *error = [CPApiError errorWithErrorType:(CPApiErrorType) apiResponse.responseCode response:apiResponse];
        return nil;
    }
    return apiResponse;
}


@end