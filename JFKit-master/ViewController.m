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
#import "FoodCategory.h"
#import "VMHome.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, weak) IBOutlet UITableView *tableView;
@property(nonatomic, copy) NSArray<FoodParentCategory *> *dataSource;
@property(nonatomic, strong) VMHome *viewMode;
@property(nonatomic, strong) RACSignal<CPApiResponse<NSArray<FoodParentCategory *> *> *> *signal;
@end

@implementation ViewController
static NSString *cellId = @"cellId";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:cellId];
    self.viewMode = [[VMHome alloc] init];
    self.signal = self.viewMode.categoryApi.signal;
    @weakify(self);
    [self.signal subscribeNext:^(CPApiResponse<NSArray<FoodParentCategory *> *> *x) {
        self.dataSource = x.result;
        [self.tableView reloadData];
    }];
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

@end