//
// Created by Jeffrey on 2018/9/19.
// Copyright (c) 2018 Jeffrey. All rights reserved.
//

#import "VMHome.h"

@implementation VMHome

- (RACCommand *)refreshCommand {
    if (!_refreshCommand) {
        @weakify(self);
        _refreshCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [[CPApi getFoodCategory:nil].signal doNext:^(CPApiResponse *x) {
                @strongify(self);
                self.dataSource = x.result;
            }];
        }];
    }
    return _refreshCommand;
}

@end