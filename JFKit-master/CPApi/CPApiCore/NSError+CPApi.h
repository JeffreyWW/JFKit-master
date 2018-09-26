//
// Created by Jeffrey on 2018/9/21.
// Copyright (c) 2018 Jeffrey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ReactiveObjC.h"

typedef NS_ENUM(NSInteger, CPApiErrorType) {
    CPApiErrorTypeNone,
};

@interface NSError (CPApi)
@end

@interface UIViewController (DealError)
/**处理失败的信号,只是处理逻辑*/
@property(nonatomic, copy) RACSignal* (^dealErrorSignal)(__kindof NSError *error);
@property(nonatomic, copy) RACSignal* (^showErrorSignal)(__kindof NSError *error);
/**显示错误信息并处理错误的block,可直接执行*/
@property(nonatomic, copy) void (^dealErrorBlock)(__kindof NSError *error);
@property(nonatomic, copy) void (^showErrorBlock)(__kindof NSError *error);

@end