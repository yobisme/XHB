//
//  drawView.h
//  小画板
//
//  Created by Macx on 2017/4/8.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface drawView : UIView

@property (nonatomic,assign)CGFloat value;

- (void)cancel;

- (void)clear;

- (void)rubber;

- (void)photo;

- (void)save;

@property (nonatomic,strong)UIColor *lineColor;

@property (nonatomic,strong) UIImage *image;
@end
