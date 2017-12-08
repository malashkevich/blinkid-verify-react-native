//
//  PPIdScanViewStateUpdater.m
//  LivenessTest
//
//  Created by Jura on 02/12/2016.
//  Copyright © 2017 Microblink Ltd.. All rights reserved.
//

#import "PPIdScanViewStateUpdater.h"

#import "PPLocalization.h"

#import "UIImage+Utils.h"

@interface PPIdScanViewStateUpdater () <PPViewfinderViewDelegate>

@property (nonatomic) PPScanningState currentState;

@property (nonatomic) PPScanningState pendingState;

@property (nonatomic) BOOL updateInProgress;

@end

@implementation PPIdScanViewStateUpdater

- (instancetype)initWithViewfinder:(PPViewfinderView *)viewfinderView
                       statusLabel:(UILabel *)label
                   statusImageView:(UIImageView *)imageView {

    self = [super init];
    if (self) {
        _viewfinderView = viewfinderView;
        _viewfinderView.delegate = self;

        _statusLabel = label;
        _statusImageView = imageView;
    }
    return self;
}

- (void)updateForState:(PPScanningState)state {

    self.pendingState = state;

    [self startUpdate];
}

- (void)startUpdate {

    if (self.pendingState == self.currentState) {
        return;
    }

    if (self.updateInProgress) {
        return;
    }

    self.currentState = self.pendingState;

    switch (self.currentState) {
        case PPScanningStateIdBackSide:
            [self setupBackSideScanning];
            self.updateInProgress = YES;
            [self.viewfinderView animateHelp];
            break;
        case PPScanningStateIdFrontSide:
            [self setupFrontSideScanning];
            self.updateInProgress = YES;
            [self.viewfinderView animateHelp];
            break;
        case PPScanningStateDone:
            [self setupScannigDone];
            break;
        case PPScanningStateUndefined:
            [self setupUndefined];
            break;
        case PPScanningStateNonMatchingData: {
            NSAssert(false, @"Scan state updater does not know how to handle non matching data!");
            @throw [[NSException alloc] initWithName:NSInternalInconsistencyException
                                              reason:@"Scan state updatear does not know how to handle non matching data!"
                                            userInfo:nil];
        }
    }
}

- (void)setupFrontSideScanning {
    self.statusLabel.text = PP_LOCALIZED_CAMERA(@"scanning.status.idfront", @"Place the front side of the ID card in the frame and wait for automatic scan.");
    self.statusImageView.image = [UIImage pp_imageInResourcesBundleNamed:@"icFrontSide"];
    self.viewfinderView.helpLabel.text = PP_LOCALIZED_CAMERA(@"scanning.help.idfront", @"ID card front side");
    self.viewfinderView.helpImageView.image = self.statusImageView.image;
}

- (void)setupBackSideScanning {
    self.statusLabel.text = PP_LOCALIZED_CAMERA(@"scanning.status.idback", @"Place the back side of the ID card in the frame and wait for automatic scan.");
    self.statusImageView.image = [UIImage pp_imageInResourcesBundleNamed:@"icBackSide"];
    self.viewfinderView.helpLabel.text = PP_LOCALIZED_CAMERA(@"scanning.help.idback", @"ID card back side");
    self.viewfinderView.helpImageView.image = self.statusImageView.image;
}

- (void)setupUndefined {
    self.statusLabel.text = @"[[[Undefined]]]";
    self.statusImageView.image = [UIImage pp_imageInResourcesBundleNamed:@"icFrontSide"];
    self.viewfinderView.helpLabel.text = @"[[[Undefined]]]";
    self.viewfinderView.helpImageView.image = self.statusImageView.image;
}

- (void)setupScannigDone {
    self.statusLabel.text = @"[[[Scanning done]]]";
    self.statusImageView.image = [UIImage pp_imageInResourcesBundleNamed:@"icFrontSide"];
    self.viewfinderView.helpLabel.text = @"[[[Scanning done]]]";
    self.viewfinderView.helpImageView.image = self.statusImageView.image;
}

#pragma mark - PPViewfinderViewDelegate

- (void)viewfinderViewDidFinishAnimation:(PPViewfinderView *)viewfinder {
    self.updateInProgress = NO;
    [self startUpdate];
}

@end
