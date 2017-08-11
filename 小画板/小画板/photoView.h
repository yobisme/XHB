//
//  photoView.h
//  小画板
//
//  Created by Macx on 2017/4/9.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class photoView;

typedef void(^Block)(UIImage *);

//@protocol  photoViewDelegate<NSObject>

//- (void)photoView:(photoView *)photoView andImage:(UIImage *)image;

//@end

@interface photoView : UIView

@property (nonatomic,strong)UIImage *image;

@property (nonatomic,copy)Block imageBlock;

//@property (nonatomic,weak)id <photoViewDelegate>delegate;
@end
