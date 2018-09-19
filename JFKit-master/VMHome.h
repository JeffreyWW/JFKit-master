//
// Created by Jeffrey on 2018/9/19.
// Copyright (c) 2018 Jeffrey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveObjC.h"
#import "CPApi+Instance.h"

@interface VMHome : NSObject
@property(nonatomic, strong) RACCommand *refreshCommand;
@property(nonatomic, strong) NSArray *dataSource;
@end