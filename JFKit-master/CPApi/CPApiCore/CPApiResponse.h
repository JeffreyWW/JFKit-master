//
// Created by Jeffrey on 2018/9/14.
// Copyright (c) 2018 Jeffrey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+YYModel.h"

@interface CPApiResponse<ResponseType> : NSObject <YYModel>
@property(nonatomic, copy) NSString *reason;
@property(nonatomic, strong) ResponseType result;
@end