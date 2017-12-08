//
//  PPConfiguration.m
//  IDVerifyFramework
//
//  Created by Jura on 06/04/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPConfiguration.h"

@implementation PPConfiguration

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _editableKeys = dictionary[@"editableKeys"];

        id transliterationMappings = dictionary[@"transliterationMappings"];
        if (![[NSNull null] isEqual:transliterationMappings]) {
            _transliterationMappings = [[PPKeyboardConfusions alloc] initWithConfusions:transliterationMappings];
        }

        _type = dictionary[@"type"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.editableKeys forKey:@"editableKeys"];
    [encoder encodeObject:self.transliterationMappings forKey:@"transliterationMappings"];
    [encoder encodeObject:self.type forKey:@"type"];
}

- (nullable instancetype)initWithCoder:(NSCoder *)decoder {
    self = [self initWithDictionary:nil];
    if (self) {
        self.editableKeys = [decoder decodeObjectForKey:@"editableKeys"];
        self.transliterationMappings = [decoder decodeObjectForKey:@"transliterationMappings"];
        self.type = [decoder decodeObjectForKey:@"type"];
    }
    return self;
}

- (NSString *)description {
    NSString *str = [super description];
    return
    [str stringByAppendingString:
     [NSString
      stringWithFormat:@"editableKeys %@, transliterationMappings %@, type %@",
      _editableKeys, _transliterationMappings, _type]];
}

+ (instancetype)croIdConfiguration {
    return [[[self class] alloc] initWithDictionary:@{
        @"editableKeys" : @[ @"CroIDCombinedFirstName", @"CroIDCombinedLastName", @"CroIDCombinedFullAddress" ],
        @"transliterationMappings" : @[
            @[ @"č", @"ć", @"c" ], @[ @"s", @"š" ], @[ @"z", @"ž" ], @[ @"d", @"đ" ], @[ @"Č", @"Ć", @"C" ], @[ @"S", @"Š" ],
            @[ @"Z", @"Ž" ], @[ @"D", @"Đ" ]
        ],
        @"type" : @"croID"
    }];
}

+ (NSString *)croIdConfigurationType {
    return @"croID";
}

+ (instancetype)mrtdConfiguration {
    return [[[self class] alloc] initWithDictionary:@{
        @"editableKeys" : @[],
        @"transliterationMappings" : @[],
        @"type" : @"mrtdCombined"
    }];
}

+ (NSString *)mrtdConfigurationType {
    return @"mrtdCombined";
}

+ (instancetype)slovenianConfiguration {
    return [[[self class] alloc] initWithDictionary:@{
        @"editableKeys" : @[],
        @"transliterationMappings" : @[],
        @"type" : @"sloID"
    }];
}

+ (NSString *)slovenianConfigurationType {
    return @"sloID";
}

+ (instancetype)czechConfiguration {
    return [[[self class] alloc] initWithDictionary:@{
        @"editableKeys" : @[],
        @"transliterationMappings" : @[],
        @"type" : @"czechID"
    }];
}

+ (NSString *)czechConfigurationType {
    return @"czechID";
}

+ (instancetype)serbianConfiguration {
    return [[[self class] alloc] initWithDictionary:@{
        @"editableKeys" : @[],
        @"transliterationMappings" : @[],
        @"type" : @"serbianID"
    }];
}

+ (NSString *)serbianConfigurationType {
    return @"serbianID";
}

+ (instancetype)singaporeConfiguration {
    return [[[self class] alloc] initWithDictionary:@{
        @"editableKeys" : @[],
        @"transliterationMappings" : @[],
        @"type" : @"singaporeID"
    }];
}

+ (NSString *)singaporeConfigurationType {
    return @"singaporeID";
}

+ (instancetype)slovakConfiguration {
    return [[[self class] alloc] initWithDictionary:@{
        @"editableKeys" : @[],
        @"transliterationMappings" : @[],
        @"type" : @"slovakID"
    }];
}

+ (NSString *)slovakConfigurationType {
    return @"slovakID";
}

+ (instancetype)austrianConfiguration {
    return [[[self class] alloc] initWithDictionary:@{
        @"editableKeys" : @[],
        @"transliterationMappings" : @[],
        @"type" : @"austrianID"
    }];
}

+ (NSString *)austrianConfigurationType {
    return @"austrianID";
}

+ (instancetype)germanConfiguration {
    return [[[self class] alloc] initWithDictionary:@{
        @"editableKeys" : @[ @"GermanCombinedFirstName", @"GermanCombinedLastName", @"GermanCombinedFullAddress" ],
        @"transliterationMappings" : @[ @[ @"ß", @"ss" ], @[ @"Ä", @"aa" ] ],
        @"type" : @"germanIDNew"
    }];
}

+ (NSString *)germanConfigurationType {
    return @"germanIDNew";
}

+ (instancetype)usdlConfiguration {
    return [[[self class] alloc] initWithDictionary:@{
        @"editableKeys" : @[],
        @"transliterationMappings" : @[],
        @"type" : @"usdlCombined"
    }];
}

+ (NSString *)usdlConfigurationType {
    return @"usdlCombined";
}

+ (NSString *)livenessConfigurationType {
    return @"liveness";
}

+ (NSArray *)configurationTypes {
    return @[
        [PPConfiguration croIdConfigurationType], [PPConfiguration mrtdConfigurationType], [PPConfiguration slovenianConfigurationType],
        [PPConfiguration czechConfigurationType], [PPConfiguration serbianConfigurationType], [PPConfiguration singaporeConfigurationType],
        [PPConfiguration slovakConfigurationType], [PPConfiguration austrianConfigurationType], [PPConfiguration germanConfigurationType],
        [PPConfiguration usdlConfigurationType]
    ];
}

@end
