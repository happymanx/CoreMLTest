//
//  MLSleepViewController.m
//  TestCoreML
//
//  Created by HappyBoy on 20/03/2018.
//  Copyright © 2018 Jason. All rights reserved.
//

#import "MLSleepViewController.h"
#import "DayAxisValueFormatter.h"

@interface MLSleepViewController ()

@end

@implementation MLSleepViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self readFile];
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    model = [[MitBihSleepDbSleepSVC alloc] init];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self computeForInput];
//    [self predict];
}

-(void)readFile
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"slp01aX" ofType:@"txt"];
    NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    threeValuexArr = [[content componentsSeparatedByString:@"\n"] mutableCopy];
}

-(void)predict
{
    NSError *error;
    
    stageArr = [NSMutableArray array];
    for (int i = 0; i < [threeValueArr count]; i++) {
        NSArray *arr = [threeValueArr[i] componentsSeparatedByString:@" "];
//        NSArray *arrx = [threeValuexArr[i] componentsSeparatedByString:@" "];
        if ([arr count] >= 3) {
            MitBihSleepDbSleepSVCOutput *output = [model predictionFromMedian:[arr[0] doubleValue] iqr:[arr[1] doubleValue] mad:[arr[2] doubleValue] error:&error];
            
            [stageArr addObject:@(output.stage)];
            NSLog(@"output.stage[%d]: %lld", i, output.stage);
        }
    }
    NSLog(@"output: %@", stageArr);
    
    [self setupDayChartView];
}

#pragma mark - 繪圖
-(void)setupDayChartView
{
    [self setupBarLineChartView:dayChartView];
    
    dayChartView.delegate = self;
    
    dayChartView.drawBarShadowEnabled = NO;
    dayChartView.drawValueAboveBarEnabled = YES;
    
    dayChartView.maxVisibleCount = 60;
    
    ChartXAxis *xAxis = dayChartView.xAxis;
    xAxis.labelPosition = XAxisLabelPositionBottom;
    xAxis.labelFont = [UIFont systemFontOfSize:0.f];
    xAxis.drawGridLinesEnabled = NO;
    xAxis.granularity = 1.0; // only intervals of 1 day
    xAxis.labelCount = 0;
    xAxis.valueFormatter = [[DayAxisValueFormatter alloc] initForChart:dayChartView];
    
    NSNumberFormatter *leftAxisFormatter = [[NSNumberFormatter alloc] init];
    leftAxisFormatter.minimumFractionDigits = 0;
    leftAxisFormatter.maximumFractionDigits = 1;
    leftAxisFormatter.negativeSuffix = @" $";
    leftAxisFormatter.positiveSuffix = @" $";
    
    ChartYAxis *leftAxis = dayChartView.leftAxis;
    leftAxis.enabled = NO;
    leftAxis.labelFont = [UIFont systemFontOfSize:10.f];
    leftAxis.labelCount = 8;
    leftAxis.valueFormatter = [[ChartDefaultAxisValueFormatter alloc] initWithFormatter:leftAxisFormatter];
    leftAxis.labelPosition = YAxisLabelPositionOutsideChart;
    leftAxis.spaceTop = 0.15;
    leftAxis.axisMinimum = 0.0; // this replaces startAtZero = YES
    
    ChartYAxis *rightAxis = dayChartView.rightAxis;
    rightAxis.enabled = NO;
    rightAxis.drawGridLinesEnabled = NO;
    rightAxis.labelFont = [UIFont systemFontOfSize:10.f];
    rightAxis.labelCount = 4;
    rightAxis.valueFormatter = leftAxis.valueFormatter;
    rightAxis.spaceTop = 0.15;
    rightAxis.axisMinimum = 0.0; // this replaces startAtZero = YES
    
    ChartLegend *l = dayChartView.legend;
    l.horizontalAlignment = ChartLegendHorizontalAlignmentRight;
    l.verticalAlignment = ChartLegendVerticalAlignmentBottom;
    l.orientation = ChartLegendOrientationHorizontal;
    l.drawInside = NO;
    l.form = ChartLegendFormCircle;
    l.formSize = 0.0;
    l.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.f];
    l.xEntrySpace = 4.0;
    
    [self updateDayChartData];
}

// Sleep
#define SDSleepAwakeColor [UIColor colorWithRed:255.0/255 green:153.0/255 blue:0.0/255 alpha:1]
#define SDSleepLightColor [UIColor colorWithRed:0.0/255 green:153.0/255 blue:255.0/255 alpha:1]
#define SDSleepDeepColor [UIColor colorWithRed:153.0/255 green:0.0/255 blue:255.0/255 alpha:1]
#define SDSleepREMColor [UIColor colorWithRed:0.0/255 green:153.0/255 blue:0.0/255 alpha:1]

- (void)updateDayChartData
{
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    
    NSMutableArray <UIColor *> *colorArr = [NSMutableArray array];
    
    for (int i = 0; i < [stageArr count]; i++) {
        NSInteger sleepType = [stageArr[i] integerValue];

        NSInteger value = 0;
        if (sleepType == 0) {// 清醒
            value = 100;
            [colorArr addObject:SDSleepAwakeColor];
        }
        if (sleepType == 1) {// 淺眠
            value = 50;
            [colorArr addObject:SDSleepLightColor];
        }
        if (sleepType == 2) {// 深眠
            value = 25;
            [colorArr addObject:SDSleepDeepColor];
        }
        if (sleepType == 3) {// 眼動期
            value = 75;
            [colorArr addObject:SDSleepREMColor];
        }
        [yVals addObject:[[BarChartDataEntry alloc] initWithX:i y:value]];
    }
    
    BarChartDataSet *set1 = nil;
    if (dayChartView.data.dataSetCount > 0)
    {
        set1 = (BarChartDataSet *)dayChartView.data.dataSets[0];
        set1.values = yVals;
        
        if ([colorArr count] == 0) {
            [colorArr addObject:[UIColor grayColor]];
        }
        [set1 setColors:colorArr];//ChartColorTemplates.material
        set1.drawIconsEnabled = NO;
        
        [dayChartView.data notifyDataChanged];
        [dayChartView notifyDataSetChanged];
    }
    else
    {
        set1 = [[BarChartDataSet alloc] initWithValues:yVals label:@""];
        if ([colorArr count] == 0) {
            [colorArr addObject:[UIColor grayColor]];
        }
        [set1 setColors:colorArr];//ChartColorTemplates.material
        set1.drawIconsEnabled = NO;
        
        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
        [dataSets addObject:set1];
        
        BarChartData *data = [[BarChartData alloc] initWithDataSets:dataSets];
        [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:10.f]];
        
        data.barWidth = 1.f;
        
        dayChartView.data = data;
        
        for (id<IChartDataSet> set in dayChartView.data.dataSets)
        {
            set.drawValuesEnabled = NO;
        }
    }
}

- (void)setupBarLineChartView:(BarLineChartViewBase *)chartView
{
    chartView.chartDescription.enabled = NO;
    
    chartView.drawGridBackgroundEnabled = NO;
    
    chartView.dragEnabled = YES;
    [chartView setScaleEnabled:NO];
    chartView.pinchZoomEnabled = NO;
    
    // ChartYAxis *leftAxis = chartView.leftAxis;
    
    ChartXAxis *xAxis = chartView.xAxis;
    xAxis.labelPosition = XAxisLabelPositionBottom;
    
    chartView.rightAxis.enabled = NO;
}

-(void)computeForInput
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"slp01a" ofType:@"txt"];
    NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    NSArray *dataArr = [content componentsSeparatedByString:@"\n"];
    // 906.0 , 57.0 , 32.8671875 ; 896.0 888.0 904.0 912.0 904.0 892.0 884.0 904.0 888.0 860.0 864.0 852.0 868.0 908.0 948.0 980.0 968.0 956.0 988.0 996.0 980.0 960.0 924.0 936.0 940.0 948.0 944.0 904.0 888.0 896.0 912.0 904.0

    NSMutableArray *rrStrArr = [NSMutableArray array];
    for (int i = 0; i < [dataArr count]; i++) {
        NSString *str = [[dataArr[i] componentsSeparatedByString:@" ; "] lastObject];
        
        [rrStrArr addObject:str];
    }
    
    rr30sDataArr = [rrStrArr copy];
    threeValueArr = [NSMutableArray array];
    for (int i = 0; i < [rr30sDataArr count]; i++) {
        float median = 0;
        float iqr = 0;
        float mad = 0;


        NSMutableArray *rrStrArr = [[rr30sDataArr[i] componentsSeparatedByString:@" "] mutableCopy];
        [rrStrArr removeLastObject];
        // string -> float
        NSMutableArray *rrFloatArr = [NSMutableArray array];
        for (int j = 0; j < [rrStrArr count]; j++) {
            [rrFloatArr addObject:@([rrStrArr[j] floatValue])];
        }
        
        if ([rrFloatArr count] == 0) {
            continue;
        }
        
        // 0. sort
        NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES];

        [rrFloatArr sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];

        NSArray *rrArr = [rrFloatArr copy];
        
        // 1. Median
        if ([rrArr count] % 2 == 1) {// 奇數個
            median = [rrArr[[rrArr count]/2] floatValue];
        }
        else {
            median = ([rrArr[[rrArr count]/2] floatValue] + [rrArr[[rrArr count]/2-1] floatValue])/2;
        }
        
        // 2. Inter-Quartile-Range (IQR)
//        NSMutableArray *lowArr = [NSMutableArray array];
//        NSMutableArray *highArr = [NSMutableArray array];
//        if ([rrArr count] % 2 == 1) {// 奇數個
//            for (int j = 0; j < [rrArr count]/2; j++) {
//                [lowArr addObject:rrArr[j]];
//            }
//            for (int j = (int)[rrArr count]-1; j > [rrArr count]/2; j--) {
//                [highArr addObject:rrArr[j]];
//            }
//
//            float q1;
//            float q3;
//            if ([lowArr count] % 2 == 1) {// 奇數個
//                q1 = [lowArr[[lowArr count]/2] floatValue];
//                q3 = [highArr[[highArr count]/2] floatValue];
//            }
//            else {
//                q1 = ([lowArr[[lowArr count]/2] floatValue] + [lowArr[[lowArr count]/2-1] floatValue])/2;
//                q3 = ([highArr[[highArr count]/2] floatValue] + [highArr[[highArr count]/2-1] floatValue])/2;
//            }
//            iqr = q3 - q1;
//        }
//        else {
//            for (int j = 0; j < [rrArr count]/2; j++) {
//                [lowArr addObject:rrArr[j]];
//            }
//            for (int j = (int)[rrArr count]-1; j >= [rrArr count]/2; j--) {
//                [highArr addObject:rrArr[j]];
//            }
//
//            float q1;
//            float q3;
//            if ([lowArr count] % 2 == 1) {// 奇數個
//                q1 = [lowArr[[lowArr count]/2] floatValue];
//                q3 = [highArr[[highArr count]/2] floatValue];
//            }
//            else {
//                q1 = ([lowArr[[lowArr count]/2] floatValue] + [lowArr[[lowArr count]/2-1] floatValue])/2;
//                q3 = ([highArr[[highArr count]/2] floatValue] + [highArr[[highArr count]/2-1] floatValue])/2;
//            }
//
//            iqr = q3 - q1;
//        }
        // Make a C-array
        int count = (int)[rrFloatArr count];
        double* cArray = (double*)malloc(sizeof(double) * count);
        
        for (int i = 0; i < count; ++i) {
            cArray[i] = [[rrFloatArr objectAtIndex:i] doubleValue];
        }

        iqr = percentile_iqr(cArray, (int)[rrFloatArr count]);
        
        // 3. Mean Absolute Deviation (MAD)
        float sun = 0;
        float average = 0;
        for (int j = 0; j < [rrArr count]; j++) {
            sun += [rrArr[j] floatValue];
        }
        average = sun / [rrArr count];
        
        float sunD = 0;
        float averageD = 0;
        for (int j = 0; j < [rrArr count]; j++) {
            sunD += fabs([rrArr[j] floatValue] - average);
        }
        averageD = sunD / [rrArr count];
        
        mad = averageD;
        
        NSLog(@"median: %f, iqr: %f, mad: %f", median, iqr, mad);
        [threeValueArr addObject:[NSString stringWithFormat:@"%f %f %f", median, iqr, mad]];
    }
    
    [self predict];
}

#pragma mark - C function
double percentile(double input[],int input_size,double percent) {
    double k = (input_size -1) * percent;
    double f = floor(k);
    double c = ceil(k);
    double d0 , d1;
    
    if(f == c) {
        return (double)input[(int)k];
    }
    
    d0 = input[(int)f] * (c-k);
    d1 = input[(int)c] * (k-f);
    
    return (d0+d1);
}

double percentile_iqr(double input[],int input_size) {
    double q3 = percentile(input,input_size,0.75);
    double q1 = percentile(input,input_size,0.25);
    
    return (q3-q1);
}

@end
