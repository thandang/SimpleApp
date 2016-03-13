//
//  NUAPI+ListUser.m
//  NewUnionTest
//
//  Created by Than Dang on 3/12/16.
//  Copyright © 2016 ThanDang. All rights reserved.
//

#import "NUAPI+ListUser.h"

@implementation NUAPI (ListUser)

- (void) listUser {
    NSString *url = [NSString stringWithFormat:@"%@%@", APIURL, @"users"];
    NSMutableURLRequest *request = [self requestGetWithURL:url param:nil];
    [self connectWithRequest:request];
}

@end
