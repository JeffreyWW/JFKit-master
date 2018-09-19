//
// Created by Jeffrey on 2018/9/18.
// Copyright (c) 2018 Jeffrey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CPApiResponse.h"

typedef NS_ENUM(NSInteger, CPApiErrorType) {
    CPApiErrorTypeNone,
};

@interface CPApiError : NSError
@property(nonatomic, assign) CPApiErrorType errorType;
@property(nonatomic, strong) CPApiResponse *response;

- (instancetype)initWithErrorType:(CPApiErrorType)errorType response:(CPApiResponse *)response;

+ (instancetype)errorWithErrorType:(CPApiErrorType)errorType response:(CPApiResponse *)response;

@end

@interface UIViewController (DealError)
@property(nonatomic, copy) void (^dealError)(__kindof NSError *);
@end