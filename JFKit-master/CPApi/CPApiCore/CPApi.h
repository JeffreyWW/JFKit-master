//
// Created by Jeffrey on 2018/9/13.
// Copyright (c) 2018 Jeffrey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JFNetManager.h"
#import "CPApiResponse.h"

@interface CPApi<ResponseType> : NSObject <YYModel>
@property(nonatomic, strong) RACSignal<ResponseType> *signal;
@property(nonatomic, copy) NSString *method;
@property(nonatomic, copy) NSArray *main;
@property(nonatomic, assign) Class responseTypeClass;

@end