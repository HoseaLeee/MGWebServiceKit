//
//  WSKManager.h
//  WebService
//
//  Created by Hosea Lee on 2018/4/9.
//

#import <Foundation/Foundation.h>

#import <YTKNetwork/YTKNetwork.h>


@interface WSKManager : NSObject
    
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
    
+ (WSKManager *)defaultManager;
    
///  Request base URL. Default is empty string.
@property (nonatomic, strong) NSString *wsk_baseUrl;
///  Request CDN URL. Default is empty string.
@property (nonatomic, strong) NSString *wsk_cdnUrl;
    
@end
