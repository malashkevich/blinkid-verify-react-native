//
//  UIImage+Utils.m
//  IDVerifyFramework
//
//  Created by Jura on 05/03/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

#import "UIImage+Utils.h"

#import "PPIdVerifySettings.h"

@implementation UIImage (Utils)

+ (UIImage *)pp_imageNamed:(NSString *)name type:(NSString *)type inBundle:(NSBundle *)bundle {
    NSString *imagePath = [bundle pathForResource:name ofType:type];
    return [UIImage imageWithContentsOfFile:imagePath];
}

+ (UIImage *)pp_imageInResourcesBundleNamed:(NSString *)imageName {
    return [UIImage imageNamed:imageName inBundle:[PPIdVerifySettings sharedSettings].resourcesBundle compatibleWithTraitCollection:nil];
}

@end
