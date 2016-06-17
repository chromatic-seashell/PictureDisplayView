//
//  SmallCollectionViewDD.h
//  PicturesDisplayView
//
//  Created by apple on 16/6/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface SmallCollectionViewDD : NSObject <UICollectionViewDataSource,UICollectionViewDelegate>

UIKIT_EXTERN NSString * const smallCollectionViewClickNotification;
/** 图片 */
@property (nonatomic, strong) NSArray *smallPictures;

@end
