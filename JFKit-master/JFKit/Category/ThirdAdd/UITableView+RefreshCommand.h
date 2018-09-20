//
// Created by Jeffrey on 2018/9/19.
// Copyright (c) 2018 Jeffrey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MJRefresh.h"
#import "ReactiveObjC.h"

@interface UITableView (RefreshCommand)
/**下拉刷新命令,下拉后会自动执行初始化的信号并在结束后停止刷新*/
@property(nonatomic, strong) RACCommand *rac_refreshCommand;
@property(nonatomic, strong) RACCommand *rac_loadMoreCommand;
@end