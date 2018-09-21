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
#import "FoodCategory.h"
#import "VMHome.h"
#import "UITableView+RefreshCommand.h"
#import "UIScrollView+EmptyDataSet.h"
#import "UIViewController+MBProgressHUD_RACSignal.h"
#import "NSError+CPApi.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, DZNEmptyDataSetDelegate, DZNEmptyDataSetSource>
@property(nonatomic, weak) IBOutlet UITableView *tableView;
@property(nonatomic, copy) NSArray<FoodParentCategory *> *dataSource;
@property(nonatomic, strong) VMHome *viewModel;
@end

@implementation ViewController
static NSString *cellId = @"cellId";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    [self setupRAC];
}

- (void)setupRAC {
    self.viewModel = [[VMHome alloc] init];
    RAC(self, dataSource) = [RACObserve(self.viewModel, dataSource) skip:1];
    RACSignal *apiSignal = [self.viewModel.foodSignal catch:^RACSignal *(NSError *error) {
        return [self.showErrorMessageSignal(error) concat:self.dealErrorSignal(error)];;
    }];
    self.tableView.rac_refreshCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return apiSignal;
    }];
}

- (void)setupTableView {
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:cellId];
//    [self.tableView.rac_refreshCommand execute:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource[(NSUInteger) section].list.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    /**显示一次,不用动态绑定*/
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    FoodSubCategory *subCategory = self.dataSource[(NSUInteger) indexPath.section].list[(NSUInteger) indexPath.row];
    cell.textLabel.text = subCategory.name;
    return cell;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    FoodParentCategory *foodParentCategory = self.dataSource[(NSUInteger) section];
    return foodParentCategory.name;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

//    RACSignal *signal = [[self.showLoadingSignal concat:[RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
//        [subscriber sendNext:@"1"];
//        [subscriber sendCompleted];
//        return nil;
//    }]] concat:self.hiddenIndeterminateSignal];
//
//
//    [signal subscribeNext:^(id x) {
//        NSLog(@"INFO:%@", x);
//    }];


}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    return [[NSAttributedString alloc] initWithString:@"22"];
}

@end