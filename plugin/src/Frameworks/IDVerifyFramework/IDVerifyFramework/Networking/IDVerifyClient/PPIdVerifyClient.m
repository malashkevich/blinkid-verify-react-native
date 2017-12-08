//
//  PPIdVerifyClient.m
//  IDVerify
//
//  Created by Jura on 27/02/2017.
//  Copyright © 2017 Microblink Ltd.. All rights reserved.
//

#import "PPIdVerifyClient.h"

#import "NSDictionary+Utils.h"
#import "PPConfiguration.h"

static NSString *const verificationUrlEndpoint = @"/verification";
static NSString *const checkSignatureUrlEndpoint = @"/check-signature";
static NSString *const getConfigurationUrlEndpoint = @"/client/configuration";

@interface PPIdVerifyClient ()

@property (nonatomic) NSURLSession *session;

@end

@implementation PPIdVerifyClient

- (instancetype)initWithUrl:(NSURL *)url {
    return [self initWithUrl:url session:[NSURLSession sharedSession]];
}

- (instancetype)initWithUrl:(NSURL *)url session:(NSURLSession *)session {
    self = [super init];
    if (self) {
        _url = url;
        _session = session;
    }
    return self;
}

- (void)verifyResult:(PPIdVerifyResult *)result completion:(nonnull void (^)(PPIdVerifyResponse *_Nonnull, NSError *_Nonnull))completion {

    [[self.session dataTaskWithRequest:[self verifyRequestForData:[result dictionary]]
                     completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {

                         PPIdVerifyResponse *idVerifyResponse = nil;

                         NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                         if (httpResponse.statusCode == 200 && error == nil) {

                             NSError *errorJsonConversion;
                             NSMutableDictionary *json =
                                 [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&errorJsonConversion];

                             if (errorJsonConversion == nil) {
                                 idVerifyResponse = [[PPIdVerifyResponse alloc] initWithDictionary:json];
                             }
                         }

                         dispatch_async(dispatch_get_main_queue(), ^{
                             completion(idVerifyResponse, error);
                         });

                     }] resume];
}

- (void)checkSignature:(PPIdVerifyResult *)result completion:(nonnull void (^)(PPCheckSignatureResponse *_Nonnull, NSError *_Nonnull))completion {
    [[self.session dataTaskWithRequest:[self checkSignatureRequestForData:[result dictionary]]
                     completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {

                         PPCheckSignatureResponse *checkSignatureResponse = nil;

                         NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                         if (httpResponse.statusCode == 200 && error == nil) {

                             NSError *errorJsonConversion;
                             NSMutableDictionary *json =
                                 [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&errorJsonConversion];

                             if (errorJsonConversion == nil) {
                                 checkSignatureResponse = [[PPCheckSignatureResponse alloc] initWithDictionary:json];
                             }
                         }

                         dispatch_async(dispatch_get_main_queue(), ^{
                             completion(checkSignatureResponse, error);
                         });

                     }] resume];
}

- (void)getConfigurationForType:(NSString *)typeId completion:(nonnull void (^)(PPGetConfigurationResponse *_Nonnull, NSError *_Nonnull))completion {
    [[self.session dataTaskWithRequest:[self getConfigurationRequestForType:typeId]
                     completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {

                         PPGetConfigurationResponse *getConfigurationResponse = nil;

                         if (error == nil) {
                             NSError *errorJsonConversion;
                             NSMutableDictionary *json =
                             [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&errorJsonConversion];

                             if (errorJsonConversion == nil) {
                                 getConfigurationResponse = [[PPGetConfigurationResponse alloc] initWithDictionary:json];
                             }
                         }

                         dispatch_async(dispatch_get_main_queue(), ^{
                             completion(getConfigurationResponse, error);
                         });

                     }] resume];
}

- (void)getConfigurationWithCompletion:(nonnull void (^)(NSArray<PPGetConfigurationResponse *> *_Nonnull, NSError *_Nonnull))completion {

    NSMutableArray<PPGetConfigurationResponse *> *configurationResponses = [[NSMutableArray<PPGetConfigurationResponse *> alloc] init];
    __block NSError *configError = nil;
    dispatch_group_t serviceGroup = dispatch_group_create();

    for (NSString *configType in [PPConfiguration configurationTypes]) {
        dispatch_group_enter(serviceGroup);
        [[self.session dataTaskWithRequest:[self getConfigurationRequestForType:configType]
                         completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {

                             PPGetConfigurationResponse *getConfigurationResponse = nil;

                             if (error == nil) {
                                 NSError *errorJsonConversion;
                                 NSMutableDictionary *json =
                                     [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&errorJsonConversion];

                                 if (errorJsonConversion == nil) {
                                     getConfigurationResponse = [[PPGetConfigurationResponse alloc] initWithDictionary:json];
                                     [configurationResponses addObject:getConfigurationResponse];
                                 }
                             } else {
                                 configError = error;
                             }

                             dispatch_group_leave(serviceGroup);
                             
                         }] resume];
    }

    dispatch_group_notify(serviceGroup, dispatch_get_main_queue(), ^{
        completion([configurationResponses copy], configError);
    });
}

- (NSURLRequest *)verifyRequestForData:(NSDictionary *)data {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[self verificationEndpoint]];

    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

    NSError *error;
    NSData *postdata = [NSJSONSerialization dataWithJSONObject:data options:0 error:&error];

    [request setHTTPBody:postdata];

    return request;
}

- (NSURLRequest *)checkSignatureRequestForData:(NSDictionary *)data {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[self checkSignatureEndpoint]];

    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

    NSError *error;
    NSData *postdata = [NSJSONSerialization dataWithJSONObject:data options:0 error:&error];

    [request setHTTPBody:postdata];

    return request;
}

- (NSURLRequest *)getConfigurationRequestForType:(NSString *)typeId {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[[self getConfigurationEndpoint] URLByAppendingPathComponent:typeId]];
    [request setHTTPMethod:@"GET"];
    return request;
}

- (NSURLRequest *)getConfigurationRequest{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[self getConfigurationEndpoint]];
    [request setHTTPMethod:@"GET"];
    return request;
}


#pragma mark - Endpoints

- (NSURL *)checkSignatureEndpoint {
    return [self.url URLByAppendingPathComponent:checkSignatureUrlEndpoint];
}

- (NSURL *)verificationEndpoint {
    return [self.url URLByAppendingPathComponent:verificationUrlEndpoint];
}

- (NSURL *)getConfigurationEndpoint {
    return [self.url URLByAppendingPathComponent:getConfigurationUrlEndpoint];
}

@end
