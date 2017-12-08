//
//  PPCheckSignatureResponse.h
//  IDVerifyFramework
//
//  Created by Jura on 13/03/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "PPPersonData.h"

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PPCheckSignatureResponse : NSObject

@property (nonatomic, readonly) NSString *summary;

@property (nonatomic, readonly) BOOL signatureOk;

@property (nonatomic, readonly) BOOL allowedChangesOk;

@property (nonatomic, readonly) PPPersonData *personData;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
