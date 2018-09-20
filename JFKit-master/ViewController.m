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
#import "CPApiError.h"

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
    self.tableView.rac_refreshCommand = self.viewModel.refreshCommand;
    [self.tableView.rac_refreshCommand.errors subscribeNext:self.dealError];
    RAC(self, dataSource) = [RACObserve(self.viewModel, dataSource) skip:1];
}

- (void)setupTableView {
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:cellId];
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

}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    return [[NSAttributedString alloc] initWithString:@"22"];
}

@end