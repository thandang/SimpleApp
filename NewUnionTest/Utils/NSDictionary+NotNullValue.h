//
//  NSDictionary+NotNullValue.h
//  NewUnionTest
//
//  Created by Than Dang on 3/13/16.
//  Copyright © 2016 ThanDang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (NotNullValue)
- (id) stringNotNullForKey:(id)key;
- (id) dictionaryNotNullForKey:(id)key;
- (id) arrayNotNullForKey:(id)key;
- (id) objectNotNullForKey:(id)key;

@end
