//
// Created by Jeffrey on 2018/9/14.
// Copyright (c) 2018 Jeffrey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+YYModel.h"

typedef NS_ENUM(NSInteger, CPResponseCode) {
    CPResponseCodeSuccess = 0,
};

@interface CPApiResponse<ResponseType> : NSObject <YYModel>

@property(nonatomic, copy) NSString *resId;
@property(nonatomic, copy) NSString *errorMessage;
@property(nonatomic, assign) CPResponseCode responseCode;
@property(nonatomic, strong) ResponseType body;
@end