//
//  WSKManager.m
//  WebService
//
//  Created by Hosea Lee on 2018/4/9.
//

#import "WSKManager.h"

#import <RealReachability/RealReachability.h>
#import "WSKToastHelper.h"

@interface WSKManager()
    
@property (nonatomic , strong) YTKNetworkConfig * ytk_config;
    
@end
@implementation WSKManager

+ (WSKManager *)defaultManager {
        static id sharedInstance = nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            sharedInstance = [[self alloc] init];
        });
        return sharedInstance;
    }
    
- (instancetype)init {
    self = [super init];
    if (self) {
        _wsk_baseUrl = @"";
        _wsk_cdnUrl = @"";
        
        _ytk_config = [YTKNetworkConfig sharedConfig];
        
        [self startReachability];
        
    }
    return self;
}

    - (void)setWsk_baseUrl:(NSString *)wsk_baseUrl
    {
        _wsk_baseUrl = wsk_baseUrl;
        self.ytk_config.baseUrl = _wsk_baseUrl;
    }
    
    - (void)setWsk_cdnUrl:(NSString *)wsk_cdnUrl
    {
        _wsk_cdnUrl = wsk_cdnUrl;
        self.ytk_config.cdnUrl = _wsk_cdnUrl;
    }
    
#pragma mark RealReachability
 - (void)startReachability
    {
        [GLobalRealReachability startNotifier];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(networkChanged:)
                                                     name:kRealReachabilityChangedNotification
                                                   object:nil];
        
        ReachabilityStatus status = [GLobalRealReachability currentReachabilityStatus];
        NSLog(@"Initial reachability status:%@",@(status));
        
        if (status == RealStatusNotReachable)
        {
            [WSKToastHelper showMessage:@"您的网络已经断开"];
        }
        
        if (status == RealStatusViaWiFi)
        {
            [WSKToastHelper showMessage:@"您已切换到WiFi网络"];
        }
        
        if (status == RealStatusViaWWAN)
        {
            [WSKToastHelper showMessage:@"您正在使用蜂窝数据上网，请注意流量使用"];
        }
    }
    
- (void)networkChanged:(NSNotification *)notification
    {
        RealReachability *reachability = (RealReachability *)notification.object;
        ReachabilityStatus status = [reachability currentReachabilityStatus];
        ReachabilityStatus previousStatus = [reachability previousReachabilityStatus];
        NSLog(@"networkChanged, currentStatus:%@, previousStatus:%@", @(status), @(previousStatus));
        
        if (status == RealStatusNotReachable)
        {
            [WSKToastHelper showMessage:@"您的网络已经断开"];
        }
        
        if (status == RealStatusViaWiFi)
        {
            [WSKToastHelper showMessage:@"您已切换到WiFi网络"];
        }
        
        if (status == RealStatusViaWWAN)
        {
            [WSKToastHelper showMessage:@"您正在使用蜂窝数据上网，请注意流量使用"];
        }
        
        WWANAccessType accessType = [GLobalRealReachability currentWWANtype];
        
        if (status == RealStatusViaWWAN)
        {
            if (accessType == WWANType2G)
            {
                [WSKToastHelper showMessage:@"RealReachabilityStatus2G"];
            }
            else if (accessType == WWANType3G)
            {
                [WSKToastHelper showMessage:@"RealReachabilityStatus3G"];
            }
            else if (accessType == WWANType4G)
            {
                [WSKToastHelper showMessage:@"RealReachabilityStatus4G"];
            }
            else
            {
                [WSKToastHelper showMessage:@"Unknown RealReachability WWAN Status, might be iOS6"];
            }
        }
    }
@end
