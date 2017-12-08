//
//  PPLocalization.h
//  IDVerifyFramework
//
//  Created by Jura on 12/03/2017.
//  Copyright © 2017 MicroBlink. All rights reserved.
//

// uncomment this to debug your localization files visually in the app

#import "PPIdVerifySettings.h"

#define PP_DEBUG_LOCALIZATION

#if !defined PP_DEBUG_LOCALIZATION
#define PP_LOCALIZED(key, tbl, default)                                                                                                \
    NSLocalizedStringWithDefaultValue(key, tbl, [[[PPIdVerifySettings sharedSettings] localizationSettings] bundleForCurrentLanguage], \
                                      default, nil)
#else
#define PP_LOCALIZED(key, tbl, default)                                                                                                \
    NSLocalizedStringWithDefaultValue(key, tbl, [[[PPIdVerifySettings sharedSettings] localizationSettings] bundleForCurrentLanguage], \
                                      ([NSString stringWithFormat:@"[[%@]]", key]), nil)

#endif

#define PP_LOCALIZED_CAMERA(key, default) \
    PP_LOCALIZED(key, [[[PPIdVerifySettings sharedSettings] localizationSettings] tableForCameraStrings], default)

#define PP_LOCALIZED_RESULT(key, default) \
    PP_LOCALIZED(key, [[[PPIdVerifySettings sharedSettings] localizationSettings] tableForResultStrings], default)
