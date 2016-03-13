//
//  NURegisterViewController.m
//  NewUnionTest
//
//  Created by Than Dang on 3/13/16.
//  Copyright © 2016 ThanDang. All rights reserved.
//

#import "NURegisterViewController.h"
#import "NUAPI+CreateUser.h"
#import "NSString+Utils.h"


@interface NURegisterViewController () <NUAPIDelegate> {
    NUAPI *_api;
}
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;

@end

@implementation NURegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

- (IBAction)onActionRegister:(id)sender {
    NSString *errorMessage = @"";
    if (ISCONNECTINGNETWORK) {
        if (!self.txtName.text || [self.txtName.text removeSpace].length == 0) {
            errorMessage = @"Name required";
        } else if (!self.txtEmail.text || [self.txtEmail.text removeSpace].length == 0) {
            errorMessage = @"Email required";
        } else if (!self.txtPassword.text || [self.txtPassword.text removeSpace].length == 0) {
            errorMessage = @"Password required";
        }
    } else {
        errorMessage = @"No internet connection";
    }
    if (errorMessage.length) {
        UIAlertView *alr = [[UIAlertView alloc] initWithTitle:@"Error" message:errorMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alr show];
    } else {
        if (_api) {
            _api = nil;
            [_api cancel];
        }
        _api = [NUAPI new];
        _api.delegate = self;
        [_api createUserWithUsername:self.txtName.text password:self.txtEmail.text email:self.txtPassword.text];
        [self showLoadingHud];
    }
}



#pragma mark - Request protocol adopt

- (void) requestDidFinishedWithObject:(id)object {
    [self hideLoadingHud];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void) requestDidFailedWithError:(id)errorObject {
    [self hideLoadingHud];
    UIAlertView *alr = [[UIAlertView alloc] initWithTitle:@"Error" message:[errorObject description]  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alr show];
}

@end
