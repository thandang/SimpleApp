//
//  AppDelegate.h
//  NewUnionTest
//
//  Created by Than Dang on 3/12/16.
//  Copyright © 2016 ThanDang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMPP.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) XMPPStream *xmppStream;

- (BOOL)connect;
- (void)disconnect;

@end

