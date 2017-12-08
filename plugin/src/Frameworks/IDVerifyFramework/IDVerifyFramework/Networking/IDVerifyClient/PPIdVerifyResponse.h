//
//  PPIdVerifyResponse.h
//  IDVerify
//
//  Created by Jura on 04/03/2017.
//  Copyright © 2017 Microblink. All rights reserved.
//

#import "PPPersonData.h"
#import "PPFaceMatchData.h"

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PPIdVerifyResponse : NSObject

@property (nonatomic, readonly) NSString *summary;

@property (nonatomic, readonly) BOOL isPersonVerified;

@property (nonatomic, readonly) PPFaceMatchData *faceMatchData;

@property (nonatomic, readonly) PPPersonData *personData;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initAsVerified:(BOOL)verified;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
