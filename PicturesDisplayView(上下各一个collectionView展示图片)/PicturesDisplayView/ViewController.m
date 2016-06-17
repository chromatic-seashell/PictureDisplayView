//
//  ViewController.m
//  PicturesDisplayView
//
//  Created by apple on 16/6/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ViewController.h"
#import "PictureDisplayView.h"

@interface ViewController ()

/** 图片 */
@property (nonatomic, strong) NSArray *pictures;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor  lightGrayColor];
    //1.图片数据
    NSMutableArray *pictures = [NSMutableArray   array];
    for (int i = 1; i<=8; i++) {
        NSString *str = [NSString  stringWithFormat:@"%02d.jpg",i];
        UIImage *image = [UIImage  imageNamed:str];
        [pictures addObject:image];
    }
    self.pictures = pictures;
    
    //2.创建控件
    CGFloat width = self.view.frame.size.width;
    PictureDisplayView *pictureDisplayView = [[PictureDisplayView  alloc]  initWithFrame:CGRectMake(0, 100, width, 400)];
    //赋值数据
    pictureDisplayView.pictures = self.pictures;
    [self.view  addSubview:pictureDisplayView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
