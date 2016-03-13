//
//  NUCommonViewController.h
//  NewUnionTest
//
//  Created by Than Dang on 3/13/16.
//  Copyright © 2016 ThanDang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface NUCommonViewController : UIViewController {
    UITapGestureRecognizer  *_tapGesture;
    MBProgressHUD   *_myHUD;
}

- (void) showLoadingHud;
- (void) hideLoadingHud;

@end
