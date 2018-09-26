//
// Created by Jeffrey on 2018/9/21.
// Copyright (c) 2018 Jeffrey. All rights reserved.
//
/**
 * 控制器弹提示的信号转换
 */
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ReactiveObjC.h"

@interface UIViewController (MBProgressHUD_RACSignal)
/**转圈信号*/
@property(nonatomic, copy, readonly) RACSignal *(^showIndeterminateSignal)(NSString *title);
/**转圈提示,"显示加载中"*/
@property(nonatomic, strong) RACSignal *showLoadingIndeterminateSignal;
/**停止转圈*/
@property(nonatomic, strong) RACSignal *hiddenIndeterminateSignal;
/**弹提示信号*/
@property(nonatomic, copy, readonly) RACSignal *(^showMessageSignal)(NSString *message);
/**弹错误提示,错误信息为NSLocalizedFailureReasonErrorKey*/
@property(nonatomic, copy, readonly) RACSignal *(^showErrorMessageSignal)(__kindof NSError *error);
@end