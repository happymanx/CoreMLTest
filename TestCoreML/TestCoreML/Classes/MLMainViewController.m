//
//  MLMainViewController.m
//  TestCoreML
//
//  Created by HappyBoy on 19/03/2018.
//  Copyright © 2018 Jason. All rights reserved.
//

#import "MLMainViewController.h"
#import <CoreML/CoreML.h>
#import "MLCommon.h"
#import <AVFoundation/AVFoundation.h>

@interface MLMainViewController ()

@end

@implementation MLMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    model = [[Inceptionv3 alloc] init];
    googLeNetPlacesModel = [[GoogLeNetPlaces alloc] init];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self predictPhoto:[self imageResize:photoImageView.image toSize:CGSizeMake(224, 224)]];
}

-(IBAction)photoImageButtonClicked:(UIButton *)button
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"選擇", @"")
                                                                   message:@""
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"相機", @"")
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action) {
                                                             AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
                                                             switch (authStatus) {
                                                                 case AVAuthorizationStatusAuthorized:
                                                                     
                                                                     break;
                                                                 case AVAuthorizationStatusDenied:
                                                                 case AVAuthorizationStatusRestricted:
                                                                 case AVAuthorizationStatusNotDetermined: {
                                                                     //                                            UIAlertView *alertView = [UIAlertView bk_alertViewWithTitle:@"請到設定開啟相機權限"];
                                                                     //                                            [alertView bk_addButtonWithTitle:@"好" handler:nil];
                                                                     //
                                                                     //                                            [alertView show];
                                                                     //                                            return;
                                                                 } break;
                                                                     
                                                                 default:
                                                                     break;
                                                             }
                                                             
                                                             UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
                                                             pickerController.delegate = self;
                                                             pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                                                             
                                                             [self.navigationController presentViewController:pickerController animated:YES completion:nil];
                                                             
                                                         }];
    [alert addAction:cameraAction];
    
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"相簿", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
        pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        pickerController.delegate = self;
        
        [self.navigationController presentViewController:pickerController animated:YES completion:nil];
    }];
    [alert addAction:photoAction];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"取消", @"") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:cancelAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [self.navigationController dismissViewControllerAnimated:picker completion:^{
        UIImage *chosenImage = info[UIImagePickerControllerEditedImage];// 使用相機
        if(!chosenImage) {// 選擇相片
            chosenImage = (UIImage *) [info objectForKey:UIImagePickerControllerOriginalImage];
        }
        
        TOCropViewController *cropViewController = [[TOCropViewController alloc] initWithImage:chosenImage];
        cropViewController.aspectRatioPreset = TOCropViewControllerAspectRatioPresetSquare;
        cropViewController.delegate = self;
        [self presentViewController:cropViewController animated:YES completion:nil];
        
    }];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.navigationController dismissViewControllerAnimated:picker completion:^{
        
    }];
}

#pragma mark - TOCropViewControllerDelegate
-(void)cropViewController:(TOCropViewController *)cropViewController didCropToImage:(UIImage *)image withRect:(CGRect)cropRect angle:(NSInteger)angle
{
    UIImage *newImage = [self imageResize:image toSize:CGSizeMake(224, 224)];
    [self.navigationController dismissViewControllerAnimated:cropViewController completion:^{
        [photoImageView setImage:image];
        
        [self predictPhoto:newImage];;
    }];
}

-(void)cropViewController:(TOCropViewController *)cropViewController didFinishCancelled:(BOOL)cancelled
{
    [self.navigationController dismissViewControllerAnimated:cropViewController completion:nil];
}

- (UIImage *)imageResize:(UIImage*)img toSize:(CGSize)newSize
{// 縮放影像
//    CGFloat scale = [[UIScreen mainScreen] scale];
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 1);
    [img drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

//-(void)predictPhoto:(UIImage *)image
//{
//    NSError *error;
//    CVPixelBufferRef pixelbuffer = [self pixelBufferFromCGImage:image.CGImage];
//    Inceptionv3Output *output = [model predictionFromImage:pixelbuffer error:&error];
//
//    NSString *outputStr = [NSString stringWithFormat:@"結果：%@", output.classLabel];
//    statementLabel.text = outputStr;
//    NSLog(@"output: %@", output.classLabel);
//    NSLog(@"output detail: %@", output.classLabelProbs);
//}

-(void)predictPhoto:(UIImage *)image
{
    NSError *error;
    CVPixelBufferRef pixelbuffer = [self pixelBufferFromCGImage:image.CGImage];
    GoogLeNetPlacesOutput *output = [googLeNetPlacesModel predictionFromSceneImage:pixelbuffer error:&error];
    
    NSString *outputStr = [NSString stringWithFormat:@"結果：%@", output.sceneLabel];
    statementLabel.text = outputStr;
    NSLog(@"output: %@", output.sceneLabel);
    NSLog(@"output detail: %@", output.sceneLabelProbs);
}

-(CVPixelBufferRef)pixelBufferFromCGImage:(CGImageRef)image{
    
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithBool:YES], kCVPixelBufferCGImageCompatibilityKey,
                             [NSNumber numberWithBool:YES], kCVPixelBufferCGBitmapContextCompatibilityKey, nil];
    CVPixelBufferRef pxbuffer = NULL;
    CVReturn status = CVPixelBufferCreate(kCFAllocatorDefault, CGImageGetWidth(image), CGImageGetHeight(image),
                                          kCVPixelFormatType_32ARGB, (__bridge CFDictionaryRef)options, &pxbuffer);
    NSParameterAssert(status == kCVReturnSuccess && pxbuffer != NULL);
    
    CVPixelBufferLockBaseAddress(pxbuffer, 0);
    void *pxdata = CVPixelBufferGetBaseAddress(pxbuffer);
    NSParameterAssert(pxdata != NULL);
    
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(pxdata, CGImageGetWidth(image), CGImageGetHeight(image), 8, 4*CGImageGetWidth(image), rgbColorSpace, kCGImageAlphaNoneSkipFirst);
    NSParameterAssert(context);
    CGContextConcatCTM(context, CGAffineTransformIdentity);
    CGContextDrawImage(context, CGRectMake(0, 0, CGImageGetWidth(image), CGImageGetHeight(image)), image);
    CGColorSpaceRelease(rgbColorSpace);
    CGContextRelease(context);
    CVPixelBufferUnlockBaseAddress(pxbuffer, 0);
    
    return pxbuffer;
}

@end
