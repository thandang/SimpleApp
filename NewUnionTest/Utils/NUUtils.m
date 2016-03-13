//
//  NUUtils.m
//  NewUnionTest
//
//  Created by Than Dang on 3/12/16.
//  Copyright © 2016 ThanDang. All rights reserved.
//

#import "NUUtils.h"

@implementation NUUtils

+ (void) hideKeyboard:(UIView *)topView {
    for (UIView *v in [topView subviews]) {
        if ([v isKindOfClass:[UITextField class]] || [v isKindOfClass:[UITextView class]]) {
            [v resignFirstResponder];
        } else {
            [self hideKeyboard:v];
        }
    }
}

+ (BOOL) saveAccessToken:(NSString *)accessToken {
    if (!accessToken || accessToken.length == 0) {
        return NO;
    }
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:accessToken forKey:@"token"];
    return [ud synchronize];
}

+ (NSString *) accessToken {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    return [ud objectForKey:@"token"];
}

@end
