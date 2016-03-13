//
//  NUConnectionBase.m
//  NewUnionTest
//
//  Created by Than Dang on 3/12/16.
//  Copyright © 2016 ThanDang. All rights reserved.
//

#import "NUConnectionBase.h"
#import "NUConstants.h"
#import <UIKit/UIKit.h>

static const NSInteger kTIME_OUT_REQUEST_DOWNLOAD = 600;

@interface NUConnectionBase()

- (NSURLSession *) foregroundSession;
- (NSOperationQueue *)operationQueue;

@end

@implementation NUConnectionBase

@synthesize completionBlock;

#pragma mark - Public Methods
- (void) connectWithRequest:(NSURLRequest *)request requestType:(REQUEST_TYPE)requestType {
    _request = request;
    _requestType = requestType;
}

- (void) cancelData {
    if (_dataTask) {
        if ([_dataTask state] == NSURLSessionTaskStateRunning) {
            [_dataTask cancel];
        }
        _dataTask = nil;
    }
}


- (void) enQueueOperation {
    [[self operationQueue] addOperation:self];
}



#pragma mark - 

- (void) start {
    if (!self.isCancelled) {
        if (!_session)
            _session = [self foregroundSession];
        if (_requestType == REQUEST_POST) {
            _dataTask = [_session uploadTaskWithRequest:_request fromData:self.requestPostData completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                if (self.requestCompletionBlock) {
                    if (error) {
                        self.requestCompletionBlock(error, NO);
                    } else {
                        self.requestCompletionBlock(data, YES);
                    }
                }
            }];
        } else if (_requestType == REQUEST_GET) {
            _dataTask = [_session dataTaskWithRequest:_request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                if (self.requestCompletionBlock) {
                    if (error) {
                        self.requestCompletionBlock(error, NO);
                    } else {
                        self.requestCompletionBlock(data, YES);
                    }
                }
            }];
        }
        [_dataTask resume];
    }
}


#pragma mark - NSURLSessionTaskDelegate
- (void) URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    if (error) {
        self.requestCompletionBlock(error, NO);
    }
    _dataTask = nil;
}

- (NSURLSession *) foregroundSession {
    
    static NSURLSession *session = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        [configuration setAllowsCellularAccess:YES];
        [configuration setTimeoutIntervalForRequest:kTIME_OUT_REQUEST_DOWNLOAD];
        [configuration setTimeoutIntervalForResource:kTIME_OUT_REQUEST_DOWNLOAD];
        [configuration setHTTPMaximumConnectionsPerHost:1];
        session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    });
    return session;
}

- (NSOperationQueue *) operationQueue {
    static NSOperationQueue *operationQueue = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        operationQueue = [NSOperationQueue new];
        [operationQueue setMaxConcurrentOperationCount:NSOperationQueueDefaultMaxConcurrentOperationCount];
    });
    return operationQueue;
}

@end
