//
//  NSString+Util.m
//  NewUnionTest
//
//  Created by Than Dang on 3/13/16.
//  Copyright © 2016 ThanDang. All rights reserved.
//

#import "NSString+Utils.h"

@implementation NSString (Utils)

- (NSString *)escapeString {
    CFStringRef refString = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                    (CFStringRef)self,
                                                                    NULL,
                                                                    (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                    kCFStringEncodingUTF8);
    NSString *escapedString = [NSString stringWithString:(__bridge NSString*)refString];
    CFRelease(refString);
    return escapedString;
    
}


- (NSString *) removeSpace {
    NSArray* words = [self componentsSeparatedByCharactersInSet :[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString* nospacestring = [words componentsJoinedByString:@""];
    return nospacestring;
}
@end
