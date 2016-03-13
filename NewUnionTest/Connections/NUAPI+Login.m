//
//  NUAPI+Login.m
//  NewUnionTest
//
//  Created by Than Dang on 3/12/16.
//  Copyright © 2016 ThanDang. All rights reserved.
//

#import "NUAPI+Login.h"

@implementation NUAPI (Login)

- (void) startLoginWithUsername:(NSString *)username password:(NSString *)password {
    if (username && username.length && password && password.length) {
        NSDictionary *dictParams = [NSDictionary dictionaryWithObjectsAndKeys:username, emailKey,
                                    password, passwordKey, nil];
        NSString *url = [NSString stringWithFormat:@"%@%@", APIURL, @"auth/signin"];
        NSMutableURLRequest *request = [self requestPostWithURL:url param:dictParams];
        [self connectWithRequest:request];
    }
}

@end
