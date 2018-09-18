//
//  ViewController.m
//  JFKit-master
//
//  Created by Jeffrey on 2018/9/12.
//  Copyright © 2018 Jeffrey. All rights reserved.
//

#import "ViewController.h"
#import "JFNetManager.h"
#import "CPApi.h"
#import "MBProgressHUD+JF.h"
#import "CPApiError.h"

@interface ViewController ()

@property(nonatomic, strong) JFNetManager *netManager;
@property(nonatomic, strong) CPApi *api;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.api = [[CPApi alloc] init];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickBtnRequest:(UIButton *)sender {

    RACSignal *signal = [[[self.api.signal initially:self.showIndeterminateLoading] doCompleted:self.hiddenIndeterminate] doError:self.dealError];

    [signal subscribeError:^(NSError *error) {
        NSLog(@"INFO:错误");
    }];
}
@end