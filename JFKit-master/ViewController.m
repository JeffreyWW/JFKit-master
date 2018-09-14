//
//  ViewController.m
//  JFKit-master
//
//  Created by Jeffrey on 2018/9/12.
//  Copyright © 2018 Jeffrey. All rights reserved.
//

#import <ReactiveObjC/UITextField+RACSignalSupport.h>
#import "ViewController.h"
#import "JFNetManager.h"
#import "NSBundle+YYAdd.h"
#import "CPApi.h"

@interface ViewController ()

@property(nonatomic, strong) JFNetManager *netManager;
@property(nonatomic, strong) CPApi *api;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    NSString *f = [[NSBundle mainBundle] pathForScaledResource:@"fuck" ofType:@"plist"];
//    NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:f];
//    NSArray *array = [NSArray arrayWithContentsOfFile:f];

//    self.netManager = [JFNetManager managerWithDomain:@"https://www.baidu.com" subUrl:nil requestMethod:JFRequestMethodGET];
    self.api = [[CPApi alloc] init];
//    [[self.netManager.command.executionSignals skip:1] subscribeNext:^(RACSignal *x) {
//        [x subscribeNext:^(id x) {
//            NSLog(@"%@", x);
//        }];
//    }];

}

- (IBAction)clickBtnRequest:(UIButton *)sender {
    [self.api.signal subscribeNext:^(id x) {
        NSLog(@"INFO:信息打印");
        NSDictionary *dictionary = x;
        NSLog(@"*RESPONSE:%@", dictionary);
        NSLog(@"DEBUG:debug打印");

    }                        error:^(NSError *error) {
        NSLog(@"info:%@", error);
    }];
    //    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
//        [subscriber sendNext:@"fuck"];
//        [subscriber sendError:[NSError errorWithDomain:@"" code:0 userInfo:nil]];
//        return nil;
//    }];

//    RACSignal *signal1 = [signal map:^id(id value) {
//        return @"god";
//    }];
//
//    [signal1 subscribeNext:^(id x) {
//        NSLog(@"%@", x);
//    }];

//    [[signal flattenMap:^RACSignal *(id value) {
//        return [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
//            [subscriber sendNext:@"ok"];
//            return nil;
//        }];;
//    }] subscribeNext:^(id x) {
//        NSLog(@"%@",x);
//
//    }          error:^(NSError *error) {
//        NSLog(@"错误");
//    }];

//    [self.netManager.signal subscribeNext:^(id x) {
//    }];
//    [self.netManager.signal subscribeError:^(NSError *error) {
//
//    }];
//    [self.netManager.coldSignal subscribeNext:^(id x) {
//        NSLog(@"1");
//    }                                   error:^(NSError *error) {
//        NSLog(@"2");
//    }];
//    [self.netManager.command execute:@"1"];
//    [self.netManager.command execute:@"2"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end