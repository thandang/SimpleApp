//
//  NUConnectionBase.h
//  NewUnionTest
//
//  Created by Than Dang on 3/12/16.
//  Copyright © 2016 ThanDang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NUConstants.h"


typedef void (^NUCompletionBlock)(id data, BOOL success);
typedef void (^NUHTTPCompleteBlock)(id data, BOOL success, NSInteger errorCode);

@interface NUConnectionBase : NSOperation <NSURLSessionDelegate, NSURLSessionTaskDelegate, NSURLSessionDataDelegate> {
    NSURLSession *_session;
    NSURLRequest    *_request;
    REQUEST_TYPE _requestType;
    NSURLSessionDataTask        *_dataTask;
}

@property (strong) NUCompletionBlock requestCompletionBlock;
@property (nonatomic, strong) NSData *requestPostData;

- (void) connectWithRequest:(NSURLRequest *)request requestType:(REQUEST_TYPE) requestType;
- (void) enQueueOperation;
- (void) cancelData;

@end
