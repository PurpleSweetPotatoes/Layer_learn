//
//  LayerSubclassesViewController.m
//  Layer学习整理Demo
//
//  Created by baiqiang on 15/11/24.
//  Copyright © 2015年 baiqiang. All rights reserved.
//


#import "LayerSubclassesViewController.h"

static NSString * const kLayerSubClassId = @"kLayerSubClassId";

@interface LayerSubclassesViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation LayerSubclassesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self initUI];
}
- (void)initData {
    self.dataSource = @[@"CAShapeLayer",
                        @"CATextLayer",
                        @"CATransformLayer",
                        @"CAGradientLayer",
                        @"CARelicatorLayer",
                        @"CAEmitterLayer",
                        @"CAEAGLLayer"
                        ];
}
- (void)initUI {
    [self.view addSubview:self.tableView];
}
#pragma mark - tableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLayerSubClassId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kLayerSubClassId];
        cell.textLabel.font = [UIFont systemFontOfSize:16];
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}
#pragma mark - tableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *string = self.dataSource[indexPath.row];
    NSString *className = [string stringByAppendingString:@"ViewController"];
    Class class = NSClassFromString(className);
    UIViewController *vc = [[class alloc] init];
    vc.title = string;
    [self.navigationController pushViewController:vc animated:YES];
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.tableFooterView = [UIView new];
        _tableView = tableView;
    }
    return _tableView;
}



@end
