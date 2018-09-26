//
// Created by Jeffrey on 2018/9/25.
// Copyright (c) 2018 Jeffrey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ReactiveObjC.h"

@interface UIViewController (DealApiSignal)
/**
 * 简单信号,它会:
 * 首先转圈,然后连接listeningSignal信号
 * listeningSignal执行完毕后:
 * 成功:隐藏转圈
 * 失败:隐藏转圈,并弹提示,最后处理错误逻辑
 */
@property(nonatomic, copy, readonly) RACSignal *(^simpleSignal)(RACSignal *listeningSignal);
@end