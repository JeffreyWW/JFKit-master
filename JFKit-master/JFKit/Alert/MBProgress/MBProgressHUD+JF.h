//
// Created by Jeffrey on 2018/9/17.
// Copyright (c) 2018 Jeffrey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"
#import "ReactiveObjC.h"

@interface MBProgressHUD (JF)
/**
 * 显示菊花并带自定义title
 * @param title 菊花下的title
 * @param view 在哪个视图显示
 */
+ (instancetype)showIndeterminateWithTitle:(NSString *)title inView:(UIView *)view;

/**
 * 隐藏菊花
 * @param view 所在的view
 * @param completionBlock 完成的回调
 */
+ (void)hiddenIndeterminateInView:(UIView *)view completionBlock:(MBProgressHUDCompletionBlock)completionBlock;

/**
 * 显示信息,然后消失,默认2秒
 * @param message 显示的信息
 * @param view 在哪个视图显示
 * @param completionBlock 结束回调
 */
+ (void)showMessage:(NSString *)message inView:(UIView *)view completionBlock:(MBProgressHUDCompletionBlock)completionBlock;

/**同上,无回调*/
+ (void)showMessage:(NSString *)message inView:(UIView *)view;

@end


