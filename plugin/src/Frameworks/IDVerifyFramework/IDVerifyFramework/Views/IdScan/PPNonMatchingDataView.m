//
//  PPNonMatchingDataView.m
//  LivenessTest
//
//  Created by Jura on 06/12/2016.
//  Copyright © 2017 Microblink Ltd.. All rights reserved.
//

#import "PPNonMatchingDataView.h"

#import "PPIdVerifySettings.h"
#import "PPLocalization.h"

@interface PPNonMatchingDataView ()

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@property (weak, nonatomic) IBOutlet UIButton *scanAgainButton;

@end

@implementation PPNonMatchingDataView

+ (instancetype)allocFromNibInBundle:(NSBundle *)bundle {

    NSArray *nibViews = [bundle loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil];
    UIView *view = [nibViews objectAtIndex:0];

    NSAssert([view isKindOfClass:[self class]], @"Specified view is not of correct class %@", NSStringFromClass([self class]));

    PPNonMatchingDataView *dataview = (PPNonMatchingDataView *)view;

    return dataview;
}

- (void)awakeFromNib {
    [super awakeFromNib];

    self.layer.cornerRadius = 10.0f;
    self.scanAgainButton.layer.cornerRadius = 6.0f;

    self.scanAgainButton.titleLabel.font =
        [[PPIdVerifySettings sharedSettings].uiSettings fontWithWeight:UIFontWeightRegular pointSizeDiff:1.0f];

    [self.scanAgainButton
        setTitle:PP_LOCALIZED_CAMERA(@"scanning.nonmatching.buttontitle", @"The front and back side of the ID don’t match.")
        forState:UIControlStateNormal];
    self.statusLabel.text = PP_LOCALIZED_CAMERA(@"scanning.nonmatching.message", @"Scan again");

    self.statusLabel.font = [[PPIdVerifySettings sharedSettings].uiSettings fontWithWeight:UIFontWeightLight pointSizeDiff:2.0f];
}

- (IBAction)scanAgainTapped:(id)sender {
    [self.delegate nonMatchingDataViewScanAgainTapped:self];
}

@end
