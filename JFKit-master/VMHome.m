//
// Created by Jeffrey on 2018/9/19.
// Copyright (c) 2018 Jeffrey. All rights reserved.
//

#import "VMHome.h"

@implementation VMHome
- (RACSignal *)foodSignal {
    if (!_foodSignal) {
        _foodSignal = [CPApi getFoodCategory:nil].signal;
    }
    return _foodSignal;
}

- (RACCommand *)refreshCommand {
    if (!_refreshCommand) {
        @weakify(self);
        _refreshCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            return self.foodSignal;
        }];
        [[_refreshCommand.executionSignals switchToLatest] subscribeNext:^(CPApiResponse *x) {
            @strongify(self);
            self.dataSource = x.result;
        }];
    }
    return _refreshCommand;
}

@end