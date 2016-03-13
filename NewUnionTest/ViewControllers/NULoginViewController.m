//
//  NULoginViewController.m
//  NewUnionTest
//
//  Created by Than Dang on 3/13/16.
//  Copyright © 2016 ThanDang. All rights reserved.
//

#import "NULoginViewController.h"
#import "NUAPI+Login.h"
#import "NURegisterViewController.h"
#import "NSString+Utils.h"
#import "NSDictionary+NotNullValue.h"

#define segueRegister  @"seg_register"
#define segueList @"seg_list"

@interface NULoginViewController () <NUAPIDelegate> {
    NUAPI   *_api;
}

@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;



@end

@implementation NULoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
//    if ([segue.identifier isEqualToString:segueRegister]) {
//        NURegisterViewController *registerVC = [segue destinationViewController];
//    }
}



- (IBAction)onActionRegister:(id)sender {
    [self performSegueWithIdentifier:segueRegister sender:sender];
}

- (IBAction)onActionLogin:(id)sender {
    NSString *errorMessage = @"";
    if (ISCONNECTINGNETWORK) {
        if (!self.txtEmail.text || [self.txtEmail.text removeSpace].length == 0) {
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
        [_api startLoginWithUsername:self.txtEmail.text password:self.txtPassword.text];
        [self showLoadingHud];
    }
}


#pragma mark - Request protocol adopt

- (void) requestDidFinishedWithObject:(id)object {
    [self hideLoadingHud];
    NSDictionary *dictResponse = (NSDictionary *)object;
    if ([dictResponse objectNotNullForKey:tokenKey]) {
        [NUUtils saveAccessToken:[dictResponse objectForKey:tokenKey]];
        [self performSegueWithIdentifier:segueList sender:self];
    }
}

- (void) requestDidFailedWithError:(id)errorObject {
    [self hideLoadingHud];
//    NSError *error = (NSError *)errorObject;
    UIAlertView *alr = [[UIAlertView alloc] initWithTitle:@"Error" message:[errorObject description]  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alr show];
}

@end
