//
// Created by Jeffrey on 2018/9/21.
// Copyright (c) 2018 Jeffrey. All rights reserved.
//

#import "NSError+CPApi.h"
#import "UIViewController+MBProgressHUD_RACSignal.h"


@implementation NSError (CPApi)
@end

@implementation UIViewController (DealError)

- (RACSignal *(^)(__kindof NSError *))dealErrorSignal {
    @weakify(self);
    return ^RACSignal *(__kindof NSError *error) {
        if ([error.domain isEqualToString:@"com.crf"]) {
            return [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
                CPApiErrorType errorType = (CPApiErrorType) error.code;
                [self dealWithCpApiErrorType:errorType];
                [subscriber sendCompleted];
                return nil;
            }];
        } else {
            return nil;
        }
    };
}

- (void (^)(__kindof NSError *))dealErrorBlock {
    return ^(__kindof NSError *error) {
        if ([error.domain isEqualToString:@"com.crf"]) {
            CPApiErrorType errorType = (CPApiErrorType) error.code;
            [self dealWithCpApiErrorType:errorType];
        } else {

        }
    };
}


- (RACSignal *(^)(__kindof NSError *))showErrorSignal {
    return ^RACSignal *(__kindof NSError *error) {
        return [[self.hiddenIndeterminateSignal concat:self.showErrorMessageSignal(error)] concat:self.dealErrorSignal(error)];
    };

}

- (void (^)(__kindof NSError *))showErrorBlock {
    return ^(__kindof NSError *error) {
        [[self.hiddenIndeterminateSignal concat:self.showErrorMessageSignal(error)] subscribeCompleted:^{
            self.dealErrorSignal(error);
        }];
    };
}

- (void)dealWithCpApiErrorType:(CPApiErrorType)errorType {
    NSLog(@"INFO:内部处理");
    switch (errorType) {
        case CPApiErrorTypeNone:
            break;
    }
}
@end