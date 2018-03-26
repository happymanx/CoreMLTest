//
//  MLSleepViewController.h
//  TestCoreML
//
//  Created by HappyBoy on 20/03/2018.
//  Copyright © 2018 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MitBihSleepDbSleepSVC.h"
#import "SDChartBaseViewController.h"

@interface MLSleepViewController : SDChartBaseViewController
{
    MitBihSleepDbSleepSVC *model;

    NSArray *rr30sDataArr;
    NSMutableArray *threeValueArr;
    NSMutableArray *threeValuexArr;
    NSMutableArray *stageArr;
    
    IBOutlet BarChartView *dayChartView;
}

@end
