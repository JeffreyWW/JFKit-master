//
// Created by Jeffrey on 2018/9/13.
// Copyright (c) 2018 Jeffrey. All rights reserved.
//

#import "CPApi.h"


@implementation CPApi
- (RACSignal *)signal {
    @weakify(self);
    JFNetManager *netManager = [JFNetManager managerWithDomain:@"https://route.showapi.com/1164-2" subUrl:nil requestMethod:JFRequestMethodPOST];
    netManager.responseDataStyle = JFDataStyleJson;
    RACSignal *signal = [netManager.coldSignal flattenMap:^RACSignal *(id response) {
        return [self signalWithNetResponse:response];
    }];

    return signal;
}

#pragma mark - 主要加密方式

#pragma mark - 主要解析方式

/**网络转化为新的Api信号*/
- (RACSignal *)signalWithNetResponse:(id)response {
    @weakify(self);
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
        @strongify(self);
        [subscriber sendNext:response];
        return nil;
    }];
    return signal;
}


@end