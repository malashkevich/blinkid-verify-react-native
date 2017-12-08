//
//  NSDictionary+Utils.m
//  IDVerify
//
//  Created by Jura on 01/03/2017.
//  Copyright © 2017 Microblink. All rights reserved.
//

#import "NSDictionary+Utils.h"

@implementation NSDictionary (Utils)

- (NSString *)pp_json {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end
