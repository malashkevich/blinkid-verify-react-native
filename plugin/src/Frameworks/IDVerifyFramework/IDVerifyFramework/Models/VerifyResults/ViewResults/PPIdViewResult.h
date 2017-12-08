//
//  PPIdVerifyViewResult.h
//  IDVerify
//
//  Created by Jura on 28/02/2017.
//  Copyright © 2017 Microblink Ltd.. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, PPIdScanSex) {
    PPIdScanSexUnknown,
    PPIdScanSexFemale,
    PPIdScanSexMale,
};

@interface PPIdViewResult : NSObject

@property (nonatomic) UIImage *faceImage;

@property (nonatomic) UIImage *selfieImage;

@property (nonatomic, readonly) NSString *configurationType;

- (void)updatePropertyForKey:(NSString *)key value:(NSString *)value;

@end
