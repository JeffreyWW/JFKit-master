//
// Created by Jeffrey on 2018/9/19.
// Copyright (c) 2018 Jeffrey. All rights reserved.
//

#import "VMHome.h"

@implementation VMHome
- (RACSignal *)foodSignal {
    if (!_foodSignal) {
        @weakify(self);
        _foodSignal = [[CPApi getFoodCategory:nil].signal doNext:^(CPApiResponse<NSArray<FoodParentCategory *> *> *x) {
            @strongify(self);
            self.dataSource = x.result;
        }];
    }
    return _foodSignal;
}


@end