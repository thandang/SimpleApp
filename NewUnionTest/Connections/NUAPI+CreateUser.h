//
//  NUAPI+CreateUser.h
//  NewUnionTest
//
//  Created by Than Dang on 3/12/16.
//  Copyright © 2016 ThanDang. All rights reserved.
//

#import "NUAPI.h"

@interface NUAPI (CreateUser)

- (void) createUserWithUsername:(NSString *) username password:(NSString *)password email:(NSString *)email;

@end
