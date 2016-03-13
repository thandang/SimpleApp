//
//  NUUser.m
//  NewUnionTest
//
//  Created by Than Dang on 3/13/16.
//  Copyright © 2016 ThanDang. All rights reserved.
//

#import "NUUser.h"
#import "NSDictionary+NotNullValue.h"



@implementation NUUser

- (instancetype) initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        if (dict) {
            if ([dict objectNotNullForKey:userKey]) {
                self.userId = [dict objectForKey:userKey];
            }
            if ([dict objectNotNullForKey:nameKey]) {
                self.username = [dict objectForKey:nameKey];
            }
            if ([dict objectNotNullForKey:emailKey]) {
                self.email = [dict objectForKey:emailKey];
            }
            if ([dict objectNotNullForKey:avatarKey]) {
                self.avatar = [dict objectForKey:avatarKey];
            }
        }
    }
    return self;
}

@end
