//
//  ImageCacheViewController.m
//  Layer学习整理Demo
//
//  Created by baiqiang on 15/11/27.
//  Copyright © 2015年 baiqiang. All rights reserved.
//

#import "ImageCacheViewController.h"
#import "BQCollectionViewCell.h"

@interface ImageCacheViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *context;
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation ImageCacheViewController

#pragma mark - 类方法

#pragma mark - 创建方法

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initUI];
    
}
#pragma mark - 实例方法
- (void)initData{
    self.dataSource = [[NSBundle mainBundle] pathsForResourcesOfType:@"jpg" inDirectory:nil];
}

- (void)initUI{
    self.automaticallyAdjustsScrollViewInsets = YES;
    [self.view addSubview:self.context];
}
#pragma mark - collectionView DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BQCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BQCollectionViewCell" forIndexPath:indexPath];
    //set or load image ofr this index
    cell.imageView.image = [self loadImageAtIndex:indexPath.item];
    if (indexPath.item < self.dataSource.count - 1) {
        [self loadImageAtIndex:indexPath.item + 1];
    }
    if (indexPath.item > 0) {
        [self loadImageAtIndex:indexPath.item - 1];
    }
    return cell;
}
#pragma mark - 事件响应方法

#pragma mark - Method
- (UIImage *)loadImageAtIndex:(NSUInteger)index {
    static NSCache *cache;
    //若没有缓存，则创建缓存
    if (cache == nil) {
        cache = [[NSCache alloc] init];
        //缓存内容个数为3
        cache.countLimit = 3;
    }
    //获取缓存中的图片对象
    UIImage *image = [cache objectForKey:@(index)];
    //图片对象为空时返回空
    if (image != nil) {
        return [image isKindOfClass:[NSNull class]] ? nil : image;
    }
    //设置一个空对象，图像太多应该设置站位图
    [cache setObject:[NSNull null] forKey:@(index)];
    //异步加载图片对象
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *image = [UIImage imageWithContentsOfFile:self.dataSource[index]];
        //强制渲染图片,提升图片渲染效率
        UIGraphicsBeginImageContextWithOptions(image.size, YES, 0);
        [image drawAtPoint:CGPointZero];
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        [cache setObject:image forKey:@(index)];
        dispatch_async(dispatch_get_main_queue(), ^{
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
            BQCollectionViewCell *cell = (BQCollectionViewCell *)[self.context cellForItemAtIndexPath:indexPath];
            cell.imageView.image = image;
        });
    });
    return nil;
}


#pragma mark - get方法
- (UICollectionView *)context {
    if (_context == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        _context = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenWidth) collectionViewLayout:layout];
        layout.itemSize = CGSizeMake(_context.width, _context.height - 64);
        _context.backgroundColor = [UIColor whiteColor];
        _context.center = self.view.center;
        [_context registerClass:[BQCollectionViewCell class] forCellWithReuseIdentifier:@"BQCollectionViewCell"];
        _context.dataSource = self;
    }
    return _context;
}
@end
