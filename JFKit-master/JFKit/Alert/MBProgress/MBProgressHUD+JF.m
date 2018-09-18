//
// Created by Jeffrey on 2018/9/17.
// Copyright (c) 2018 Jeffrey. All rights reserved.
//

#import "MBProgressHUD+JF.h"
#import <objc/runtime.h>

@implementation MBProgressHUD (JF)
+ (instancetype)HUDDefaultWithView:(UIView *)view {
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    /**内容色，类似tintColor,会改变默认的菊花等颜色和字体颜色（但字体颜色单独设置也还是会生效）*/
    hud.contentColor = [UIColor whiteColor];
    hud.bezelView.color = [UIColor blackColor];
//    hud.backgroundView.blurEffectStyle = UIBlurEffectStyleProminent;
    hud.bezelView.style = MBProgressHUDBackgroundStyleBlur;
    /**最小显示时间，默认设置为1秒*/
    hud.minShowTime = 1;
    /**动画样式，缩放*/
    hud.animationType = MBProgressHUDAnimationZoom;
    /**标题字体，注：label显示title，detailsLabel显示描述，区别在于title无法换行*/
    hud.label.font = [UIFont systemFontOfSize:22];
    /**描述字体*/
    hud.detailsLabel.font = [UIFont systemFontOfSize:18];
//    hud.detailsLabel.text = title;
    /**隐藏的时候移除*/
    hud.removeFromSuperViewOnHide = YES;
    return hud;
}

+ (instancetype)HUDIndeterminateWithView:(UIView *)view title:(NSString *)title {
    MBProgressHUD *hud = [self HUDDefaultWithView:view];
    hud.detailsLabel.text = title;
    return hud;
}

+ (void)showMessage:(NSString *)message inView:(UIView *)view completionBlock:(MBProgressHUDCompletionBlock)completionBlock {
    if (message.length == 0) {
        if (completionBlock) {
            completionBlock();
        }
        return;
    }
    MBProgressHUD *hud = [self HUDDefaultWithView:view];
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabel.text = message;
    [view addSubview:hud];
    [hud showAnimated:YES];
    [hud setCompletionBlock:completionBlock];
    [hud hideAnimated:YES afterDelay:2];
}

+ (void)showMessage:(NSString *)message inView:(UIView *)view {
    [self showMessage:message inView:view completionBlock:nil];
}

/**结束动画并执行回调*/
- (void)hiddenAnimateCompletion:(MBProgressHUDCompletionBlock)completionBlock {
    [self setCompletionBlock:completionBlock];
    [self hideAnimated:YES];
}

- (void)hiddenAnimate {
    [self hiddenAnimateCompletion:nil];
}
@end

static const void *_Nonnull hudKey;

@implementation UIViewController (MBProgressHUD)
- (void (^)(NSString *))showIndeterminate {
    return ^(NSString *title) {
        MBProgressHUD *progressHUD = objc_getAssociatedObject(self, hudKey);
        if (!progressHUD) {
            progressHUD = [MBProgressHUD HUDIndeterminateWithView:self.view title:title];
            objc_setAssociatedObject(self, hudKey, progressHUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        [self.view addSubview:progressHUD];
        [progressHUD showAnimated:YES];
    };
}

- (void (^)(void))showIndeterminateLoading {
    __weak typeof(self) weakSelf = self;
    return ^{
        weakSelf.showIndeterminate(@"加载中");
    };
}

- (dispatch_block_t)hiddenIndeterminate {
    return ^{
        self.hiddenIndeterminateCompletion(nil);
    };
}

- (void (^)(dispatch_block_t))hiddenIndeterminateCompletion {
    return ^(dispatch_block_t completion) {
        MBProgressHUD *progressHUD = objc_getAssociatedObject(self, hudKey);
        if (progressHUD) {
            [progressHUD hiddenAnimateCompletion:completion];
        } else {
            completion();
        }
    };
}


//- (NSString *(^)(void))showIndeterminate {
//    return ^NSString * {
//        return nil;
//    };
//    MBProgressHUD *hud = objc_getAssociatedObject(self, hudKey);
//    if (!hud) {
//        hud = [MBProgressHUD HUDIndeterminateWithView:self.view title:_title];
//    }
//
//    return _showIndeterminate;
//}

@end