//
//  NURegisterViewController.m
//  NewUnionTest
//
//  Created by Than Dang on 3/12/16.
//  Copyright © 2016 ThanDang. All rights reserved.
//

#import "NURegisterViewController.h"
#import "NUAPI+CreateUser.h"

@interface NURegisterViewController () <NUAPIDelegate>
- (void) doCreateNewUser;
@end

@implementation NURegisterViewController

- (void) doCreateNewUser {
    
}

#pragma mark - Request protocol adopt

- (void) requestDidFinishedWithObject:(id)object {
    
}

- (void) requestDidFailedWithError:(id)errorObject {
    
}

@end
