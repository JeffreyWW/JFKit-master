//
// Created by Jeffrey on 2018/9/19.
// Copyright (c) 2018 Jeffrey. All rights reserved.
//

#import "CPApi+Instance.h"
#import "FoodCategory.h"

@implementation CPApi (Instance)
+ (CPApi *)getFoodCategory:(FoodParentCategory *)foodParentCategory {
    CPApi *api = [[CPApi alloc] init];
    api.responseTypeClass = FoodParentCategory.class;
    if (!foodParentCategory) {
        return api;
    }
    api.parameters = @{
            @"parentid": foodParentCategory.parentId
    };
    return api;
}

@end