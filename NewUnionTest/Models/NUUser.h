//
//  NUUser.h
//  NewUnionTest
//
//  Created by Than Dang on 3/13/16.
//  Copyright © 2016 ThanDang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NUUser : NSObject

@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *avatar;

- (instancetype) initWithDictionary:(NSDictionary *)dict;

@end
