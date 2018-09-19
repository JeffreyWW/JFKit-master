//
// Created by Jeffrey on 2018/9/19.
// Copyright (c) 2018 Jeffrey. All rights reserved.
//

#import "VMHome.h"
@implementation VMHome
- (CPApi *)categoryApi {
    if (!_categoryApi) {
        _categoryApi = [CPApi getFoodCategory:nil];
    }
    return _categoryApi;
}


@end