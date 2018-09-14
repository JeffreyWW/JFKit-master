//
// Created by Jeffrey on 2018/9/14.
// Copyright (c) 2018 Jeffrey. All rights reserved.
//

#import "CPApiResponse.h"


@implementation CPApiResponse
+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper {
    return @{
            @"resId":@"showapi_res_id",
            @"errorMessage":@"showapi_res_error",
            @"responseCode":@"showapi_res_code",
            @"body":@"showapi_res_body",
    };
}


@end