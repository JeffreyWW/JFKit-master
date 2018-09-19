//
// Created by Jeffrey on 2018/9/18.
// Copyright (c) 2018 Jeffrey. All rights reserved.
//

#import "CPApiError.h"
#import "MBProgressHUD+JF.h"

@implementation CPApiError

- (instancetype)initWithErrorType:(CPApiErrorType)errorType response:(CPApiResponse *)response {
    self = [super initWithDomain:@"capPu" code:errorType userInfo:[response modelToJSONObject]];
    if (self) {
        _errorType = errorType;
        _response = response;
    }

    return self;
}

+ (instancetype)errorWithErrorType:(CPApiErrorType)errorType response:(CPApiResponse *)response {
    return [[self alloc] initWithErrorType:errorType response:response];
}

@end

@implementation UIViewController (DealError)
- (void (^)(__kindof NSError *))dealError {
    __weak typeof(self) weakSelf = self;
    return ^(__kindof NSError *error) {
        [weakSelf dealError:error];
    };
}

- (void)dealError:(__kindof NSError *)error {
    NSString *alertMessage = nil;
    if ([error isKindOfClass:CPApiError.class]) {
        CPApiError *cpApiError = error;
        alertMessage = cpApiError.response.reason;
        __weak typeof(self) weakSelf = self;
        self.hiddenIndeterminateCompletion(^{
            [MBProgressHUD showMessage:alertMessage inView:self.view completionBlock:^{
                NSLog(@"INFO:%@",alertMessage);
                [weakSelf dealWithCpApiErrorType:cpApiError.errorType];
            }];
        });
    } else {

    }
}

- (void)dealWithCpApiErrorType:(CPApiErrorType)errorType {
    NSLog(@"INFO:内部处理");
    switch (errorType) {
        case CPApiErrorTypeNone:
            break;
    }
}
@end
