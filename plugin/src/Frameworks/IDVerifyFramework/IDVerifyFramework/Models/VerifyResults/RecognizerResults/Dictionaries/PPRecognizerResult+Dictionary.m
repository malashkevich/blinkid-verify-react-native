//
//  PPRecognizerResult+Dictionary.m
//  IDVerify
//
//  Created by Jura on 02/03/2017.
//  Copyright © 2017 Microblink. All rights reserved.
//

#import "PPRecognizerResult+Dictionary.h"

@implementation PPRecognizerResult (Dictionary)

- (NSMutableDictionary<NSString *, NSObject *> *)dictionary {

    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

    [[self getAllElements] enumerateKeysAndObjectsUsingBlock:^(id _Nonnull key, id _Nonnull obj, BOOL *_Nonnull stop) {

        PPElementType type = [[self getAllElementTypes] objectForKey:key].intValue;

        switch (type) {
            case PPElementTypeNull:
                [dict setObject:[NSNull null] forKey:key];
                break;
            case PPElementTypeBoolean:
            case PPElementTypeInt:
                [dict setObject:obj forKey:key];
                break;
            case PPElementTypeString:
                [dict setObject:[self getStringElementUsingGuessedEncoding:key] forKey:key];
                break;
            case PPElementTypeByteArray:
                [dict setObject:[self dictionaryWithData:[self getDataElement:key]] forKey:key];
                break;
            case PPElementTypeDateTime:
                [dict setObject:[self dictionaryWithDateResult:obj] forKey:key];
                break;
            case PPElementTypeOcr:
            case PPElementTypeBarcodeData:
            case PPElementTypeQuadrangle:
            case PPElementTypeDetectorResult:
                break;
        }
    }];

    return dict;
}

- (NSDictionary *)dictionaryWithData:(NSData *)data {

    if (data == nil) {
        return @{};
    }

    NSString *b64data = [data base64EncodedStringWithOptions:0];
    NSAssert(b64data != nil, @"base64 encoded data should not be nil!");

    return @{ @"base64Data" : b64data, @"type" : @"bytes" };
}

- (NSDictionary *)dictionaryWithDateResult:(PPDateResult *)dateResult {

    if (dateResult == nil) {
        return @{};
    }

    NSDate *date = dateResult.date;

    NSDateComponents *components =
        [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];

    NSAssert([dateResult originalDateString], @"Original date string must not be nil!");

    return @{
        @"type" : @"date",
        @"day" : @(components.day),
        @"month" : @(components.month),
        @"year" : @(components.year),
        @"originalString" : [dateResult originalDateString]
    };
}

@end
