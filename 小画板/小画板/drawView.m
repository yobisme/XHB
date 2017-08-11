//
//  drawView.m
//  小画板
//
//  Created by Macx on 2017/4/8.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "drawView.h"
#import "DrawBezierPath.h"
@interface drawView ()

@property(nonatomic,strong) DrawBezierPath *bezeierPath;

@property(nonatomic,strong) NSMutableArray *drawArrM;

//@property(nonatomic,strong) NSMutableArray *colorArrM;

@end

#define kFilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"aa.png"]

@implementation drawView

- (NSMutableArray *)drawArrM
{

        if (nil == _drawArrM) {
            
            _drawArrM = [NSMutableArray array];
        }

    return _drawArrM;
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = touches.anyObject;
    
    CGPoint movePoint = [touch locationInView:touch.view];
    
    DrawBezierPath *bezierPath = [DrawBezierPath bezierPath];
    
    //路径的起点
    [self.drawArrM addObject:bezierPath];
    
    //线宽,初始值为0,要改值
    bezierPath.lineWidth = (self.value == 0 ? 1 : self.value);
    
    //线条颜色
    bezierPath.lineColor = self.lineColor;

    [bezierPath moveToPoint:movePoint];
    
    _bezeierPath = bezierPath;
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = touches.anyObject;
    
    CGPoint addPoint = [touch locationInView:touch.view];
    
    [_bezeierPath addLineToPoint:addPoint];
    
    //重绘
    [self setNeedsDisplay];
    
}


- (void)drawRect:(CGRect)rect
{
    
    for (int  i = 0; i < self.drawArrM.count; i++)
    {
        DrawBezierPath *path = self.drawArrM[i];
        
        if (path.image)
        {
            [path.image drawInRect:rect];
            
        }else{
        
            [path.lineColor setStroke];
            
            [path stroke];
        }
    }
}

//撤销
- (void)cancel
{
    [self.drawArrM removeLastObject];
    
    [self setNeedsDisplay];

}
//清屏
- (void)clear
{
    [self.drawArrM removeAllObjects];
    
    [self setNeedsDisplay];
}

//橡皮
- (void)rubber
{
    self.lineColor = self.backgroundColor;
    
}

//相册
- (void)photo
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0);
    
    CGContextRef ref = UIGraphicsGetCurrentContext();
    
    CGContextAddRect(ref, self.frame);
    
    CGContextStrokePath(ref);
    
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:NO];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    
}


- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSLog(@".....");
    
    NSLog(@"%@",error);
}


//保存
- (void)save
{

    NSString *path = kFilePath;
    
    [NSKeyedArchiver archiveRootObject:self.drawArrM toFile:path];
    
}


- (void)setImage:(UIImage *)image
{
    _image = image;
    
    DrawBezierPath *bezierpath = [DrawBezierPath bezierPath];
    
    bezierpath.image = image ;
    
    [self.drawArrM addObject:bezierpath];
    
    [self setNeedsDisplay];
}
@end
