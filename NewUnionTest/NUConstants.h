//
//  NUConstants.h
//  NewUnionTest
//
//  Created by Than Dang on 3/12/16.
//  Copyright © 2016 ThanDang. All rights reserved.
//

#ifndef NUConstants_h
#define NUConstants_h

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define ISCONNECTINGNETWORK	(([[Reachability reachabilityForInternetConnection] currentReachabilityStatus]!=NotReachable)||([[Reachability reachabilityForLocalWiFi] currentReachabilityStatus]!=NotReachable))

typedef enum  {
    REQUEST_POST,
    REQUEST_GET
} REQUEST_TYPE;


static const NSString *APIURL = @"http://54.255.201.10:9000/";
static const NSString *userKey = @"_id";
static const NSString *nameKey = @"name";
static const NSString *emailKey = @"email";
static const NSString *avatarKey = @"avatar";
static const NSString *passwordKey = @"password";
static const NSString *tokenKey = @"token";

#endif /* NUConstants_h */
