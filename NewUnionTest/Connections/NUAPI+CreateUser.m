//
//  NUAPI+CreateUser.m
//  NewUnionTest
//
//  Created by Than Dang on 3/12/16.
//  Copyright © 2016 ThanDang. All rights reserved.
//

#import "NUAPI+CreateUser.h"

@implementation NUAPI (CreateUser)

- (void) createUserWithUsername:(NSString *)username password:(NSString *)password email:(NSString *)email {
    if (username && username.length && password && password.length && email && email.length) {
        NSDictionary *dictParams = [NSDictionary dictionaryWithObjectsAndKeys:username, nameKey,
                                    email, emailKey,
                                    password, passwordKey, nil];
        NSString *url = [NSString stringWithFormat:@"%@%@", APIURL, @"create"];
        NSMutableURLRequest *request = [self requestPostWithURL:url param:dictParams];
        [self connectWithRequest:request];
    }
}

@end
