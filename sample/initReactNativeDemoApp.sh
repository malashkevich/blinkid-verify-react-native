#!/bin/bash

# remove any existing code
rm -rf BlinkIDVerifyReactNativeDemo

# create a sample application
react-native init --version="0.48.3" BlinkIDVerifyReactNativeDemo

# enter into demo project folder
cd BlinkIDVerifyReactNativeDemo

# install npm package
echo "Installing blinkid-verify-react-native module"
npm i --save ../../plugin

npm install

# link package with project
echo "Linking blinkid-verify-react-native module with project"
react-native link blinkid-verify-react-native

# enter into android project folder
cd android

# add the flatDir repository which contains libraries to build.gradle
cat > build.gradle << EOF
// Top-level build file where you can add configuration options common to all sub-projects/modules.

buildscript {
    repositories {
        jcenter()
    }
    dependencies {
        classpath 'com.android.tools.build:gradle:2.2.3'

        // NOTE: Do not place your application dependencies here; they belong
        // in the individual module build.gradle files
    }
}

allprojects {
    repositories {
        mavenLocal()
        jcenter()
        maven {
            // All of React Native (JS, Obj-C sources, Android binaries) is installed from npm
            url "\$rootDir/../node_modules/react-native/android"
        }
        flatDir{
            dirs "\$rootDir/../node_modules/blinkid-verify-react-native/src/android/lib"
        }
    }
}
EOF

# Change the default buildTools, SDK and support library versions.
buildGradle=./app/build.gradle
sed -i '' -E 's/compileSdkVersion [0-9]+/compileSdkVersion 25/' $buildGradle
sed -i '' -E 's/buildToolsVersion ".+"/buildToolsVersion "25.0.3"/' $buildGradle
sed -i '' -E 's/targetSdkVersion [0-9]+/targetSdkVersion 25/' $buildGradle
sed -i '' -E 's/compile "com.android.support:appcompat-v7:.+"/compile "com.android.support:appcompat-v7:25.3.1"/' $buildGradle

manifest=./app/src/main/AndroidManifest.xml
sed -i '' -E 's/android:targetSdkVersion="[0-9]+"(.+)/android:targetSdkVersion="25"\1/' $manifest

# go to react native root project
cd ..

# remove index.js
rm -f index.js

# remove index.ios.js
rm -f index.ios.js

# remove index.android.js
rm -f index.android.js

# create demp app index.js with content
cat > index.js << EOF
/**
 * Sample React Native App for BlinkIDVerify
 */

 /**
* Use these recognizer types
* Available: RECOGNIZER_MRTD_COMBINED
* RECOGNIZER_MRTD_COMBINED - scans face image from the document and Machine Readable Zone from Machine Readable Travel Document
*/

/**
 * There are several options you need to pass to scan function to add recognizers and to obtain the image and results:
 * enableBeep : if it is set to true, successful scan will play a sound
 * shouldReturnCroppedImages : if true, cropped document images in the recognition process will be returned
 * shouldReturnFaceImages : if true, cropped face image from the document and selfie face image will be returned
 * combinedRecognizer : combined recognizer that will be used for document scan
 */

/**
 * Scan method returns scan fields in JSON format and image(s) (image is returned as Base64 encoded JPEG)
 * scanningResult.resultImageCroppedFront : cropped front side document image
 * scanningResult.resultImageCroppedBack : cropped back side document image
 * scanningResult.resultImageCroppedIDFace : cropped face image from the document
 * scanningResult.resultImageCroppedSelfieFace : cropped selfie face image
 * scanningResult.recognitionResult : document scanning result in JSON format
 */


import React, { Component } from 'react';
import {BlinkIDVerify, MRTDKeys} from 'blinkid-verify-react-native';
import {
  AppRegistry,
  Platform,
  StyleSheet,
  Text,
  View,
  Image,
  ScrollView,
  Button
} from 'react-native';

// Microblink SDK license key bound to application ID for Android or iOS.
// To obtain valid license keys, please contact us at http://help.microblink.com
const licenseKeyMicroblinkSDK = Platform.select({
      // license key for MicroBlink SDK

      // iOS license key for applicationID: org.reactjs.native.example.BlinkIDVerifyReactNativeDemo
      ios: 'KMILWENV-KHVRKRKH-T65BCGEI-JKIQZLZO-RYTHLYX3-AANVYSLK-TM7CI4UE-YHBC33C6',
      // android license key for applicationID: com.blinkidverifyreactnativedemo
      android: 'LDABUFAJ-7YSPXWZ4-ODMJDEDN-UT4DBX4V-57M5TWOZ-3HM5TWOZ-3HM5TWOZ-3HM3ABKY'
})

// License key for the liveness recognizer which is used for user liveness recognition and taking the selfie picture
// If the license key is not set, liveness recognition will work, but it will stop after 60 seconds
const licenseKeyLivenessRecognizer = Platform.select({
      // license key for liveness recognizer

      // iOS license key for applicationID: org.reactjs.native.example.BlinkIDVerifyReactNativeDemo
      ios: '<ios_license_key>',
      // android license key for applicationID: com.blinkidverifyreactnativedemo
      android: '<android_license_key>'

})

var renderIf = function(condition, content) {
  if (condition) {
      return content;
  } 
  return null;
}

export default class BlinkIDVerifyReactNative extends Component {
  constructor(props) {
    super(props);
    this.state = {showImageCroppedFront: false,
                  resultImageCroppedFront: '',
                  showImageCroppedBack: false,
                  resultImageCroppedBack: '',
                  showImageIDFace: false,
                  resultImageCroppedIDFace: '',
                  showImageSelfieFace: false,
                  resultImageCroppedSelfieFace: '',
                  results: '',
                  licenseKeyErrorMessage: ''};
  }
  async scan() {
    try {
      const scanningResult = await BlinkIDVerify.scan(
        licenseKeyMicroblinkSDK,
        {
          enableBeep: true,
          shouldReturnCroppedImages: true,
          shouldReturnFaceImages: true,
          combinedRecognizer: BlinkIDVerify.RECOGNIZER_MRTD_COMBINED
        },
        licenseKeyLivenessRecognizer
      )
      if (scanningResult) {
        let recognitionResult = scanningResult.recognitionResult;
        let resultFormattedText = "";
        let fieldDelim = ";\n";

        resultFormattedText += "Result type: " + recognitionResult.resultType + fieldDelim;
        if (recognitionResult.resultType == "MRTD result") {
              var fields = recognitionResult.fields
              // MRTDKeys are keys from keys/mrtd_keys.js
              resultFormattedText += /** Personal information */
                                      "Family name: " + fields[MRTDKeys.PrimaryId] + fieldDelim +
                                      "First name: " + fields[MRTDKeys.SecondaryId] + fieldDelim +
                                      "Date of birth: " + fields[MRTDKeys.DateOfBirth] + fieldDelim +
                                      "Sex: " + fields[MRTDKeys.Sex] + fieldDelim +
                                      "Nationality: " + fields[MRTDKeys.Nationality] + fieldDelim +
                                      "Date of Expiry: " + fields[MRTDKeys.DateOfExpiry] + fieldDelim +
                                      "Document Code: " + fields[MRTDKeys.DocumentCode] + fieldDelim +
                                      "Document Number: " + fields[MRTDKeys.DocumentNumber] + fieldDelim +
                                      "Issuer: " + fields[MRTDKeys.Issuer] + fieldDelim +
                                      "Opt1: " + fields[MRTDKeys.Opt1] + fieldDelim +
                                      "Opt2: " + fields[MRTDKeys.Opt2] + fieldDelim;

        }
        resultFormattedText += '\n';
        // image is returned as base64 encoded JPEG, we expect resultImageCorppedFront and resultImageCorppedBack because we have activated obtaining of 
        // cropped images (shouldReturnCroppedImages: true)
        this.setState({showImageCroppedFront: scanningResult.resultImageCroppedFront, resultImageCroppedFront: 'data:image/jpg;base64,' + scanningResult.resultImageCroppedFront,
                       showImageCroppedBack: scanningResult.resultImageCroppedBack, resultImageCroppedBack: 'data:image/jpg;base64,' + scanningResult.resultImageCroppedBack,
                       showImageSelfieFace: scanningResult.resultImageCroppedSelfieFace, resultImageCroppedSelfieFace: 'data:image/jpg;base64,' + scanningResult.resultImageCroppedSelfieFace,
                       showImageIDFace: scanningResult.resultImageCroppedIDFace, resultImageCroppedIDFace: 'data:image/jpg;base64,' + scanningResult.resultImageCroppedIDFace, results: resultFormattedText});}
    } catch(error) {
        this.setState({ showImageCroppedFront: false, resultImageCroppedFront: '', showImageCroppedBack: false, resultImageCroppedBack: '', showImageIDFace: false, resultImageCroppedIDFace: '', showImageSelfieFace: false, resultImageCroppedSelfieFace: '', results: error.message});
    }
    
  }

  render() {
    let displayImageCroppedFront = this.state.resultImageCroppedFront;
    let displayImageCroppedBack = this.state.resultImageCroppedBack;
    let displayImageIDFace = this.state.resultImageCroppedIDFace;
    let displayImageSelfieFace = this.state.resultImageCroppedSelfieFace;
    let displayFields = this.state.results;
    let licenseKeyErrorMessage = this.state.licenseKeyErrorMessage;
    return (
      <View style={styles.container}>
        <Text style={styles.label}>MicroBlink Ltd</Text>
        <View style={styles.buttonContainer}>
          <Button
            onPress={this.scan.bind(this)}
            title="Scan"
            color="#87c540"
          />
        </View>
        <ScrollView
          automaticallyAdjustContentInsets={false}
          scrollEventThrottle={200}y> 
          {renderIf(this.state.showImageCroppedFront,
              <View style={styles.imageContainer}>
              <Image
                resizeMode='contain'
                source={{uri: displayImageCroppedFront, scale: 3}} style={styles.imageResult}/>
              </View>
          )}
          {renderIf(this.state.showImageCroppedBack,
              <View style={styles.imageContainer}>
              <Image
                resizeMode='contain'
                source={{uri: displayImageCroppedBack, scale: 3}} style={styles.imageResult}/>
              </View>
          )}
          {renderIf(this.state.showImageIDFace,
              <View style={styles.imageContainer}>
              <Image
                resizeMode='contain'
                source={{uri: displayImageIDFace, scale: 3}} style={styles.imageResult}/>
              </View>
          )}
          {renderIf(this.state.showImageSelfieFace,
              <View style={styles.imageContainer}>
              <Image
                resizeMode='contain'
                source={{uri: displayImageSelfieFace, scale: 3}} style={styles.imageResult}/>
              </View>
          )}
          <Text style={styles.results}>{displayFields}</Text>
        </ScrollView>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    flexDirection: 'column',
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF'
  },
  label: {
    fontSize: 20,
    textAlign: 'center',
    marginTop: 50
  },
  buttonContainer: {
    margin: 20
  },
  imageContainer: {
    flexDirection: 'row',
    justifyContent: 'center'
  },
  results: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  imageResult: {
    flex: 1,
    flexShrink: 1,
    height: 200,
    alignItems: 'center',
    justifyContent: 'center',
    margin: 10
  },
});

AppRegistry.registerComponent('BlinkIDVerifyReactNativeDemo', () => BlinkIDVerifyReactNative);
EOF

# use the same index.js file for Android and iOS
cp index.js index.ios.js
cp index.js index.android.js

echo "Go to React Native project folder: cd BlinkIDVerifyReactNativeDemo"
echo "To run on Android execute: react-native run-android"
echo "To run on iOS execute: cd ios and open BlinkIDVerifyReactNativeDemo.xcodeproj"
echo "Then make sure that Microblink.framework is added in embeded frameworks under General for 'BlinkIDVerifyReactNativeDemo' target"
echo "IDVerify.bundle and MicroBlink.bundle are added to Copy Bundle Resources under Build Phases for 'BlinkIDVerifyReactNativeDemo'"
echo "After that set your development team and add Privacy - Camera Usage Description key to Your info.plist file and press run"
