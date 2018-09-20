//
// Created by Jeffrey on 2018/9/19.
// Copyright (c) 2018 Jeffrey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CPApi.h"

@class FoodParentCategory;

@interface CPApi (Instance)

+ (CPApi<NSArray<FoodParentCategory *> *> *)getFoodCategory:(FoodParentCategory *)foodParentCategory;
@end