//
//  MLMainViewController.h
//  TestCoreML
//
//  Created by HappyBoy on 19/03/2018.
//  Copyright © 2018 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Inceptionv3.h"
#import "GoogLeNetPlaces.h"
#import "TOCropViewController.h"

@interface MLMainViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, TOCropViewControllerDelegate>
{
    Inceptionv3 *model;
    GoogLeNetPlaces *googLeNetPlacesModel;

    IBOutlet UIImageView *photoImageView;
    IBOutlet UILabel *statementLabel;
}

@end
