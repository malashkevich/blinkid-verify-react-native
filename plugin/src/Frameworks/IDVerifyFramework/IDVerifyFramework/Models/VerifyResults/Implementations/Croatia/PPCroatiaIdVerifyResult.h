//
//  PPCroatiaIdVerifyResult.h
//  IDVerify
//
//  Created by Jura on 28/02/2017.
//  Copyright © 2017 Microblink. All rights reserved.
//

#import "PPIdVerifyResult.h"
#import "PPCroatiaIdViewResult.h"

@interface PPCroatiaIdVerifyResult : PPIdVerifyResult

- (instancetype)init NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithViewResult:(PPIdViewResult *)viewResult NS_UNAVAILABLE;

/**
 * Convenience method to get view result from superclass in appropriate type
 *
 * @return view result in the correct type
 */
- (PPCroatiaIdViewResult *)croatiaViewResult;

@end
