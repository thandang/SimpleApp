//
//  NUListUserViewController.m
//  NewUnionTest
//
//  Created by Than Dang on 3/12/16.
//  Copyright © 2016 ThanDang. All rights reserved.
//

#import "NUListUserViewController.h"
#import "NUAPI+ListUser.h"

@interface NUListUserViewController () <NUAPIDelegate>
- (void) doGetListUser;
@end

@implementation NUListUserViewController

- (void) doGetListUser {
    
}


#pragma mark - Request protocol adopt

- (void) requestDidFinishedWithObject:(id)object {
    
}

- (void) requestDidFailedWithError:(id)errorObject {
    
}

@end
