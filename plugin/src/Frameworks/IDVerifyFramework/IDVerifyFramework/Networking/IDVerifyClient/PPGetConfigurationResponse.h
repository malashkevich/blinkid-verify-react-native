//
//  PPGetConfigurationResponse.h
//  IDVerifyFramework
//
//  Created by Jura on 06/04/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PPConfiguration;

@interface PPGetConfigurationResponse : NSObject

@property (nonatomic, strong) NSString *summary;

@property (nonatomic, strong) PPConfiguration *data;

@property (nonatomic) BOOL loaded;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary NS_DESIGNATED_INITIALIZER;

@end
