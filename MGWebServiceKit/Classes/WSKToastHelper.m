//
//  WSKToastHelper.m
//  WebService
//
//  Created by Hosea Lee on 2018/4/9.
//

#import "WSKToastHelper.h"

@interface WSKToastHelper()
    
    
@end

@implementation WSKToastHelper

+ (void)showMessage:(NSString *)message
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow makeToast:message];
}

@end
