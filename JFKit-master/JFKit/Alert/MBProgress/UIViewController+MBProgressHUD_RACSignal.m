//
// Created by Jeffrey on 2018/9/21.
// Copyright (c) 2018 Jeffrey. All rights reserved.
//

#import "UIViewController+MBProgressHUD_RACSignal.h"
#import "MBProgressHUD+JF.h"
#import "NSError+CPApi.h"

@implementation UIViewController (MBProgressHUD_RACSignal)
- (RACSignal *(^)(NSString *))showIndeterminateSignal {
    return ^RACSignal *(NSString *title) {
        @weakify(self);
        return [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
            @strongify(self);
            [MBProgressHUD showIndeterminateWithTitle:title inView:self.view];
            [subscriber sendCompleted];
            return nil;
        }];
    };
}

- (RACSignal *)showLoadingIndeterminateSignal {
    return self.showIndeterminateSignal(@"加载中");
}

- (RACSignal *)hiddenIndeterminateSignal {
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
        @strongify(self);
        [MBProgressHUD hiddenIndeterminateInView:self.view completionBlock:^{
            [subscriber sendCompleted];
        }];
        return nil;
    }];
}

- (RACSignal *(^)(NSString *))showMessageSignal {
    return ^RACSignal *(NSString *message) {
        RACSignal *showSignal = [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
            [MBProgressHUD showMessage:message inView:self.view completionBlock:^{
                [subscriber sendCompleted];
            }];
            return nil;
        }];
        /**内部会先看是否有转圈,如果有则停止在弹提示*/
        return [self.hiddenIndeterminateSignal concat:showSignal];
    };
}

- (RACSignal *(^)(__kindof NSError *))showErrorMessageSignal {
    return ^RACSignal *(__kindof NSError *error) {
        NSString *errorReason = error.userInfo[NSLocalizedFailureReasonErrorKey];
        return self.showMessageSignal(errorReason);
    };
}



@end