//
//  PPPersonData.h
//  IDVerify
//
//  Created by Jura on 04/03/2017.
//  Copyright © 2017 Microblink. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PPPersonData : NSObject

@property (nonatomic, readonly) NSDictionary *data;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
