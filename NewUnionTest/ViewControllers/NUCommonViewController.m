//
//  NUCommonViewController.m
//  NewUnionTest
//
//  Created by Than Dang on 3/13/16.
//  Copyright © 2016 ThanDang. All rights reserved.
//

#import "NUCommonViewController.h"

@interface NUCommonViewController ()

@end

@implementation NUCommonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (!_tapGesture) {
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    }
}

- (void) hideKeyboard {
    [self.view removeGestureRecognizer:_tapGesture];
    [NUUtils hideKeyboard:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)showLoadingHud {
    if (!_myHUD) {
        _myHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
}
- (void)hideLoadingHud {
    [_myHUD hide:YES];
    _myHUD = nil;
}

@end
