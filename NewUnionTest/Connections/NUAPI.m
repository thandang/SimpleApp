//
//  NUAPI.m
//  NewUnionTest
//
//  Created by Than Dang on 3/12/16.
//  Copyright © 2016 ThanDang. All rights reserved.
//

#import "NUAPI.h"
#import "NSString+Utils.h"
#import "NUConnectionBase.h"

static const NSInteger kTIME_OUT_REQUEST = 300;

@interface NUAPI () {
    
}

@property (nonatomic, strong) NSOperation   *requestOperation;
@property (nonatomic, assign) REQUEST_TYPE  requestType;
@property (nonatomic, strong) NSData        *postData;

- (NSString *)getUrlString:(NSString*)baseURL apiName:(NSString *)apiName;
- (NSMutableURLRequest *) urlRequestPost:(NSString *)url withParam:(NSDictionary *)stringValues;
- (NSMutableURLRequest *) urlRequestGet:(NSString *)url withParam:(NSDictionary *)stringValues;

@end

@implementation NUAPI


- (void) connectWithRequest:(NSMutableURLRequest *)request {
    if (request) {
        if (self.requestOperation) return;
        NUConnectionBase *operation = [NUConnectionBase new];
        operation.requestPostData = self.postData;
        [operation connectWithRequest:request requestType:_requestType];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        operation.requestCompletionBlock = ^(id data, BOOL success) {
            dispatch_async(dispatch_get_main_queue(), ^{
               //Handle response
                if ([data isKindOfClass:[NSError class]]) {
                    NSLog(@"data response: %@", data);
                } else {
                    BOOL isValid = NO;
                    NSError *error = nil;
                    id jsonObj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
                    isValid = [NSJSONSerialization isValidJSONObject:jsonObj];
                    if (error) {
                        NSLog(@"Error:[%@]",error);
                        if (self.delegate && [self.delegate respondsToSelector:@selector(requestDidFailedWithError:)]) {
                            [self.delegate requestDidFailedWithError:error];
                        }
                    }
                    
                    if (isValid) {
                        if (self.delegate && [self.delegate respondsToSelector:@selector(requestDidFinishedWithObject:)]) {
                            [self.delegate requestDidFinishedWithObject:jsonObj];
                        }
                    }
                }
                self.requestOperation = nil;
                [self cancel];
            });
        };
        [operation enQueueOperation];
        self.requestOperation = operation;
        [operation cancelData];
    }
}

- (NSMutableURLRequest *) requestGetWithURL:(NSString *)url param:(NSDictionary *)param {
    NSString    *urlString = [self getUrlString:url apiName:@""];
    _requestType = REQUEST_GET;
    return [self urlRequestGet:urlString withParam:param];
}

- (NSMutableURLRequest *) requestPostWithURL:(NSString *)url param:(NSDictionary *)param {
    NSString    *urlString = [self getUrlString:url apiName:@""];
    _requestType = REQUEST_POST;
    return [self urlRequestPost:urlString withParam:param];
}

- (void) cancel {
    [self.requestOperation cancel];
    self.requestOperation = nil;
}

- (BOOL) isCancelled {
    return NO;
}


#pragma mark Private method
- (NSString *)getUrlString:(NSString*)baseURL apiName:(NSString *)apiName {
    return [[NSString stringWithFormat:baseURL,apiName] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (NSMutableURLRequest *) urlRequestPost:(NSString *)url withParam:(NSDictionary *)stringValues {
    NSMutableString *content = [[NSMutableString alloc] init];
    for (NSString *key in [stringValues keyEnumerator]) {
        if ([content length] != 0)
            [content appendString:@"&"];
        [content appendFormat:@"%@=%@",key, [[stringValues objectForKey:key] escapeString]];
    }
    
    self.postData = [NSJSONSerialization dataWithJSONObject:stringValues
                                                                       options:NSJSONWritingPrettyPrinted
                                                                         error:NULL];
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]
                                    initWithURL:[NSURL URLWithString:url]
                                    cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                    timeoutInterval:kTIME_OUT_REQUEST];
    [request setHTTPMethod:@"POST"];
    NSString *accessToken = [NUUtils accessToken];
    if (accessToken && [accessToken length]) {
        [request setValue:[NSString stringWithFormat:@"m %@", accessToken] forHTTPHeaderField:@"Authorization"];
    }
    
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:[content dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES]];
    
    return request;
}

- (NSMutableURLRequest *) urlRequestGet:(NSString *)url withParam:(NSDictionary *)stringValues {
    NSMutableString *content = [[NSMutableString alloc] init];
    for (NSString *key in [stringValues keyEnumerator]) {
        if ([content length] != 0)
            [content appendString:@"&"];
        [content appendFormat:@"%@=%@",key, [[stringValues objectForKey:key] escapeString]];
    }
    NSString *finalUrl = @"";
    if ([content length] > 0) {
        finalUrl =  [NSString stringWithFormat:@"%@?%@", url, content];
    } else {
        finalUrl = url;
    }
    
    NSURL *urlMain = [NSURL URLWithString:finalUrl];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:
                                    urlMain
                                                                cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                            timeoutInterval:kTIME_OUT_REQUEST];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"iPad" forHTTPHeaderField:@"User-Agent"];

    NSString *accessToken = [NUUtils accessToken];
    if (accessToken && [accessToken length]) {
        [request setValue:[NSString stringWithFormat:@"m %@", accessToken] forHTTPHeaderField:@"Authorization"];
    }
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    return request;
}

@end
