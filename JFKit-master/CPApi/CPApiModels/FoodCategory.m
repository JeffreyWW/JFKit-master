//
// Created by Jeffrey on 2018/9/19.
// Copyright (c) 2018 Jeffrey. All rights reserved.
//

#import "FoodCategory.h"

@implementation FoodParentCategory
+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{
            @"list": FoodSubCategory.class
    };
}

@end

@implementation FoodSubCategory
+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper {
    return @{
            @"categoryId": @"id"
    };
}


@end