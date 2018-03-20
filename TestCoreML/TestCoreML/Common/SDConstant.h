//
//  SDConstant.h
//  SmartDevice
//
//  Created by HappyBoy on 14/08/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

#ifndef SD_CONSTANT

#ifdef DEBUG
#   define DXLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DXLog(...) nil
#   define NSLog(FORMAT, ...) nil
#endif
// ALog always displays output regardless of the DEBUG setting
#define AXLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define DocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]

static NSInteger const SDApiResponseCode400 = 400;
static NSString const *SDAppVersion = @"1.0";
static NSString const *SDAppDownloadURL = @"https://itunes.apple.com/us/app/%E8%8A%AF%E5%8B%95%E5%81%A5%E5%BA%B7/id1317204313?ls=1&mt=8";
static NSString *SDDateAndTimeFormat = @"YYYY-MM-dd HH:mm";
static NSString *SDDateAndTimesFormat = @"YYYY-MM-dd HH:mm:ss";
static NSString *SDDateFormat = @"YYYY-MM-dd";
static NSString *SDTimeFormat = @"HH:mm";

// Notification Key
static NSString *const SDNotificationKeySportDataSyncComplete = @"SDNotificationKeySportDataSyncComplete";
static NSString *const SDNotificationKeyTodaySportDataSyncComplete = @"SDNotificationKeyTodaySportDataSyncComplete";
static NSString *const SDNotificationKeyInstantSportDataSyncComplete = @"SDNotificationKeyInstantSportDataSyncComplete";
static NSString *const SDNotificationKeySleepDataSyncComplete = @"SDNotificationKeySleepDataSyncComplete";
static NSString *const SDNotificationKeyBloodDataSyncComplete = @"SDNotificationKeyBloodDataSyncComplete";
static NSString *const SDNotificationKeyPPGDataSyncComplete = @"SDNotificationKeyPPGDataSyncComplete";
static NSString *const SDNotificationKeyECGDataSyncComplete = @"SDNotificationKeyECGDataSyncComplete";
static NSString *const SDNotificationKeyBluetoothStatusConnect = @"SDNotificationKeyBluetoothStatusConnect";
static NSString *const SDNotificationKeyBluetoothStatusDisconnect = @"SDNotificationKeyBluetoothStatusDisconnect";
// Local Notification
static NSString *const SDNotificationKeyID = @"SDNotificationKeyID";
static NSString *const SDNotificationKeyRemind = @"SDNotificationKeyRemind";

//#DF1119
#define SDMainColor [UIColor colorWithRed:223.0/255 green:17.0/255 blue:25.0/255 alpha:1]
//#F8F8F8
#define SDNavBgColor [UIColor colorWithRed:247.0/255 green:247.0/255 blue:247.0/255 alpha:1]
//#F6F6F6
#define SDBgColor [UIColor colorWithRed:245.0/255 green:245.0/255 blue:245.0/255 alpha:1]
//#D9D9D9
#define SDLineColor [UIColor colorWithRed:217.0/255 green:217.0/255 blue:217.0/255 alpha:1]
//#f9acdc
#define SDPinkColor [UIColor colorWithRed:249.0/255 green:172.0/255 blue:220.0/255 alpha:1]


#define SDLightBlueColor [UIColor colorWithRed:0.0/255 green:153.0/255 blue:255.0/255 alpha:1]
#define SDGreenColor [UIColor colorWithRed:0.0/255 green:128.0/255 blue:43.0/255 alpha:1]
#define SDLightGreenColor [UIColor colorWithRed:51.0/255 green:204.0/255 blue:51.0/255 alpha:1]
#define SDLightYellowColor [UIColor colorWithRed:255.0/255 green:255.0/255 blue:128.0/255 alpha:1]
#define SDLightOrangeColor [UIColor colorWithRed:255.0/255 green:140.0/255 blue:26.0/255 alpha:1]
#define SDLightRedColor [UIColor colorWithRed:255.0/255 green:128.0/255 blue:128.0/255 alpha:1]

// Sleep
#define SDSleepAwakeColor [UIColor colorWithRed:255.0/255 green:153.0/255 blue:0.0/255 alpha:1]
#define SDSleepLightColor [UIColor colorWithRed:0.0/255 green:153.0/255 blue:255.0/255 alpha:1]
#define SDSleepDeepColor [UIColor colorWithRed:153.0/255 green:0.0/255 blue:255.0/255 alpha:1]
// Sport
#define SDSportStepColor [UIColor colorWithRed:0.0/255 green:153.0/255 blue:255.0/255 alpha:1]
#define SDSportDistanceColor [UIColor colorWithRed:0.0/255 green:153.0/255 blue:255.0/255 alpha:1]
#define SDSportCaloryColor [UIColor colorWithRed:153.0/255 green:0.0/255 blue:255.0/255 alpha:1]
// Blood
#define SDBloodDiastolicColor [UIColor colorWithRed:153.0/255 green:0.0/255 blue:255.0/255 alpha:1]
#define SDBloodSystolicColor [UIColor colorWithRed:0.0/255 green:153.0/255 blue:255.0/255 alpha:1]
#define SDBloodHeartbeatColor [UIColor colorWithRed:255.0/255 green:0.0/255 blue:153.0/255 alpha:1]
#define SDBloodDiastolic2Color [UIColor colorWithRed:153.0/255 green:0.0/255 blue:0.0/255 alpha:1]
#define SDBloodSystolic2Color [UIColor colorWithRed:0.0/255 green:153.0/255 blue:0.0/255 alpha:1]
#define SDBloodHeartbeat2Color [UIColor colorWithRed:255.0/255 green:0.0/255 blue:0.0/255 alpha:1]

// According to American Heart Association
#define SDBloodLevel1Color [UIColor colorWithRed:205.0/255 green:214.0/255 blue:145.0/255 alpha:1]
#define SDBloodLevel2Color [UIColor colorWithRed:165.0/255 green:188.0/255 blue:57.0/255 alpha:1]
#define SDBloodLevel3Color [UIColor colorWithRed:255.0/255 green:218.0/255 blue:70.0/255 alpha:1]
#define SDBloodLevel4Color [UIColor colorWithRed:254.0/255 green:189.0/255 blue:70.0/255 alpha:1]
#define SDBloodLevel5Color [UIColor colorWithRed:249.0/255 green:159.0/255 blue:44.0/255 alpha:1]
#define SDBloodLevel6Color [UIColor colorWithRed:240.0/255 green:81.0/255 blue:57.0/255 alpha:1]

// Heart Rate
#define SDHeartRateColor [UIColor colorWithRed:255.0/255 green:0.0/255 blue:153.0/255 alpha:1]

// According to Polar Sport Zones
#define SDHeartRateLevel1Color [UIColor colorWithRed:14.0/255 green:92.0/255 blue:168.0/255 alpha:1]
#define SDHeartRateLevel2Color [UIColor colorWithRed:19.0/255 green:145.0/255 blue:72.0/255 alpha:1]
#define SDHeartRateLevel3Color [UIColor colorWithRed:123.0/255 green:181.0/255 blue:52.0/255 alpha:1]
#define SDHeartRateLevel4Color [UIColor colorWithRed:248.0/255 green:195.0/255 blue:45.0/255 alpha:1]
#define SDHeartRateLevel5Color [UIColor colorWithRed:224.0/255 green:104.0/255 blue:32.0/255 alpha:1]
#define SDHeartRateLevel6Color [UIColor colorWithRed:222.0/255 green:13.0/255 blue:33.0/255 alpha:1]

// Breath
#define SDBreathGoodColor [UIColor colorWithRed:149.0/255 green:201.0/255 blue:82.0/255 alpha:1]
#define SDBreathNormalColor [UIColor colorWithRed:5.0/255 green:176.0/255 blue:230.0/255 alpha:1]
#define SDBreathBadColor [UIColor colorWithRed:255.0/255 green:47.0/255 blue:103.0/255 alpha:1]
// ECG
// HRV
#define SDHRVNerveLevel1Color [UIColor colorWithRed:128.0/255 green:0.0/255 blue:255.0/255 alpha:1]
#define SDHRVNerveLevel2Color [UIColor colorWithRed:51.0/255 green:51.0/255 blue:204.0/255 alpha:1]
#define SDHRVNerveLevel3Color [UIColor colorWithRed:0.0/255 green:204.0/255 blue:255.0/255 alpha:1]
#define SDHRVNerveLevel4Color [UIColor colorWithRed:64.0/255 green:191.0/255 blue:128.0/255 alpha:1]
#define SDHRVNerveLevel5Color [UIColor colorWithRed:51.0/255 green:204.0/255 blue:51.0/255 alpha:1]
#define SDHRVNerveLevel6Color [UIColor colorWithRed:255.0/255 green:204.0/255 blue:0.0/255 alpha:1]
#define SDHRVNerveLevel7Color [UIColor colorWithRed:255.0/255 green:128.0/255 blue:0.0/255 alpha:1]
#define SDHRVNerveLevel8Color [UIColor colorWithRed:255.0/255 green:0.0/255 blue:102.0/255 alpha:1]

// Telepathy
#define SDTelepathyLevel1Color [UIColor colorWithRed:128.0/255 green:0.0/255 blue:255.0/255 alpha:1]
#define SDTelepathyLevel2Color [UIColor colorWithRed:51.0/255 green:51.0/255 blue:204.0/255 alpha:1]
#define SDTelepathyLevel3Color [UIColor colorWithRed:0.0/255 green:204.0/255 blue:255.0/255 alpha:1]
#define SDTelepathyLevel4Color [UIColor colorWithRed:64.0/255 green:191.0/255 blue:128.0/255 alpha:1]
#define SDTelepathyLevel5Color [UIColor colorWithRed:51.0/255 green:204.0/255 blue:51.0/255 alpha:1]
#define SDTelepathyLevel6Color [UIColor colorWithRed:255.0/255 green:204.0/255 blue:0.0/255 alpha:1]
#define SDTelepathyLevel7Color [UIColor colorWithRed:255.0/255 green:128.0/255 blue:0.0/255 alpha:1]
#define SDTelepathyLevel8Color [UIColor colorWithRed:255.0/255 green:0.0/255 blue:102.0/255 alpha:1]


static NSString *const SDLoginTypeStringEmail = @"email";
static NSString *const SDLoginTypeStringGuest = @"guest";
static NSString *const SDLoginTypeStringWechat = @"wechat";
static NSString *const SDLoginTypeStringQQ = @"qq";
static NSString *const SDLoginTypeStringFacebook = @"facebook";
static NSString *const SDLoginTypeStringTwitter = @"twitter";

static NSString *const HLAppiTunesURL = @"https://itunes.apple.com/tw/app/";

// convenient
#define maybe(object, classType) ((classType *)([object isKindOfClass:[classType class]] ? object : nil))
#define nonEmptyString(object) ((NSString *)([object isKindOfClass:[NSString class]]? object : @""))
#define weakSelfMake(weakSelf) __weak __typeof(&*self)weakSelf = self;

#endif
