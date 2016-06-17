//
//  SmallCollectionViewDD.m
//  PicturesDisplayView
//
//  Created by apple on 16/6/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SmallCollectionViewDD.h"
#import "SmallCollectionViewCell.h"


//@interface SmallCollectionViewDD ()
//
//@end

@implementation SmallCollectionViewDD

static NSString * smallCellID = @"smallCell";

NSString * const smallCollectionViewClickNotification = @"smallCollectionViewClickNotification";

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.smallPictures.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SmallCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:smallCellID forIndexPath:indexPath];
    //取出数据
    UIImage *image = self.smallPictures[indexPath.item];
    cell.image = image;
    cell.backgroundColor = [UIColor lightGrayColor];
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //NSLog(@"%ld被点击",indexPath.item);
    //发送通知改变bigCollectionView里的图片
    [[NSNotificationCenter  defaultCenter] postNotificationName:smallCollectionViewClickNotification object:self userInfo:@{@"indexPath":indexPath}];

}


@end
