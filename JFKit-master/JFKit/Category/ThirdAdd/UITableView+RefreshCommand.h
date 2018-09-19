//
// Created by Jeffrey on 2018/9/19.
// Copyright (c) 2018 Jeffrey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MJRefresh.h"
#import "ReactiveObjC.h"

@interface UITableView (RefreshCommand)
@property(nonatomic, strong) RACCommand *rac_refreshCommand;
@property(nonatomic, strong) RACCommand *rac_loadMoreCommand;
@end