//
//  PPKeyboardConfusionsTest.m
//  IDVerifyFramework
//
//  Created by Jura on 30/03/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "PPKeyboardConfusions.h"

@interface PPKeyboardConfusionsTest : XCTestCase

@end

@implementation PPKeyboardConfusionsTest

- (void)testThatItFindsCorrectConfusions {

    PPKeyboardConfusions *confusions = [[PPKeyboardConfusions alloc] initWithConfusions:
        @[
          @[@"C", @"Č", @"Ć"],
          @[@"S", @"Š"]]];

    NSArray<NSString *> *confList = [confusions confusionsForString:@"Č"];

    NSLog(@"%@", confList);
}

@end
