//
//  PPCroIDCombinedRecognizerResult+Test.h
//  IDVerify
//
//  Created by Jura on 28/02/2017.
//  Copyright © 2017 Microblink. All rights reserved.
//

#import <MicroBlink/MicroBlink.h>

@interface PPCroIDCombinedRecognizerResult (Test)

- (instancetype)initWithFirstName:(NSString *)firstName
                         lastName:(NSString *)lastName
               identityCardNumber:(NSString *)identityCardNumber
                              sex:(NSString *)sex
                      nationality:(NSString *)nationality
                      dateOfBirth:(NSDate *)dateOfBirth
             documentDateOfExpiry:(NSDate *)documentDateOfExpiry
                          address:(NSString *)address
                 issuingAuthority:(NSString *)issuingAuthority
              documentDateOfIssue:(NSDate *)documentDateOfIssue
                              oib:(NSString *)oib
                     mrtdVerified:(BOOL)mrtdVerified
                     matchingData:(BOOL)matchingData
                      nonResident:(BOOL)nonResident
                documentBilingual:(BOOL)documentBilingual
                        signature:(NSData *)signature
                 signatureVersion:(NSString *)signatureVersion
                        faceImage:(NSData *)faceImage;

+ (PPCroIDCombinedRecognizerResult *)dinoResult;

+ (PPCroIDCombinedRecognizerResult *)emirResult;

+ (PPCroIDCombinedRecognizerResult *)juraResult;

@end
