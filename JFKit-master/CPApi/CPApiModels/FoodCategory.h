//
// Created by Jeffrey on 2018/9/19.
// Copyright (c) 2018 Jeffrey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+YYModel.h"

@class FoodSubCategory;

@interface FoodParentCategory : NSObject <YYModel>
@property(nonatomic, copy) NSString *parentId;
@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSArray <FoodSubCategory *> *list;
@end


@interface FoodSubCategory : NSObject <YYModel>
@property(nonatomic, copy) NSString *categoryId;
@property(nonatomic, copy) NSString *name;
@end