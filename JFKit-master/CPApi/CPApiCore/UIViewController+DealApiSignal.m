//
// Created by Jeffrey on 2018/9/25.
// Copyright (c) 2018 Jeffrey. All rights reserved.
//

#import "UIViewController+DealApiSignal.h"
#import "UIViewController+MBProgressHUD_RACSignal.h"
#import "NSError+CPApi.h"
#import "NSAttributedString+YYText.h"

@implementation UIViewController (DealApiSignal)
- (RACSignal *(^)(RACSignal *))simpleSignal {
    return ^RACSignal *(RACSignal *listeningSignal) {
        NSMutableAttributedString *attributedString;
        attributedString.alignment = NSTextAlignmentCenter;
        return [[[self.showLoadingIndeterminateSignal concat:listeningSignal] concat:self.hiddenIndeterminateSignal] catch:self.showErrorSignal];
    };
}
@end