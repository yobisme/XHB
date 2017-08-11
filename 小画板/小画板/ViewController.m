//
//  ViewController.m
//  小画板
//
//  Created by Macx on 2017/4/8.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "ViewController.h"
#import "photoView.h"
#import "drawView.h"

@interface ViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet drawView *drawView;

@property (nonatomic,weak)photoView *photoView;

@end

@implementation ViewController


//清屏
- (IBAction)clear:(UIBarButtonItem *)sender
{
    [_drawView clear];
}
//撤销
- (IBAction)cancel:(UIBarButtonItem *)sender {
    [_drawView cancel];
}

//橡皮
- (IBAction)rubber:(UIBarButtonItem *)sender
{
    [_drawView rubber];
}

//相册
- (IBAction)photo:(UIBarButtonItem *)sender {
    
    [_drawView photo];
}

//保存
- (IBAction)save:(UIBarButtonItem *)sender {
    
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    picker.delegate = self;
    
    [self presentViewController:picker animated:YES completion:nil];

}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    //NSLog(@"%@",info);
    
    UIImage *selimage = info[UIImagePickerControllerOriginalImage];
    
    photoView *view = [[photoView alloc] initWithFrame:_drawView.frame];
    
    //view.delegate = self;
    
    view.image = selimage;
    
    _photoView = view;
    
    
    view.imageBlock = ^(UIImage *image){
        
        _drawView.image = image;

        [_photoView removeFromSuperview];
        
    };
    
    
    [self.view addSubview:view];
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}


//- (void)photoView:(photoView *)photoView andImage:(UIImage *)image
//{
//    //_drawView.image = image;
//    
//    
//    [photoView removeFromSuperview];
//    
//    
//}

//slider控件,有个value属性
- (IBAction)slider:(UISlider *)sender
{
    
    _drawView.value = sender.value;
}

//五个颜色按钮
- (IBAction)colorButton:(UIButton *)sender {
    
    _drawView.lineColor = sender.backgroundColor;
}

@end
