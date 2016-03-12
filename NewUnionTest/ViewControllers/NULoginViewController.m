//
//  NULoginViewController.m
//  NewUnionTest
//
//  Created by Than Dang on 3/12/16.
//  Copyright © 2016 ThanDang. All rights reserved.
//

#import "NULoginViewController.h"
#import "NUAPI+Login.h"

@interface NULoginViewController () <NUAPIDelegate>
- (void) doLogin;
@end

@implementation NULoginViewController

- (void) doLogin {
    
}


#pragma mark - Request protocol adopt

- (void) requestDidFinishedWithObject:(id)object {
    
}

- (void) requestDidFailedWithError:(id)errorObject {
    
}

@end
