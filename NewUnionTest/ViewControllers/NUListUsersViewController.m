//
//  NUListUsersViewController.m
//  NewUnionTest
//
//  Created by Than Dang on 3/13/16.
//  Copyright © 2016 ThanDang. All rights reserved.
//

#import "NUListUsersViewController.h"
#import "NUAPI+ListUser.h"
#import "NUUser.h"
#import "NUUserViewCell.h"
#import "JGAFImageCache.h"

#define cellIdentifier  @"cellIdentifier"


@interface NUListUsersViewController () <NUAPIDelegate, UITableViewDataSource, UITableViewDelegate> {
    NUAPI *_api;
    NSMutableArray *_users;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation NUListUsersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationController.navigationBar.hidden=NO;
    self.title = @"List Users";
    
    if (ISCONNECTINGNETWORK) {
        [self showLoadingHud];
         _api = [NUAPI new];
        _api.delegate = self;
        [_api listUser];
    } else {
        UIAlertView *alr = [[UIAlertView alloc] initWithTitle:@"Error" message:@"No internet connection" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alr show];
    }
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
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

#pragma mark - UITableview
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_users) {
        return _users.count;
    }
    return 0;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NUUserViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (nil == cell) {
        cell = [NUUtils loadViewFromNibName:@"NUUserViewCell" forClassName:@"NUUserViewCell"];
    }
    NUUser *urs = _users[indexPath.row];
    
    [[JGAFImageCache sharedInstance] imageForURL:urs.avatar completion:^(UIImage *image) {
        cell.imvAvatar.image = image;
    }];
    cell.txtName.text = urs.username;
    if (urs.email) {
        cell.txtEmail.text = urs.email;
    }
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 56.0;
}

#pragma mark - Request protocol adopt

- (void) requestDidFinishedWithObject:(id)object {
    [self hideLoadingHud];
    if (object && [object isKindOfClass:[NSArray class]]) {
        NSArray *arr = (NSArray *)object;
        if (_users) {
            [_users removeAllObjects];
        } else {
            _users = [[NSMutableArray alloc] initWithCapacity:arr.count];
        }
        for (NSInteger i = 0; i < arr.count; i++) {
            NSDictionary *dict = arr[i];
            NUUser *urs = [[NUUser alloc] initWithDictionary:dict];
            [_users addObject:urs];
        }
        [self.tableView reloadData];
    }
}

- (void) requestDidFailedWithError:(id)errorObject {
    [self hideLoadingHud];
}


- (void) dealloc {
    if (_users) {
        [_users removeAllObjects];
        _users = nil;
    }
}

@end
