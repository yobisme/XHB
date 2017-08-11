//
//  photoView.m
//  小画板
//
//  Created by Macx on 2017/4/9.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "photoView.h"


@interface photoView ()<UIGestureRecognizerDelegate>

@property (nonatomic,weak) UIImageView *imageView;

@end

@implementation photoView



- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setupUI];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    
    UIImageView *imageView = [[UIImageView alloc] init];
    
    _imageView = imageView;
    
    [self addSubview:imageView];
  
}
- (void)setImage:(UIImage *)image
{
    _image = image;
    
    _imageView.userInteractionEnabled = YES;
    
    _imageView.image = image;
    
    _imageView.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    
    _imageView.bounds = CGRectMake(0, 0, image.size.width, image.size.height);
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    
    [_imageView addGestureRecognizer:pan];
    
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
    
    pinch.delegate = self;
    
    [_imageView addGestureRecognizer:pinch];
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    
    [_imageView addGestureRecognizer:longPress];
    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotation:)];
    
    [_imageView addGestureRecognizer:rotation];
  
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

//拖拽
- (void)pan:(UIPanGestureRecognizer *)pan
{
    CGPoint point = [pan translationInView:pan.view];
    
    _imageView.transform = CGAffineTransformTranslate(_imageView.transform, point.x, point.y);
    
    [pan setTranslation:CGPointZero inView:pan.view];
}

//捏合
- (void)pinch:(UIPinchGestureRecognizer *)pinch
{
    pinch.view.transform = CGAffineTransformScale(pinch.view.transform, pinch.scale, pinch.scale);
    
    pinch.scale = 1;
}

//长按
- (void)longPress:(UILongPressGestureRecognizer *)longPress
{
    if (longPress.state == UIGestureRecognizerStateBegan) {
        
        
        [UIView animateWithDuration:0.5 animations:^{
          
            longPress.view.alpha = 0.5;
            
        } completion:^(BOOL finished) {
        
            [UIView animateWithDuration:0.5 animations:^{
               
                longPress.view.alpha = 1;
                
            } completion:^(BOOL finished) {
                
                UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0);
                
                CGContextRef ref = UIGraphicsGetCurrentContext();
                
                
                //将当前layer渲染到图片上下文中
                [self.layer renderInContext:ref];
                
                
                UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
                
                
                
//                
//                if ([self.delegate respondsToSelector:@selector(photoView:andImage:)])
//                {
//                    [self.delegate photoView:self andImage:image];
//                }
                
                
                if (_imageBlock)
                {
                    _imageBlock(image);
                }
                
                
                UIGraphicsEndImageContext();
                
            }];
            
            
        }];
        
    }else{
        
    }
    
    
    
}
//旋转
- (void)rotation:(UIRotationGestureRecognizer *)rotation
{
    rotation.view.transform = CGAffineTransformRotate(rotation.view.transform, rotation.rotation);
    
    rotation.rotation = 0;
}
@end
