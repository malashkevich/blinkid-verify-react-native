//
//  MicroBlink.h
//  MicroBlinkFramework
//
//  Created by Jurica Cerovec on 3/29/12.
//  Copyright (c) 2012 MicroBlink Ltd. All rights reserved.
//

#ifndef PhotoPayFramework_MicroBlink_h
#define PhotoPayFramework_MicroBlink_h

// Include Common API
#import "PPPhotoPayUiSettings.h"
#import "PPApp.h"
#import "PPViewControllerFactory.h"

/*  UI  */
// Overlays
#import "PPModernBaseOverlayViewController.h"
#import "PPBarcodeOverlayViewController.h"
#import "PPBaseBarcodeOverlayViewController.h"
#import "PPFieldOfViewOverlayViewController.h"
#import "PPIDCardOverlayViewController.h"
#import "PPModernOverlayViewController.h"
#import "PPOcrLineOverlayViewController.h"
#import "PPSegmentScanOverlayViewController.h"
#import "PPTemplatingOverlayViewController.h"

// Permission denied
#import "PPPermissionDeniedViewController.h"

// Overlay subviews
#import "PPModernOcrResultOverlaySubview.h"
#import "PPModernViewfinderOverlaySubview.h"
#import "PPOcrResultOverlaySubview.h"
#import "PPBlurredFieldOfViewOverlaySubview.h"
#import "PPDotsOverlaySubview.h"
#import "PPFieldOfViewOverlaySubview.h"
#import "PPModernToastOverlaySubview.h"
#import "PPOcrLineOverlaySubview.h"
#import "PPToastOverlaySubview.h"
#import "PPViewfinderOverlaySubview.h"
#import "PPFaceLivenessOverlaySubview.h"
#import "PPTapToFocusOverlaySubview.h"

// Include Recognizers in PhotoPay
#import "PPPhotoPayRecognizers.h"
#import "PPPhotoPayOcrParserFactories.h"

#import "PPLivenessRecognizerSettings.h"
#import "PPLivenessRecognizerResult.h"

#endif
