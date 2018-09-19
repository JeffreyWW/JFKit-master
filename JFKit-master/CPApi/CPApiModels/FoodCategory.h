//
// Created by Jeffrey on 2018/9/19.
// Copyright (c) 2018 Jeffrey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+YYModel.h"

@class FoodSubCategory;

@interface FoodParentCategory : NSObject
@property(nonatomic, copy) NSString *parentId;
@property(nonatomic, copy) NSString *name;
@end

@interface FoodDefaultCategory : FoodParentCategory <YYModel>
@property(nonatomic, copy) NSArray <FoodSubCategory *> *list;
@end


@interface FoodSubCategory : FoodParentCategory <YYModel>
@property(nonatomic, copy) NSString *categoryId;
@end