//
// Created by Jeffrey on 2018/9/19.
// Copyright (c) 2018 Jeffrey. All rights reserved.
//

#import "UITableView+RefreshCommand.h"

static const void *_Nonnull refreshCommandKey;

@implementation UITableView (RefreshCommand)

- (RACCommand *)rac_refreshCommand {
    RACCommand *command = objc_getAssociatedObject(self, refreshCommandKey);
    return command;
}

- (void)setRac_refreshCommand:(RACCommand *)rac_refreshCommand {
    [rac_refreshCommand.executing subscribeNext:^(NSNumber *x) {
//        NSLog(@"INFO111111:%@", x);
        BOOL executing = x.boolValue;
        if (!executing) {
            [self reloadData];
            [self.mj_header endRefreshing];
        }
    }];
    objc_setAssociatedObject(self, refreshCommandKey, rac_refreshCommand, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
//    [rac_refreshCommand.executionSignals subscribeNext:^(RACSignal *x) {
//        /**若手动执行execute,则会走这里,并取调用refresh,内部会再次执行execute,但是因为还没完成,不会执行后续操作
//         * 创建时候的信号该发送还是会发送*/
//        NSLog(@"INFO:开始刷新");
//        [self.mj_header beginRefreshing];
//    }] ;
    [rac_refreshCommand.executionSignals subscribeNext:^(RACSignal *x) {
        NSLog(@"INFO:1");
    } error:^(NSError *error) {
        NSLog(@"INFO:1");

    } completed:^{
        NSLog(@"INFO:1");

    }];
}

- (void)refresh {
    [self.rac_refreshCommand execute:nil];
}
@end