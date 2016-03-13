//
//  NUUtils.h
//  NewUnionTest
//
//  Created by Than Dang on 3/12/16.
//  Copyright © 2016 ThanDang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NUUtils : NSObject

+ (void) hideKeyboard;
+ (void) showWaitingView;
+ (void) hideWaitingView;
+ (BOOL) isConnected;

+ (BOOL) saveAccessToken:(NSString *)accessToken;
+ (NSString *) accessToken;

@end
