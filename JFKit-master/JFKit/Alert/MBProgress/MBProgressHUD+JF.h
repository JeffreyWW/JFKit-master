//
// Created by Jeffrey on 2018/9/17.
// Copyright (c) 2018 Jeffrey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface MBProgressHUD (JF)

+ (instancetype)HUDIndeterminateWithView:(UIView *)view title:(NSString *)title;

+ (void)showMessage:(NSString *)message inView:(UIView *)view completionBlock:(MBProgressHUDCompletionBlock)completionBlock;

+ (void)showMessage:(NSString *)message inView:(UIView *)view;

- (void)hiddenAnimateCompletion:(MBProgressHUDCompletionBlock)completionBlock;

- (void)hiddenAnimate;
@end

@interface UIViewController (MBProgressHUD)
@property(nonatomic, copy) void (^showIndeterminate)(NSString *title);
@property(nonatomic, copy) void (^showIndeterminateLoading)(void);
@property(nonatomic, copy) void (^hiddenIndeterminate)(void);
@property(nonatomic, copy) void (^hiddenIndeterminateCompletion)(dispatch_block_t completion);
@end