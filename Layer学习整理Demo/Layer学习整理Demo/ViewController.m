//
//  ViewController.m
//  Layer学习整理Demo
//
//  Created by baiqiang on 15/11/24.
//  Copyright © 2015年 baiqiang. All rights reserved.
//
static NSString * const kLayerViewTableCell = @"ViewControllerCell";

#import "ViewController.h"
#import "LayerVc.h"


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *dataSource;


@end

@implementation ViewController
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self initUI];
}
#pragma  mark - 私有方法
- (void)initData {
    [self dataSource];
}

- (void)initUI {
    [self.view addSubview:self.tableView];
}

#pragma mark - tableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLayerViewTableCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kLayerViewTableCell];
        cell.textLabel.font = [UIFont systemFontOfSize:16];
    }
    NSDictionary *dic = self.dataSource[indexPath.row];
    cell.textLabel.text = [[dic allValues] lastObject];
    return cell;
}
#pragma mark - tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [self.dic enumerateKeysAndObjectsUsingBlock:^(NSString *  _Nonnull key, NSString *  _Nonnull obj, BOOL * _Nonnull stop) {
//        if ([self.dataSource[indexPath.row] isEqualToString:obj]) {
//            className = key;
//            *stop = YES;
//        }
//    }];
    NSDictionary *dic = self.dataSource[indexPath.row];
    NSString *className = [[dic allKeys] lastObject];
    Class class = NSClassFromString(className);
    UIViewController *vc = [[class alloc] init];
    vc.title = [[dic allValues] lastObject];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - get Method
- (UITableView *)tableView {
    if (_tableView == nil) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height - 64) style:UITableViewStylePlain];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.tableFooterView = [UIView new];
        _tableView = tableView;
    }
    return _tableView;
}
-(NSArray *)dataSource {
    if (_dataSource == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"dataSource" ofType:@"plist"];
        _dataSource = [NSArray arrayWithContentsOfFile:path];
    }
    return _dataSource;
}
@end
