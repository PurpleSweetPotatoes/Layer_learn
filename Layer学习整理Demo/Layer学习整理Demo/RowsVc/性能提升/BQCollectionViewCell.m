//
//  BQCollectionViewCell.m
//  14.2缓存NSCache
//
//  Created by baiqiang on 15/11/20.
//  Copyright © 2015年 baiqiang. All rights reserved.
//

#import "BQCollectionViewCell.h"

@interface BQCollectionViewCell ()

@end

@implementation BQCollectionViewCell
- (UIImageView *)imageView{
    if (_imageView == nil) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self.contentView addSubview:imageView];
        _imageView = imageView;
    }
    return _imageView;
}
@end
