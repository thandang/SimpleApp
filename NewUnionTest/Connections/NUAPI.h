//
//  NUAPI.h
//  NewUnionTest
//
//  Created by Than Dang on 3/12/16.
//  Copyright © 2016 ThanDang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NUAPIDelegate <NSObject>

- (void) requestDidFinishedWithObject:(id) object;
- (void) requestDidFailedWithError:(id) errorObject;

@end

@interface NUAPI : NSObject {

}

@property (nonatomic, weak) id<NUAPIDelegate> delegate;

- (void) connectWithRequest:(NSMutableURLRequest *)request;
- (NSMutableURLRequest *) requestGetWithURL:(NSString *)url param:(NSDictionary *)param;
- (NSMutableURLRequest *) requestPostWithURL:(NSString *)url param:(NSDictionary *)param;

- (void) cancel;
- (BOOL) isCancelled;

@end
