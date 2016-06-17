//
//  SmallCollectionViewCell.m
//  PicturesDisplayView
//
//  Created by apple on 16/6/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SmallCollectionViewCell.h"


@interface SmallCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation SmallCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setImage:(UIImage *)image{

    _image = image;
    self.imageView.image = image;

}


@end
