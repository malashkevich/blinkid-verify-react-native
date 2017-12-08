//
//  PPIdVerifyClient.h
//  IDVerify
//
//  Created by Jura on 27/02/2017.
//  Copyright © 2017 Microblink Ltd.. All rights reserved.
//

#import "PPIdVerifyResult.h"
#import "PPIdVerifyResponse.h"
#import "PPCheckSignatureResponse.h"
#import "PPGetConfigurationResponse.h"

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PPIdVerifyClient : NSObject

@property (nonatomic, readonly) NSURL *url;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithUrl:(NSURL *)url;

- (instancetype)initWithUrl:(NSURL *)url session:(NSURLSession *)session NS_DESIGNATED_INITIALIZER;

- (void)verifyResult:(PPIdVerifyResult *)result completion:(nonnull void (^)(PPIdVerifyResponse *_Nonnull, NSError *_Nonnull))completion;

- (void)checkSignature:(PPIdVerifyResult *)result completion:(nonnull void (^)(PPCheckSignatureResponse *_Nonnull, NSError *_Nonnull))completion;

- (void)getConfigurationForType:(NSString *)typeId completion:(nonnull void (^)(PPGetConfigurationResponse *_Nonnull, NSError *_Nonnull))completion;

- (void)getConfigurationWithCompletion:(nonnull void (^)(NSArray<PPGetConfigurationResponse *> *_Nonnull, NSError *_Nonnull))completion;

@end

NS_ASSUME_NONNULL_END
