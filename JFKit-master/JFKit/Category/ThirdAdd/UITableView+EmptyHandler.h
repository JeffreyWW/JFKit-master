//
// Created by Jeffrey on 2018/9/20.
// Copyright (c) 2018 Jeffrey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ReactiveObjC.h"

typedef NS_ENUM(NSInteger, JFEmptyType) {
    JFEmptyTypeNone = -1,
    JFEmptyTypeDefault,
    JFEmptyTypeError,
};

@interface JFEmptyHandler : NSObject
@property(nonatomic, assign) JFEmptyType emptyType;
@property(nonatomic, strong) RACCommand *reloadCommand;
@end

@interface UITableView (EmptyHandler)
@property(nonatomic, strong) JFEmptyHandler *emptyHandler;
@end