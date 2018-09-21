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
/**
 * 综合信号,传入两个信号,将会:
 * 1.在当前视图转圈
 * 2.等待传入信号A完成,完成后进行3
 * 3.若成功,停止转圈,并监听A的next
 * 4.若失败,停止转圈,弹错误原因,并执行信号B的错误处理
 * */
/**弹提示信号*/
@property(nonatomic, copy, readonly) RACSignal *(^simpleSignnal)(RACSignal *listeningSignal, RACSignal *dealErrorSignal);
@end