//
//  PictureDisplayView.m
//  PicturesDisplayView
//
//  Created by apple on 16/6/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "PictureDisplayView.h"
#import "SmallCollectionViewDD.h"
#import "SmallCollectionViewCell.h"
#import "UIImage+Tool.h"


#define bigHeightScale  0.8

@interface PictureDisplayView ()<UICollectionViewDataSource,UICollectionViewDelegate>

/* 展示大图片的collectionView */
@property (nonatomic,weak) UICollectionView *bigPictureCollectionView;
/** 大图片的布局 */
@property (nonatomic, strong) UICollectionViewFlowLayout *bigPictureFlowLayout;


/* 展示小图片的collectionView */
@property (nonatomic,weak) UICollectionView *smallPictureCollectionView;
/** 小图片的布局 */
@property (nonatomic, strong) UICollectionViewFlowLayout *smallPictureFlowLayout;
/** 小图片的collectionView的数据源和代理 */
@property (nonatomic, strong) SmallCollectionViewDD *SmallCollectionViewDD;


/** 经过修改后的大图片 */
@property (nonatomic, strong) NSArray *bigPictures;

@end


@implementation PictureDisplayView

static NSString * bigCellID = @"bigCell";
static NSString * smallCellID = @"smallCell";

#pragma mark - 懒加载
/** bigPictureCollectionView懒加载 */
- (UICollectionView *)bigPictureCollectionView{
    if (!_bigPictureCollectionView) {
        UICollectionView *bigPictureCollectionView = [[UICollectionView  alloc]  initWithFrame:[self  bigCollectionViewRect] collectionViewLayout:self.bigPictureFlowLayout];
        self.bigPictureCollectionView = bigPictureCollectionView;
        self.bigPictureCollectionView.dataSource = self;
        self.bigPictureCollectionView.delegate = self;
        self.bigPictureCollectionView.backgroundColor = [UIColor redColor];
        //不可滚动
        self.bigPictureCollectionView.scrollEnabled = NO;
    }
    return _bigPictureCollectionView;
}
/** smallPictureCollectionView懒加载 */
- (UICollectionView *)smallPictureCollectionView{
    if (!_smallPictureCollectionView) {
        
        UICollectionView *smallPictureCollectionView = [[UICollectionView  alloc]  initWithFrame:[self  smallCollectionViewRect] collectionViewLayout:self.smallPictureFlowLayout];
        self.smallPictureCollectionView = smallPictureCollectionView;
        self.SmallCollectionViewDD  = [[SmallCollectionViewDD  alloc]  init];
        self.smallPictureCollectionView.dataSource = self.SmallCollectionViewDD ;
        self.smallPictureCollectionView.delegate = self.SmallCollectionViewDD ;
        self.smallPictureCollectionView.backgroundColor = [UIColor  whiteColor];
        self.smallPictureCollectionView.showsHorizontalScrollIndicator = NO;
    }
    return _smallPictureCollectionView;
}

/** bigPictureFlowLayout懒加载 */
- (UICollectionViewFlowLayout *)bigPictureFlowLayout{
    if (!_bigPictureFlowLayout) {
        self.bigPictureFlowLayout = [[UICollectionViewFlowLayout   alloc]  init];
        //设置布局的属性
        _bigPictureFlowLayout.itemSize = [self  bigCollectionViewRect].size;
        _bigPictureFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _bigPictureFlowLayout;
}

/** smallPictureFlowLayout懒加载 */
- (UICollectionViewFlowLayout *)smallPictureFlowLayout{
    if (!_smallPictureFlowLayout) {
        self.smallPictureFlowLayout = [[UICollectionViewFlowLayout   alloc]  init];
        //设置布局的属性
        CGRect smallPictureGect = [self  smallCollectionViewRect];
        CGFloat height = smallPictureGect.size.height;
        _smallPictureFlowLayout.itemSize = CGSizeMake(height, height);
        _smallPictureFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _smallPictureFlowLayout;
}


#pragma mark - 初始化方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //NSLog(@"%@",NSStringFromCGRect(frame));
        
        //1.注册通知
        [[NSNotificationCenter  defaultCenter]  addObserver:self selector:@selector(smallCollectionViewClick:) name:smallCollectionViewClickNotification object:nil];
        //2.添加控件
        [self   setUp];
    }
    return self;
}

#pragma mark  监听smallCollectionView点击的方法
- (void)smallCollectionViewClick:(NSNotification *)notification{

    NSIndexPath * indexPath = notification.userInfo[@"indexPath"];
    //改变bigPictureCollectionView中的图片.
    [self.bigPictureCollectionView  scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];

}
- (void)setUp{
    
    //1.添加控件.
    [self  addSubview:self.bigPictureCollectionView];
    [self  addSubview:self.smallPictureCollectionView];
    
    //2.注册cell
    //collectionView的cell好像只能先注册再从缓存池中获取.
    //由于bigPictureCollectionView的cell与smallPictureCollectionView的cell相似直接使用smallPictureCollectionView的cell
    [self.bigPictureCollectionView  registerNib:[UINib  nibWithNibName:NSStringFromClass([SmallCollectionViewCell  class]) bundle:nil] forCellWithReuseIdentifier:bigCellID];
    [self.smallPictureCollectionView registerNib:[UINib  nibWithNibName:NSStringFromClass([SmallCollectionViewCell  class]) bundle:nil] forCellWithReuseIdentifier:smallCellID];

}
- (CGRect)bigCollectionViewRect{
    
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    CGRect bigRect = CGRectMake(0, 0, width, height * bigHeightScale);
    return bigRect;
}
- (CGRect)smallCollectionViewRect{
    
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    CGRect smallRect = CGRectMake(0, height*bigHeightScale, width, height*(1-bigHeightScale));
    return smallRect;
}

- (NSArray *)smallpictureFromArray:(NSArray *)pictures{

    NSMutableArray *smallPictures = [NSMutableArray arrayWithCapacity:pictures.count];
    CGSize smallCollectionSize = [self smallCollectionViewRect].size;
    CGSize definedSize = CGSizeMake(smallCollectionSize.height, smallCollectionSize.height);
    
    for (int i=0; i<pictures.count; i++) {
        UIImage *image = pictures[i];
        UIImage *newImage = [UIImage  imageFromOldImage:image withDefinedSize:definedSize];
        [smallPictures  addObject:newImage];
    }

    return smallPictures;
}
- (NSArray *)bigPictureFromArray:(NSArray *)pictures{
    
    NSMutableArray *bigPictures = [NSMutableArray arrayWithCapacity:pictures.count];
    CGSize definedSize = [self bigCollectionViewRect].size;
    
    for (int i=0; i<pictures.count; i++) {
        UIImage *image = pictures[i];
        UIImage *newImage = [UIImage  imageFromOldImage:image withDefinedSize:definedSize];
        [bigPictures  addObject:newImage];
    }
    
    return bigPictures;
}


#pragma mark - 重写setter方法
- (void)setPictures:(NSArray *)pictures{

    _pictures = pictures;
    
    //获取修改后的大图片
    self.bigPictures = [self  bigPictureFromArray:pictures];
    
    //获取小图片
    NSArray *smallPictures = [self  smallpictureFromArray:pictures];
    self.SmallCollectionViewDD.smallPictures = smallPictures;
    
    [self.smallPictureCollectionView  reloadData];
}

#pragma mark - UICollectionViewDataSource,UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.bigPictures.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    SmallCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:bigCellID forIndexPath:indexPath];
    //取出数据
    UIImage *image = self.bigPictures[indexPath.item];
    cell.image = image;
    cell.backgroundColor = [UIColor  whiteColor];
    return  cell;
}


@end
