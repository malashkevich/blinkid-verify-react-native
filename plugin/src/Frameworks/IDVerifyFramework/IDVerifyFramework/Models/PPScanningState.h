//
//  PPScanningState.h
//  LivenessTest
//
//  Created by Jura on 02/12/2016.
//  Copyright © 2017 Microblink Ltd.. All rights reserved.
//

#ifndef PPScanningState_h
#define PPScanningState_h


typedef NS_ENUM(NSUInteger, PPScanningState) {
    PPScanningStateUndefined = -1,
    PPScanningStateIdFrontSide = 0,
    PPScanningStateIdBackSide = 1,
    PPScanningStateDone = 2,
    PPScanningStateNonMatchingData = 3,
};


#endif /* PPScanningState_h */
