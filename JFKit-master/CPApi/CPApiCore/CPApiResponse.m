//
// Created by Jeffrey on 2018/9/14.
// Copyright (c) 2018 Jeffrey. All rights reserved.
//

#import "CPApiResponse.h"


@implementation CPApiResponse
+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper {
    return @{
            @"resultCode": @"resultcode",
    };
}

+ (nullable NSArray<NSString *> *)modelPropertyBlacklist {
    return @[@"error_code"];
}

@end