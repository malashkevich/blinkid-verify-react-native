//
//  PPCroIDCombinedRecognizerResult+Test.m
//  IDVerify
//
//  Created by Jura on 28/02/2017.
//  Copyright © 2017 Microblink. All rights reserved.
//

#import "PPCroIDCombinedRecognizerResult+Test.h"

@implementation PPCroIDCombinedRecognizerResult (Test)

- (instancetype)initWithFirstName:(NSString *)firstName
                         lastName:(NSString *)lastName
               identityCardNumber:(NSString *)identityCardNumber
                              sex:(NSString *)sex
                      nationality:(NSString *)nationality
                      dateOfBirth:(NSDate *)dateOfBirth
             documentDateOfExpiry:(NSDate *)documentDateOfExpiry
                          address:(NSString *)address
                 issuingAuthority:(NSString *)issuingAuthority
              documentDateOfIssue:(NSDate *)documentDateOfIssue
                              oib:(NSString *)oib
                     mrtdVerified:(BOOL)mrtdVerified
                     matchingData:(BOOL)matchingData
                      nonResident:(BOOL)nonResident
                documentBilingual:(BOOL)documentBilingual
                        signature:(NSData *)signature
                 signatureVersion:(NSString *)signatureVersion
                        faceImage:(NSData *)faceImage {

    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *types = [[NSMutableDictionary alloc] init];

    [PPRecognizerResult addString:firstName forKey:@"CroIDCombinedFirstName"  valueDict:dict typeDict:types];
    [PPRecognizerResult addString:lastName forKey:@"CroIDCombinedLastName"  valueDict:dict typeDict:types];
    [PPRecognizerResult addString:identityCardNumber forKey:@"CroIDCombinedDocumentNumber"  valueDict:dict typeDict:types];
    [PPRecognizerResult addString:sex forKey:@"CroIDCombinedSex"  valueDict:dict typeDict:types];
    [PPRecognizerResult addString:nationality forKey:@"CroIDCombinedCitizenship"  valueDict:dict typeDict:types];
    [PPRecognizerResult addDate:dateOfBirth forKey:@"CroIDCombinedDateOfBirth"  valueDict:dict typeDict:types];
    [PPRecognizerResult addDate:documentDateOfExpiry forKey:@"CroIDCombinedDateOfExpiry"  valueDict:dict typeDict:types];
    [PPRecognizerResult addString:address forKey:@"CroIDCombinedFullAddress"  valueDict:dict typeDict:types];
    [PPRecognizerResult addString:issuingAuthority forKey:@"CroIDCombinedIssuedBy"  valueDict:dict typeDict:types];
    [PPRecognizerResult addDate:documentDateOfIssue forKey:@"CroIDCombinedDateOfIssue"  valueDict:dict typeDict:types];
    [PPRecognizerResult addString:oib forKey:@"CroIDCombinedOIB"  valueDict:dict typeDict:types];
    [PPRecognizerResult addBool:mrtdVerified forKey:@"CroIDCombinedMRTDVerified"  valueDict:dict typeDict:types];
    [PPRecognizerResult addBool:matchingData forKey:@"documentBothSidesMatch"  valueDict:dict typeDict:types];
    [PPRecognizerResult addBool:nonResident forKey:@"CroIDCombinedForNonResident"  valueDict:dict typeDict:types];
    [PPRecognizerResult addBool:documentBilingual forKey:@"CroIDCombinedDocumentBilingual"  valueDict:dict typeDict:types];
    [PPRecognizerResult addData:signature forKey:@"signature"  valueDict:dict typeDict:types];
    [PPRecognizerResult addString:signatureVersion forKey:@"version" valueDict:dict typeDict:types];
    [PPRecognizerResult addData:faceImage forKey:@"Face.Image"  valueDict:dict typeDict:types];

    self = [super initWithElements:dict resultElementTypes:types];
    if (self) {
    }
    return self;
}

+ (PPCroIDCombinedRecognizerResult *)dinoResult {

    NSString *firstName = @"DINO";
    NSString *lastName = @"GUŠTIN";
    NSString *identityCardNumber = @"112251465";
    NSString *nationality = @"HRV";
    NSString *address = @"KARLOVAC, KARLOVAC ĐUKE BENCETIČA 2";
    NSString *oib = @"40568374465";
    NSString *sex = @"M";
    NSString *issuingAuthority = @"PU KARLOVACKA";

    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd.MM.yyyy"];
    NSDate *dateOfBirth = [dateFormat dateFromString:@"30.09.1991"];
    NSDate *documentDateOfExpiry = [dateFormat dateFromString:@"30.10.2020"];
    NSDate *documentDateOfIssue = [dateFormat dateFromString:@"30.10.2015"];

    NSData *signature = [[NSData alloc] initWithBase64EncodedString:@"UHJvYmEx" options:0];
    NSString *signatureVersion = @"v3";
    NSData *image = [[NSData alloc] initWithBase64EncodedString:@"TGljZTE=" options:0];

    PPCroIDCombinedRecognizerResult *dinoResult = [[PPCroIDCombinedRecognizerResult alloc] initWithFirstName:firstName
                                                                                                    lastName:lastName
                                                                                          identityCardNumber:identityCardNumber
                                                                                                         sex:sex
                                                                                                 nationality:nationality
                                                                                                 dateOfBirth:dateOfBirth
                                                                                        documentDateOfExpiry:documentDateOfExpiry
                                                                                                     address:address
                                                                                            issuingAuthority:issuingAuthority
                                                                                         documentDateOfIssue:documentDateOfIssue
                                                                                                         oib:oib
                                                                                                mrtdVerified:YES
                                                                                                matchingData:YES
                                                                                                 nonResident:NO
                                                                                           documentBilingual:NO
                                                                                                   signature:signature
                                                                                            signatureVersion:signatureVersion
                                                                                                   faceImage:image];

    return dinoResult;
}

+ (PPCroIDCombinedRecognizerResult *)emirResult {

    NSString *firstName = @"EMIR";               // OK
    NSString *lastName = @"MEMIĆ";               // OK
    NSString *identityCardNumber = @"112166943"; // OK
    NSString *nationality = @"HRV";              // OK
    NSString *sex = @"M/M";                      // OK

    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd.MM.yyyy"];
    NSDate *dateOfBirth = [dateFormat dateFromString:@"08.02.1967"];          // OK
    NSDate *documentDateOfExpiry = [dateFormat dateFromString:@"07.09.2020"]; // OK

    NSData *signature = [[NSData alloc]
        initWithBase64EncodedString:@"6x3smRxwE8rTo0zSUH6gnTddoTFvnNlXGH/WqQIs3XLWlONlAQtsOevHAEBC369rra981klcf34z6xbuiI5fxA=="
                            options:0];
    NSString *signatureVersion = @"v3";
    NSData *image = [[NSData alloc]
        initWithBase64EncodedString:
            @"/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAAIBAQEBAQIBAQECAgICAgQDAgICAgUEBAMEBgUGBgYFBgYGBwkIBgcJBwYGCAsICQoKCgoKBggLDAsKDAkKCgr/"
            @"2wBDAQICAgICAgUDAwUKBwYHCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgr/wAARCAEsAPgDASIAAhEBAxEB/"
            @"8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/"
            @"8QAtRAAAgEDAwIEAwUFBAQAAAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3ODk6Q0RFRkdISUpTVFVWV"
            @"1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+"
            @"Pn6/8QAHwEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/"
            @"8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSExBhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElKU1RVV"
            @"ldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+"
            @"Pn6/9oADAMBAAIRAxEAPwD9m5Z53dY2cKgBKnHBH92mBlEflQ5QE5UA/dPpTbWRnt2hm++jfMQO/tSxEbmRwee/v616iVzzFN3Jcu8RDO2SeQ3anQo0MQ/"
            @"eL1+cL/CfUVEsbNtQyEkH5ix+9SxhQxXHcgj1q4x11M6tUn88xnzllOF+8B3o+2kSmaGMjjJGeP8A9dVI3EamF25zx9KWJ8BoyCTjP19qqSa2Odzb2LU9/"
            @"NKnmROQuMkDvUNrflkcSuenGe1U1uvs5eMEgKe/as/"
            @"VNattLhN7cXKrHnlicAfWmrcooTvKxp3+plCXt2ydo3jHWsrVfGWj6ahu9Q1OGILx80oya8c+"
            @"NX7UMOjKdG8GzLJKVIMw6Ke9fOXir4leKdau5Lu71aVgX4UMcc+1cdXEqHuo2g2mfYGuftB+BbF2li1AO0ecIjjmuG1z9sHR7YSCz0t5GUnAE4yw/"
            @"Kvl+DxBqKO0ks5OF/irnPFeqX0VwJrVpMH7w38VisTJl87Pqi7/"
            @"AGwGu4gdMRUaLDMrPnA9DzyazJP2tdZZyZNUjGTlAvB+nWvlK38QXIYqs2wscMB19zUMeovHehhdM3zZXLdqp4iQJtn2La/"
            @"tUancWy3C3cZ2Y6HnNZkn7att4T1Hy9ftwYTlo2jc59+vevm3RNclW72rK4+blBXGftA63Mvh4X1vM+"
            @"6KVQVU9MmohiZ87RN5Xsfcvhr9vX4PateQW13fT2Um7BeYDaQfXmvX/D/xM8JeK4473w7rUEwZAymOTJI78V+KVn4t1Vrn/Sbggs2QSx6V13gr9pT4h/"
            @"D3Umk8PeJp7cggKvmEjHpzXTHEPqM/Zv7QN63CykhidwPU1bhuiWWRdzAcHmviD9nH/go/"
            @"pmrWVp4f+Jrss4O1r3dw31r6z8IeOtC8RadDqWjaxFNDMNyuj5BBrrhWU42OV3UrnXShfO3htqkde9SRyAZZs7RwfSs+"
            @"zukaJwW3Hse1TpM2xUXufmJpjU1fQ0I3AhIyoPYHvVSeIyXAYKPYU8fvSp3bsCopJnji3Zw2eKiSOujUVxJLiMNnad33SKq3U7S4EYwF6Ek8/"
            @"lT8sUUYyxJOfWmRLjIY4461DjodsZXILgGWImSQqSfvdz7U+C2YqJHBUdjng05FQEEoOvXNItwxXMa5IbB5rJqxummTtEph3LuIz1zgUhUCLdsVmzwOg/"
            @"OmYYAytIF5x8rc05Yig3Y3Mf4R3oW5poLFFHES7N5ank4BOT9aKjUyAFec5zj0orZaIhtXNj97EuUALbdy7Tnj3pTNHMFeM5I5Y4qQ+UAE3ABjlivBz/"
            @"hTvIaBisMYIbnNOyR490RKTcfOEOR3zTtrSLkDkHOcU+RxGoydpPWmpKr/"
            @"AOqPb86a3OecrsryzIUOU5U8kc1FJdStbNLAQGxj3qa6dLZGbABbse5rgvil8W9C+"
            @"HmmPcX08bXJHyQg81TkkRsavjTx7o3gyxk1DxAxULHkDjJPavlz4yftI6x42v5NG0p3trMMQFTv+NYHxZ+M2seMHnvtYvG8tm/"
            @"dxDI47Vwnh+VLqKXUbkks5OwAVwVqrvox01rcbrWtzzTC3ikPJ5fdk+"
            @"9VI7vepDnJ3E5POMCpriGOCVRNtOeSce9JBbRJKQUO05wPXPevPd3K7OlNIrYlndi7nB+6AKH0q3uYZXuZSXCZVRVxRDDIA2QF9O/tRFPLO5itYiCxwQ/"
            @"YVS0JR55fxvDM0mMFm2txUUEawASFSXU/"
            @"KxrpPFGmw2l4sYVTu+8M+9Zkenz3DZVQFQ4z61otTWJBpmsuL7yt21s9xR4v0y31zSLmymUP5kLbCP72DhvwNXk0+"
            @"Nfnt413gfMzdadcWlxJZvGiYYDIYLnHtWcf4gL4j5hv50t7xrSFHLRuwJK9wafbWDalAZmt2R43zlhwfxrU8daBf6Z4nvFaBhG0pwxXGKoWBvUYxPIzxngKT"
            @"XZdCehcivWjgWNJDG4fd04PtXsH7Pf7Xnjf4Q61axX+qTT2Eco8yzPI2+30rx2a081hMqPlegPAqeO1ktUG6BQRnnHNK7jsyZQTP1y+"
            @"Af7TXgP426alx4e1RRPGg+0Wr/K6E+3evV7S9WQKA6sMcgHpX48/AH40eJvhP4kj8Q6FMVO9Umj3cSLnnNfpr8A/"
            @"jpoHxa8EWut6ZcIJiFFzGrZKN0P61205qRyyXLK567lIgAMgN3qOWNpG3JznhVNRWt4siZ6+"
            @"gJqwJXJLHj29K0kaxlZkbxYQLGwz0LHsfSoZkkMRTH3Ty3rVgN5ilAgKrzj3qCQsVIYE85x6UpHbSmiEW+Y8hM5OQd3Spbe0BPz/"
            @"ACk+lKHynzMuQOg4o81ni3RISR2rCR1xbTJYoIY4yFQZLZLtyRThIjpky7mHHP8A9aoH3MfnBBb+HPSpEj8mMSPFtDevApJNm4C1dsukiHd1DMB/"
            @"9eikjuUt1MiQjcD8rt8wz9KKvnFypl9B58fkqcFTj61ctj5UXzvnbUSRq0HmImApJDdz7VC900qgxvgHnBrQ8CTaCaaRjtK556mora4dZQmAAM7jmrEKJdKZ"
            @"ZR0PWszxFc2+laTJfH5RGpZsnmntuZXTMn4jePdL8EaNJf6hMC+SIlzyTXx18VfiHe+KNfudRuNzh5PkBOQoroPjT8W9Z8Va5Ivm/uo5SEXOayPC/"
            @"heDXj9su4t2euRxmuWpO7sila+"
            @"pwk2janq9rIxycthSVq1a6BqFto6lgCehCivU9a8O6da2IWGBUHTgdaoRaFEtgFiiRh3JNc0oNsuCSPMLywgEYEqnceM46VHJpayrko2R0KmvSn8I6bPAY7m"
            @"PG/"
            @"oMVjat4Uh0yBGiLM0j8KB2rCUbGis2cWdPEWGWLPHJPapLSN0ZYwM89SK35dHvlcwy2pQkfLkcGqjaVdwvt8oFwemazTdyrI4vxvo9yl8l0kZxt6j1rAtLbV"
            @"eSIpMFjhdpr1CK0upG2z2e/"
            @"ad4BGcfWrtjBBPOZDpyx5X72zgVrz+RSdkcBpujahewhm09lwPvFcVZtdFkEP2d5SGB+"
            @"Y4r0iHwvc6yENpc7lDAYC4zUMPw6vLyZoQpDbiMetEYyctEYqp7x8t/"
            @"G2G0HiyXTQmVGCSF61wtxokcc6GBJdueTt6V9RfEf4AWF9r63d7KyEEeYBgk1RT4T6FpUaxNaKyIeCy8muqMJvdFc9j5/svCt1qOYIopCSM5I7V0H/"
            @"CptSubE3KBju4XPevbR4X0WyjxbWqK4XBIj7UyfT4liVo4wBvyqKOgp8hKqXPnPUfCGo+H3MLlkkySAelezfsbfHq++B/idbzX5ZH029McV1H/"
            @"AHeeGFanibwVpesILme0UkKfmHfNeXax4fTQtdS0khxEpzl2/"
            @"wDr1cbwBpSP1i8C+L9H8S6Na6vpF4JobiIPHIOjCurjlVx98EkdcV8QfsIftFTW7f8ACqPENw7iBc2M27gjPT2z2r7Q0m/"
            @"ju7YTSDAI65zXVF8xl8L1NBF8tFLHPPao7o7nYpgcUjSKy7UkHHc1G0buP9YMk84pyVjopS1GOitklT+"
            @"BqUzNBalMg46Y602RWhbAYHC8c01MSIrSdWPIyKzaVjvjK9iY3yfKrOckdh3pv2hmkMYOcc57imQwHy2YruGemM/5/"
            @"OrCxt5BUxjAGcyEj9Mf1qH7p1RfcrF5AGlB2D06k/"
            @"4UVIrJgo+TuHATp+XeipdjZ+"
            @"70NZbmKFf3YIDtgjstQtCYgCzcHoahhzLKEPTOGHrjvV0tHPCfMA4bkZ6V0HzMmQPOltH5bMQCMkAVwPxx8UxWPhCe3SXMt0pXGenFdnrBEzEAnABxivDvjt"
            @"PdXt3DZfatqKScDk0qrtEwR4jP4Yu7y4kvA+47shT0rr/"
            @"DksFjpqxzNskGMrikh0yKNRu3Bh3xxUE1uZLo7ckAVxpdTR7lvW7tLqDzFZsZ+UEU7SIzJp2ByS/"
            @"NUXlJgdZBjHAHvWr4WKT6YoGFIbrmk1dmkdh8djJNKAoxt74p7eHoZiGkCsy8jNalvbh3LIPlI596twWicFR17mmoRe4lJps5iXwTJqDZu5jgtwAOlYmqfCa"
            @"7huPMstSLNnIGM16hDBGDtZh8o5FLHBbeZ5gTkjPSm6UGh87PK4Ph74g8zLYUbcE7a1NG+"
            @"Gt6lyGu5flB4XbxXoaz2Qdo5osnGQc063urPO0kEnoM1P1eiiXVdjCsfClpbKYkhVAxBG0dKW50iOOULFbIDu4bb1+"
            @"tdGjQMPkZQPTvVa4h3qyAdDkHFbRSRndnlHjrSJDqchaFAT04rkr3SY3DF3JPp2FereJtLF5euFAJB4zXK65oUCyt+"
            @"646HHc1psVzHnuoRCKRrZTnB9OaptayRyfIc8YwR2rp9V0uKG7dVjyOv4fWsieA29yzlTgY471mU9DMu1jEZgeEYK8Yrzr4x+"
            @"HPIs01S1Cs7MN3HSvSL15Wd28njPA71z/xAtYrzQXiit2Y5B4FOoVGR518MPGNx4J8e2OtB3/"
            @"dTxbipIGAef0r9OPhb440zxf4ZtNXtJwFlhDYHQ5r80ZfDkyQJOsRU7uVxnAFfbv7F2vC7+"
            @"G9naXMhMtqPLKn07VVJu5FTVn0WpiZdwYEYzmnMRHHwO2arWU/"
            @"mRZZeM1PJIrDHqOK3nui6TaZXlIkOSCTnHWrEKMGURo3y9QCKrcEqykEgcinJKsgMvX5hkZqJHo02y+"
            @"vlEb3wTjgen5U25mjEJ8pCWZeSBwKgMiuu9FO3dxs/"
            @"rUhffHhnOF6KR1rKR3U9dyqvlsQXd8jtj5f8aKfMzsR8xj9AvVvxPNFQjd6mvKqIizKuPVlHBFVJbkxyM2cZPA9anF3tia2OSBkr9Kg+"
            @"xsIwGbcM5BrqSufKzdxX/eW+91O4jseK8T+LEH2/V5hbqC0ZwCB0r13Ur5dMtGZnY+o9K8n110vJ7iSIHdIxO5vrWVZ9CVueZX0t1ZybZZiwz8y1ow2yzW/"
            @"m+WoJXlgadruiK1xl5M7jziq9vfRQD7OU5Xj61zlkOs2sVvAFjPzO2S1aXhywENhGpwc5OVFZuoXaXtwsSxkAsO1b1uyQx7FGFUcGgpbFyyjUsHbgKCKtl4/"
            @"LDIBwKy1vWmhxFxjrT4yu0K83UdPemtxPc1rdDKpkjYc+pqzHbiF94cNkcjPGKzbC5jRDFknjkVO1xstihK7W+761YiK6UzTM0LLycDFILYoyuw+"
            @"ZRjFRxwSAMqyYBGc+lSQLKyeWXJH96h7EPclWAS4CMQxPTNaFwscVsSzYwuSSwqDTrZWmBLk7DlsmoNelIsncgMMnAHpVR3Ec7qFzi5aaOZRk4+"
            @"Y1ja9OrBVfDEt1Wpbx0yS5GM/dz0rF1W62M6KDtAySDTkFmZmpRRM0rySD5/lVVFc9qVsBcsylmzjBrTiuHmVo3U/Mcq/"
            @"vVPUZNvUgHOAAKg2kY0sMQmkmbd078VQ1Czju4fKyVRzhiBWtcwNcjYDn6immxx+6KcMR90cACm3zEnP6d4TguI5CGMuwfux/er3b9lC7ttGuH0hV/"
            @"17cAnpivNfDkIguxstVKbgCMds16Z8JrOCy8d28zL5atkoMcGqp/EEj6Y0zDw/"
            @"6zK44OOtWjuaP5VwRnNVdFRvsys65LYwK0FjLE5GcnI9xW8tiqbSKyQlYxuXkjFS21lGibWB4YEirAQEBih4PSnP+"
            @"9OwHaCRnb1qHsd9KWoxLQBdwUAH7uF3GpEsmeMsYSqnvnbk/hn+lOhjxGVVAGHQ7ualgiA4HLY/vGspHoQK62HkMGWMRkjg78N+AGT+tFWyGgixK20n0wv/"
            @"AKDiioR0PYprcKduF56g+3ep5ryBo9644PSovs8eGi46/"
            @"K3bHpVUxSwSlXBII4rsWx8m3czfHEqR6TLMnGQcGvJDdTCYl+"
            @"hU4B78mvTvG8zSaLLFjGFrxjxHrDospiBA5CY6g1hMI7lXWLhZGaaVtoU8GsNrqMTZjG7e33qguZdSul2xh8H1Bqxp1j9kAnuTuI7DoKwe5Zf0uyBk+"
            @"0z4zn92T0q/DcpKzgngZxWZLfAQmdcqB/"
            @"DWemvRxy8SgDqeaQHQxyKoAxlieRWjbRvLDuWJT6VyEPjO1WQl0PHetTSfGunM+"
            @"2MncBlQehprcDora3ZJDLgkEdO1Mef7RcpH5RULUcPiSwuGWGPG8gbhngVoW0MLZlLgeg9asBIlVRnafunrTvLEU4RTwwBA96nSMyMeCRjpt61PZWDXEyokH"
            @"Jbkk9BQQ9yzpVikcRklBBJyc1z/"
            @"AItnYYtoBkY5rrbtl09CmQMLyK428eO4u5ZpicBuBVRHynJapbiNz8r7yewqhd2yS5cwYbGGNdRqcVuDJJMFBJ+"
            @"U5rktS1ey064YXF4CueeRTkUYd1ZxxSFtrZVuAKz7yCTzBJuHJGFNWNU8Tac1w6xyknOdo64qkPEtveSrGCFUHnI5qAkWDYltszLk47CpV05CfOdcegIq0j2"
            @"yopU7gemKkkt2Z0mU/"
            @"L02igCPw5aQR6m0brlcggeter+GLWzhu7K9NvtkDAdOgrzKxgdb5JNuBgAECvXPCGnLNHC7BiRg5Iq6e4Hs+"
            @"iKr2EbqScYrSVE3fIDhRisnw7Ky6ciY7da0VkLQgMSD7d66HsL7RMhz8vOM+tO8qNP3pJz6ZzUauNnPzfTmkjliG4ENzxyOlZvY7qJbhjXHnFs/"
            @"QUrXGANoUqeuDg1XWMNGCPmIPUEYot4nkwHuCBu4WI8/kOaykepT+EcZGP71cKOxZf6mimPBLGWzbbWJ4kmA/"
            @"wDsj+goqEbvYDMLm3V0wOP5UkkvmxB1HIHNRlXRjGw2gcgU0FoyYu1dp8o22YfjI/"
            @"8AErdyox34rxzxHDHCxlSINvY4HpXsvipgdLmXd0U14jrjySw7JJfnWQ5+lc1bcFuYxjRZGUnn2pkiuYCpHB7ipPLbaWD5ycUySKR1wMjHQisCylLC0/"
            @"8AowzsA5IqS20ixj+R7fIxx70+"
            @"XFoPMmYAtwFFRx61a2uTcShe2M0BqKPCFteSspXaSOMVka14Tv8AT1xp8p3ryDVrVvijoekg77gKMffzWUvxk8NahIB9r5xyPWmtxe8ipp1v4jtNQM0sr8HJ"
            @"y3FehaDrl6bVWnkzu4xXN2XifTNSdGVQA68Fqu/aIoZUlhnAUdEHerE5Hc6ZqRk++3J4GDXU6VaIsIY/"
            @"ePciuB8KXkU5FzJGQB91exrrP+EgitIWd7k52fKuelBJX8Xa5bxSG1Mihgeea888U+MBpgkNuc8880viXWxe30k0sxBDH5s9K8+"
            @"1nxBDeak0EtxtwcD396Co7GL40+IPizWZ2hsGkUbsDbWA2g/ETW7hbXfIok5LMTXdRa54Z0tcSMkkkYzylU2/"
            @"aK8BaVcCxvZ4kcjDHHSgozdK+FPiG0jNxqF27OTtyTUt/wCEJrG5HmXBBD810Fr8c/"
            @"BWqK0Nhrds+4nCI4JzSXGsadrg86Cdfl+9n1oArafCYokiWUsF65NbUTcBc/w5GTWfYwRm5+dlIK8YFacIV4VErKSD8vrQR8IRz/"
            @"Z5I2Ynqpr1v4f6hHerDCoO4t3rycrAwBc4KnvXoPwola91aLLkqhGNvarp7j5j33SoEigjQcZQdKvqqrznJHQVR0hy9vEV+bAIOO1XC2Qvl/"
            @"w9WrpWwfaJYyqNkpjPYVNGoDEgjGMnIqujKx3NKQc/nUh2SDBJGOwqJI7KcveRPCyuu5igDHv1FS7baJgWcsM8hgMVWdEjjDMWAJ/"
            @"uk1CzTu+Q3yn1GP51jI9WGyLguoyG+zyFMH7sQxmiqqxJkM2fqTkf0oqDUZLLHLtmjPI6/"
            @"wC7VeZ43YPGcDJ5pqZeM7ePlxmqF7LNbafKEclkBKgdzXZsfLJ6XK/iw7tJmjQc+XzjvXh9/"
            @"drNLLbEtlXP3qf4u8deKLzUpZftkqsrlWQHABrm0ur+SKTUbosC55y3WuWpLm1LSsrmoYNzAsDj2qVTCAytnheM1lxXctym/"
            @"a2SMDmnRs8cLSOvzj5Rg1i9Rp3M3xRqbQxlLSNWYDo1cJqMviDVr94odyBiMuegrvLjSpL1nlkGKS08PSlXlKA4Pep5R3scVqnw9a50Jtp8+"
            @"4ADEbc5rnvCfg/VzrcyS6Yn71CuXXAUYr2a00KZ1L4QjbyM1N/YuxQVQF+wAp2E56GFeeH9J03T7WzZQJFjGZF9cU/TNFjmuBdyzMqr0z/"
            @"FWvNopOJ7k5x29KoX2vQaJG095ImxVPlr3NMm1zaXxDY6FZG7ul2BT+7H941jP4k1XVrpppZDGknKoOw9K4s+"
            @"IbrxBqX2m6lCxKf3SYrftLuJCHldiMdKtbCGeJNQkt7V5BEQo7no1ed604l1Nb4ArEqHO313Cu58TTpJavGswIfkAnpXFana3CRGGFFJIyDUy3KiN8KS6Bca"
            @"0iXYMqHG7zPug15j+0F4Ku7DVJTp+kRus03mJcRfxL6V6f4f00iRWlADseTtrtrXwpY62iLdWsUoHQOtVGJfNyng3wn+F8/"
            @"i3VBrEmjNp9vBYNGh39ZDt+at5rDxb4Uv3s7WTzo1lO2X1Fe3N4VmtIvJitI0RV42r8tYeoeBmZnnnVTmjl5SOYxvB/"
            @"ia71CIJcQqjhsMWrr1IlUKkStxkselc3baCdPZpjGoC8cV0Wm3P2mzDsMEDimSTyRNJFs2JuZeNvpXb/"
            @"BwSxanHGqfICA1cPJM6kyyEAAdu9XdH+JWp+DnzpFlFK7jKNKv3auI+Vn1RpUwS2RS2A2cVejbdB8z/"
            @"SvAvBX7QXiu+1q3s9WtYjC7DzRGhzk++a9y067Z7ZZChO4jbnrzXSthfaLokkiUA7GGe/WrYYeWHyCO/rVaJY3Uhc7hnPrUtoWMARCSe+RUy2OqHxD4/"
            @"MfOEU+"
            @"glzjH4VN5QSDJlT3VWUD9NzfyqFo1X5mdl5HQmljSRiDHvJzwQoP6molsetDZAiRFvOS3XPTLnP5ZoqSOGUZVywAPzfvFH8hRWTVzZNJGcibEA4weuD0qvfx"
            @"RovmDkdOlXhaxRjahxkZ471HcwNLCWKA4HGRXbVjqfJwd4njHxZ8K2OnagdUjIVLrlh6GuA1lVWxaNUBAYc56V6f8dUmkt7aBR0YkgDivJ7n7TcK0TxHAIJO"
            @"2uKUbM3+yTacD9n8uJgPU0/zG3+UoHB5PrTLG0vQ7IkJCNjBNa1r4dlnk3k4XAzUiWhDp2nPIxEgznBFWFspJJDDHCRg81uWGl2sQDGfaRxyKvCCytIi/"
            @"DYHLEUFcxh2uhtEolc4Ddqm8i2skDMR1OCfWodT8R21ju3yqVB+UA55rlta8V3V+qpbyYVydxB+7QRF3di34l8U2WnW7xo6tJz8ua8z1e6udZu/"
            @"PuJBtBOFxxVzWplW4lub6YliRglu1YNxraXFyYoWCxqfTrQXyluF44SSn3l+"
            @"771p2t680KnqfT3rDtz9oYRRyE85XHFdNoujXUUXnuoyR8qkUCe5Tu7WWSESSjJJOVrPOkShxKec/"
            @"dWuh1S2mso0dup+8azf7R8twNynIJGVqeUuIyx01YghcbWUZOa6fw5LscF0BB4Ug1kWzW+"
            @"qxgtONx42itTT4TZIu8HaDxjrVxCR1csqtZmEEcLkntWDqM0c0ZET7QeMYzV2xm3o0E2RleSTxUjafEmx5UVePSnzInlOXfSpkjO4I4alt4HhRIguAOorpbm"
            @"1t0GFjGCPvtzj3xWNcwmCUxBs5PDetL4g5RjWwlwnmADaM05vDwmdYRztGc1FMzK2MjaDzgda09PkuGRmQ4wnOafKHwnZ/"
            @"Bz4exanqo1O6H7q3wUXHU17pbRLDbKEBHTjHSuG+DNnHH4UhmkU+Yxyc9+a76EOIVOcg84rop/CKW5YtgySblOQ3Wrdv5YDEEdR/FiqaTBFDNlMjgkZ/"
            @"SrFo4ky6jIYdcUS2N4y1RLJ5k3yQsWGecuAKVElYeWuGK9lDMP5CiTasOZFyQeAecmiNzcqPMgjyvbyWx/PFRLY9Oi+bQZLcQwZ814UJ/"
            @"hLBSfzNFTqUtAChETdT5EaDP1yKKzbsdTVmUVlidQwPIGBn0p/"
            @"nBoDGqnj3rNs5WMR+"
            @"cD58DNTiSSQkZ4BwAO9ejVjqfH0Zc0Dz74xeXiPflcZIya8we6s5LZv3iDcexr07466DqWp6E13Zy4NuAxA6kc5r5qu4tc0y53i6kaJ3JXJ6V501aR1p+"
            @"7Y9Ht7u3iVUe4TCnPWpG8UWNmDKbgYPG1Wry3VNXu8FY7wlyeinoKNCup2GZ2dgDkszdalbgekz/"
            @"ECMIy2cbOcZA9TVG58bapfxtEW8vgZUda5ePWoIlYIu3J4x3qzZea04O/"
            @"d5gHXtVWA0UgbUH2yIRuPWrMuiQWWnPI8Kjr8xHWtPR9PjhiJc7mxn6VFr8pntRbKhHXIo5UNR5Vc8c8V3d/"
            @"qutvp0EeIVI3t0xUVrpkRbyPLJDA8766PWtItbd55lP71vauI8VXeowWrw27NG5Qjcvb3qHuX0Ou0axszcCFSAEQYOepr0DTLS0ktYj5gUgDcBXgvgR/"
            @"EWmzCW61RrmMgEbxyDXp+l+KjIikzqhIGfrQZm/wCMrC0ggXbKMsRiuMvgHJdAoMTYGOpq5r/iCe/"
            @"LbHLmLlfl4Jrh59Q12K+"
            @"S5lvljQSYeEjqM0GsDYn1GXQdTjuoMlBLhsenrXoOgXKa7p8dzbuOTkjHWuF0qyGsHZcMAjN1Nd54D0xdNPkE5UdGpxE5e8aIjuI4TGx/"
            @"iPbtUT6myoCXPHvXQyWAntjchcL93p196wtasEtkMZUpj7pPenyi5kMlv/"
            @"Ni3LMAcD71VtQAZt7feABBXpVEyEnYrDcByPWnTXO5CzyAkKMDPQ0crDmQqOzp8yr15A6GtDTJ/"
            @"OlaElQzLgZrKhaW4uool6EdjWx4Q0q5uvFUFu8e8SygEAdBmq3Iue//"
            @"AA30+"
            @"ew8M2qyFCfJB44611MHnCHZtAYDnFUdCt1hsYreNQBtCjjoBWpEhVME85Nbx0QDGlYQ5JbIAAxU1nLJHEC3aTH4U9Apg2cc9eKbZorRvG7ZPDD65puN0aRLc"
            @"iecdhOD2HNJ5JjBKQHOOqrx+tSb1wzMxGOflHNRTXN067LbG0np5OT/"
            @"ADrKR6OFbuBlutpJgdsdQHUf0opv72AF5AE9dwUfzbiisXud5g2moKSEHIxnp3q404AVgowDnIPese0lQ4JXGR2q+"
            @"iho8E849a9itofFYaXLEg1qO2uVxMuVZSpDDsetfMPxOsm8Oa5c6MFA2zu0RP8AdJyP0xX1DdDfBsPI5zXhv7SfhOeZIfE1nb7vLHlTkdvQ1wVIaXPQhqjxG"
            @"81AvIwWNS4bggYqFNXmQtFnBP3sGqeroYWIkmKlWydoqna3avlmYjHUnvXPEvlZvWd4RMiiTcMHhj06V12h3DSyxkqpA68157o14DdHDAjdtANdxoxRUJjJJ"
            @"XsB1oixcrOwXV0SMhwBg4BBrn/"
            @"EHidY5lZJwxA2sM1W1bWhZWezb855C55zXNTQCZXursuPM6AGquy2noW9ZvpLkEpggr82Dyaxp9J+"
            @"1oHKnoQcmrdq3lT7J1yhGBzWhHaQswxwT3rPe4nsVvDmj21qixzW64ftWwmhwRg+"
            @"XaBCDwAc4FN06yliBfIcg8A9qlF9NDcbGh9s9amJA240dTYuTHtLNwQa5C60ITXLXLnOCCMnPeu7VZnjyqFlI7+"
            @"tY89jGeAduOGXHeqGm0VNNljtiirBuIPWuv8ADmv2cN0sEuATjgnpXLxwKrFcd+MVb0ywdpPOZXBDZFAj1IanDLAEjRSvFYfiiI3Cl9+V+"
            @"tUNFvJEuCspJ54TPpVjWLjdGIyMbh0Jq+ZActIgV2CsB6ncaesYkiBZ/"
            @"l28cdadc2RSUk9COTT44vKQAdMcUy7IsaFaFxHK4ClTxz2r2f4KeDAsT+J54F3OdsOV6D1ryvwvpN1qd5BZQwAtLgA+"
            @"x5zX0r4T0ePT9Fgs4oseVEFx2zVQjqZz0ZpW1qsShy2M9BVqNVK4MfzBuRmmrEyoEPFOMZjKljz61vysEICiMULZGeB6UthbhptyOB1DA/"
            @"pUUm5JFZVPJ5qeyVGnliA4yCKvoapq5OzzLAFRyGY4ytSCGFYi18iyfLwCR1+hqvbAuOJQhSQhS1OmgmkBmaJ5CDgnCgGsKiO3Dy94aoQITH+"
            @"7O7C7TGmPy5opm5HXLQgEPyBN/hRXPZnpnM2Qc4VIs7fvYq/CjPk9F9TVaCN9mYmdCPvHbgGrasrgHdlcfdFezW3Ph6HwiCLEbgjIJ6kVi6/"
            @"4ftNZ0+4sb+2DQycH61vg4gZnXHPFVbzaQNo69T6VySV1Y7oNo+RPjJ8K9c8E6tNdNAGsbiQ+TMP5V5hcPIlwY5G4DdvSvtX4o+"
            @"Erfxh4ZudIMCbgC8G4dGAr4v8AF1jNpmqyW1zBhkyrAdiGxXJJcux009VqLZTLHdsUUEFu5ruvDl/IU/dgYCDjNec6YZFmC/"
            @"ZwQxJPzYORXWaJexhlQxlcEZ+fNKNinua+qljqitcLkMODjpVDxFq32S1aCFXfbzlRyBW/PJbJbJNJGrsPukGsLVi98JC0a8D5ST/"
            @"hRJibbPMNc+L19ZXH2e3024kxIAWEZArS0X4patdyoBaSEnOVI4GK6BPCkMi4mhjd2bJyKu6b4U0yCcmO0CsFOTxjms3sJtWINN+"
            @"IWrwwNLdWbqgOc4rbtvHsNyyA4O5fTHP5VPaWVkgVFhHA5JxUqWOmyyjMYUnoMcmiKZBTuviCbWMwAE56hTVS48cqSpKKS4yQeua6CHSNHjdmljVsjj92Mg1"
            @"R1Lw5p80myHIJHBKD/CmN6mfp3jexkl3XMG0Dvit/"
            @"QfE+"
            @"kX0xRTz7VzknhAGcDduTdgjFbGn6DBpTAQxKGbgsOgoEdFFK39oRzRsenSrGsKyXDD7VuIb5aj05IwiyH5nCkBhUOtX8pkyiIG75NAEF0N8mwzdumKm0uBnn"
            @"SN2GwZ3ZPas+4vGYebj5gPxra8FaVN4g1O3sIoPmlILfTuatfEU2ep/A/wADNJH/"
            @"AMJBeAdMQDtj1r2GxVreLao471heEtFt9I0mC1th8kcQCA+"
            @"ldHHtSPDDqK6aaSZk22Of51ynaklkDKqhSSPekZQFB8wge1NlKBQrPWr3C7EuEdyJChGBgAHNPs8R3O8tgnGM1E0YNv8Adz8/"
            @"XJpyGOEIxUjg0NWRcZF6DK7kRc/vSSasbo4QfOdAOuHNVraRWdpRgbwMVI5llUKJ3BXuhH9RWU0mjsw7XMVpLlXlYiP5N/"
            @"ymO4QfzopJBdW7lvNYkjADSH+WP5UVz2PUvPoc5Z2ywhpJWc5/"
            @"hZ+BVuF1XmNQR6VUSQRQ5lkDYOCAc4qza3EbxBkQqTxkivVq3bPjKGxPKhmUl3wPaoZQrgKMcdakbIQ/OOvPvUVw/loxRgMDJ4rmaZ1wMjWgoR0z8o74r5B/"
            @"am0Wz0Xxs7Wq7TcxrIyA9Dmvqjxx4ntdA0SbVLuZFCIWG7jJFfCfjvxtP8Rfinqmo3F40gWLai7uAM9K46rOmje2pnR37G5Ee843NnB+"
            @"ldToWoRRyLZtICrDI56GuHuENvO2xT+7yMVa0rWlZ081yhHGTWKk7mrjfY9JfUPKiMcsp2jnANMSaOXc9sWz6GuXt/"
            @"EJDh2nDAHgHmtjTfEEMsjliFDLzgZqiXdG9ptmkwbL8gZyauRWwDHEeRjkk1l6Vq9q6lI5FDepPWtOPUY5sjdnAwQtD2MxvktI2I1wOmAaWGAzTK8Tkqgwcd"
            @"jUsFvI8rCMkDbnIHrV2w0V7cFWY4PJ+"
            @"tVECK2tJhlcsOOcmpFtHkyxLZHcmrKoIBs5Jz1NWnktGhaGVsYXOQOTSZcUrGZIyoNz4AI4x3pJHabA34A6gd6ZqMtvFCgLdDx71Wiu4GkZImIPc9aRBqQak"
            @"8MZSI4x0A6VmajqjPcYacYA54rPuNaWGZoEn2gHBB61Vu7+C2Yorbi/LFhQFma1rdtc3S4fI7ntXuv7P/"
            @"ggWtgPEF4V82Zv3Gey1896fcxqSRKQP4Tivpz4J61p+oeEbb7HcLIYIVS55+6doq4ayKnoemWEMflDZ07ewq5IQqfyqlZTghUwBkZ+WrUhdEB25/"
            @"GuuJzXdxD80G1mIJpGk8tNjkexPanF1+VmXr71FcHByeR61qo3ZEpSQpLBciXI7elC3CsoWUZI4+WojMxwI2HHQYpr3ZX5LqLHzjBXitVDn0IVZpampa+"
            @"WYxtkXpjBPSpGm8omKMIxxnLPisYwmWbMMyjb/"
            @"e6U42bTrvd4uD1EtarBRa1IjmM6UtjQn3j948yDI43TEgUVm+"
            @"RHEx8y4DevlfMaKawNJdS551Wb0RlwPaQxh4VDc5wOlTw3U7qF8sAD2rPg1G3BCKMkHnjpUslzMy8cLk4IrOe5hS0iW5JgcxoDz1Oaq3epiKF4zkc8nNKJwY"
            @"MMpzySQax9evhbWEly7BUVN5ZvTGa55Ox1wZ4h+1/41Sy0MaTDduD5bu6p2+tfGXwq1htV8UapdSyE+ozyOeK+h/jnrp8YaxePIzeXI5jTnnHqK+e/CHhD/"
            @"hEviJqgt7k+XexhkBbpj/8AXXnVfiO6C907O6hSbczqQfmIXODyaw53mt5JEMRO0fLXQXKJGm9G3sU79etUr+3EcnmTEklPugVkWtDJsfEMg/"
            @"dTgqc9T2rZ0/"
            @"xTDFlVkySAvWucuURlKuPnJOAKovHcxN5kWR8vQ+tO7E0pbnpmk67GLrzVlVhgZXNdr4fvUlUucAMPSvAdN8VXWlzfvU+"
            @"YADiur0D4uiENDOxAHO4niquiHHU91069gSQyNInCDvV+LU4ZZxtTHHc9a8eh+Mvh9bfzDcoCE5Oea0tC+"
            @"NemX0e6Rwp6JzVKSJaserPqtkkXKrkn0rC1TVVt52n80bVwcVzlx470oxK0t4oLHIGayNd8fWM8u22mV8qBtBpSkrjizdv9XF3OX83gjK/"
            @"4VSuNals3yW64zgVzMXiKa4kcwMMA5PsKljlvNQIKliCM5Pei6Jt7xrXGqMyOC6EvySRz+dNiupbxg7cBRzkdaq28UsVyftDZOMbcdK1YLSNVMir/"
            @"AA0FlhdVaIKqquCMjjpWp+zX8epfDfxiufBWrXJFrqUihc9A2MAVyl7dske4qeM5+leRaP4uuk+"
            @"NovLSRg0V6vl4PTB5oTcZBNJn6v6DcRSWy4fnHIrReU52qDjFcB8JfEMuq+EtPvLt/"
            @"wB7JbqWPqSK7YTyKmFYH0ruhscktCYFnUqeueKRjJGSXIZe4phu1bCNwf51C0rKC5k4P8NdETCbY7zI5XPlvtI7YpzSyNE0cyDBxn6VUd4WcMDtJ7VJFcFUx"
            @"Nyu75R3rqp6nNObSCZYzF5cPC5z70sKSqCCUG4feKZoWaORy/ldPQ8U8zqRhu54xXZGOhwSd5CQ2aIGeVsv/"
            @"eT5f5UUsc6kMpGQO9FFmiTlob6Hywiw7QGxnuae15Jsw0gRQTgk1zja3NEuywhVCXOCGz/"
            @"Olub9LC2+16tqcMUe3cwkYV5snqenSu46G0+uRoAYpQ7dCQRgfWuF+"
            @"NnijUNL8F3jW0qr56iMkn7vrgVzHj79qXwH4St5YdFH2y4Vh8qLgGvJfHHxi8YfFbTnOobYImb9zHnjHpXLVlDodlOLe5y/"
            @"ivXTcSPi7+ZeNuM9sZry7xLqcmi6tH4h4kWAlZVPAKV1lxcyJJLFeRgPuwGBxmsq7sI9QSZLi3jdJUK7XORnrXBUZ6FNKxtaXeW2t2MV3azoQ8Y2lGB6/"
            @"wCFS6lYNJFgPuZeSwPQV5T8NfFo+HnipvBWuqxtp7lmtbiTjZuOcfTNezQNBew+bHGjlvuuOc1kW0kjjNStVi+ZCoJJy4OeKqNE0iv5xCrt2qw7+9dhq+"
            @"iwxx+asCA/xPiqEdjHJ+6FuuOvTOeKdmTc4ltKnkZmErkDoSB0pkOhwS5gE7kHlge1dsdGt3xi3XLcfKP51LYeG7aWQmCFeeGXFKzC92cZa+FbCV/"
            @"JeTgj5cNWno/"
            @"h5ILsQm4GAOOa6238CTCUFbJeBnOKvWng6dWV309eDyQvNJRZMrGFDoNpIw+"
            @"3XrbgPlAJxT7TSdOgcyecWIPGPWuuTwbKx86NDuz0Ze1W7TwrHBG8U1qrOOSabTZGiOYi04InmWakuwxjsa1dMtvs0KG4Yq2cEDtWolnbpJshhHHBwOlJdWk"
            @"jgKIhw33qaVyb6iR24vHBJG5FyPU1ZXyI0WMTEg/wsOaTY4g3qoRuhJPJpLqaSEFi4+VQAQO9WVe+xleMLqPT9MuLiPIEcTE8e1fPfw3vo/"
            @"EnxMWeF2LG5J4HQ54Jr0349/ED+wdEezt8PcXCbcg8gHvXM/"
            @"s5+"
            @"BihfxNe2215XBjZhjgVMndly5Wfob8BdZjl8CWADcwRqkgPUECvTbK6Se2Di4BwfXtXyv8ACz4yN4H09orzTHnhLYyrfdr2rwH8YfCHjG2ElhqSRNnBhc4YH"
            @"0rthJWOSomehG6iTDSjr0Y0wucEW0wIPOSazvt0ToJHO9X+6B0FEdwnl+ZaMA2TuBNdUHc5JFhp/MUxNLhh/"
            @"Fipop7iwhCzHzAOrEcVRa5tWIacjJPLHinwSXVuRNFIGUDnb82RXXTOKq2XYplkQzRQeXu5HOc1JDI7AOYuQMn3FV7WWKdQ6jZk8gHvUiNJuZcngdRXdH4Ti"
            @"bdy2pMCGXA29eaKgLyMN5yMLx7UVQuZnyt4u/aeuIy1r4T0+LhTl5l5BryjxN8VPFPiedW1/V2ZTwyK5AArJ1/+07x3eCMKADkxDB/"
            @"WueuNPijRZZ7xmkxnBNeFUnI9+CSgWNV1KIaqghZmER+bzDwR2q5pmpSy6cy3Fx8qE4CN930rkNZ1KVngk+2hdzbGwPSn6XK6zTxm+"
            @"DADgFutcLbUjrhaxt68WWJpbYBnXksWrLsLqdo2jlU9yGPrRc6iwj8hGHLdeuahtdSaYeSISSjkNzjNZSV2bxaRk/"
            @"EbwdD4rsFu7ZfLuoWDQso5JFaXwM+IdxJJJ4V8R4DwnarMcHNakC3N0BKiqFJwACMisDxl8PrqG4HibSHEN0jAtt6MB9Km1ik+"
            @"ZM9bv447jaiqvlMOMnv61hatG9peMETgDjFZPgD4jRXkSabqMQaZeCznoRXY32kW89sL+GUP5gwRu/kKpeZD0ZzdhK7y7pVK4OQOuRW9pz2CMkWMFzk/"
            @"WqCWOLgeTg/L06VM0c9tIzZjJUcDPNNasR3ukWsV0qxKpA8v5iR1rWs9HiWYRSJ1HBrifDXi62hb7NLI4kOBg/0rsrfUmnj/AHEnKjPJ5xTe5D3J59KgiZ/"
            @"nwFI/"
            @"OszVoPss0k8Mmfl5GKumZ5ir+YT82XFU9QjlmLHGfm5ANHKhGRIDtyqbdx+Y+tKkJZt6kgDopNWvsbtIrEgbm+"
            @"XcamSzM0uNu3B5btQk0BSaIKfMI3q3UDsazPFGo2mj6ZJLcqUCjO5jitfWpfsNuY3YIyDO5ef5V4P8cPiBqWtXP/CPWEjJmQIQW6k8CobsVTTuch4jvbj4m/"
            @"EEW0a5t1kClhyMZr3fRdPOjaPBYWdsAqxgIAMduteefB/"
            @"4cXOhRbtQcCUMWlyvOcdM16haXUUoe3dsYQbRnpRFId0ma+"
            @"izJETBdAncM8njNZUuvXOk3pn0u58iWOX5fLbGafLdPaHziCy5zg1g6lr1ptla5hMcgbIYL2rVaGU3c9s+Hv7T3iXRFi0/XrYXMQALOTyK9a8K/"
            @"FTwx4iQXGmaukUjHPkPJg5P1r42j1uIxpLHdM5Rcsf6Vs2OqxRsl5ZySQtkbijnIPtiumlVSlY5KkGkfaKa6s48u/hJLHCOvP8AKtKwnmhtvMtpDJ6ivk/"
            @"wr8b/AB3osq2wvVuYB2kOSV9vevZvhz8WLbxBEkU7SW85H8WcGvSpSTZ59ZSR63YTSTcTxbD16dauhoxhe/qaxrHWUuLdXllzjHzY61oxXtu4/eOuR/"
            @"tA16Edjhloy9E0W4pkc9Oc0VDDKkoLxJuA/uA5opgz87tVm1q5uJzAREEbG5sciud1SW0il817zzH+7sC966qTRNUu7uYSyFV5LEjHesHUdOg0u4/"
            @"dIJnL5GOa+flK578PgPNPGV1qT38EEbmJGlPG2tG3NmkUVz9oLMgw6/3jV3xjoF5rN/Fcyw+Xg4XjGapS2NvpsbQs7M/"
            @"TGO9cstzrjblLlzOpZXiUBFHIUU63hdQ1x5gCEE0ywS/uLYbLfBx/"
            @"dptnZanIzpJjOMcnpWT3Ljexs+"
            @"F2ViUL5O3gZ71ts32tXgnjwqL84NcppGmalZakyifOW6joK662tNTaMTGIkOvJApbApcpweraDFaXj6hp9x5f3vl6YNdJ4F8YX0EqWd7KHVfuk/QVev/"
            @"ClvcMPtcbDdyABWFrugaj4fi+3aZbO6HKhgvFSruSKumei2r6frcZltSFcJk4qe30tlOWVG3fxGvKtA8XanpU4j3EFlwVNep+"
            @"C9fOoWsYkQMccmrj8TJbsTN4esg6zq2yQHOBWvpz+XeJAtxwy8nPStDT4NOvCDcDYVOCcVasvDdkLrzVkUgH5SR1qrakcyY+"
            @"JPIQhHPTGT061BsCyOWJzu5A6GteLQ4IFxNPx1Iptxb2scQntAp2ff96YGetlJMwYRgKpyoxU1w9tY2Xmum5ycgY4FF9ei1sTPNIqAj5QDzXBfET4rWui2/"
            @"kWMrSytHgj0NK+thlT4veM4NOtJnguFQ7TnB6V4V4Q0g+KPHaXFxPJJbQyiaVm6FhyB+dbM9t4r+Il9JFJ86tJl3Y8IPf0rvvBPhPSdHsE0/"
            @"S5YpZSd90wXJJrKVzWDSgaGmxXcIeWaUs0rFiD/"
            @"CKtoHRhcpdAMUyRio9dt7i2cRkbRs6+"
            @"tZBu7q5lFvEuFU4LZ7VasjOxsSareyr5r4ZFHJrldTuX1eeRo328kEZ6YrU1VrvSNL84FTuBwoPJrltEuryAvO8fzNIc7+"
            @"9XdMiaaEur97WNY5n2qWHKdz6V1mk3zrp6sqEKzda47xDp1xJpyzzMFBclsentXQeDFuLjTktvMyccZ/u/"
            @"41rSS5rnNVd2jrtMmgxE0ZYbjjOa9V+Gs88KpMxVmQ4w3pXkFgJEIVojs39O4r1z4V73XyzGMAAjPpXbSbVTQ46zVj3bwNqFxDEgbLLgH5lyK7K2vk2+"
            @"aLeIMx5IjrifCEky2iNAjEDsvIzXaWN/MybAMsy/88ulexH4UeVU+IuRT3THELHnqUXHFFNt/t1wpiQZIHLkbQKKoD5Fh+B1350t3rmp4Rv4WnJ/"
            @"Qc1Sk+Gfh2J3SztpZJFf5XGSP1r3qb4f2iv5mqTsxbtnNJF4U020j8jTrBGck5cjOK4fqiSO6GJ90+Z/F/wOv9XeC9uJjBbq2ckY/"
            @"WqF38LfDVmhFnaPNOOCw5z+FfT03w0i1KPOrXAEO44jxio4/h/4c00FrXT8lz94LnB7Vl9STkbfWWlufLWn/CzxNcXZCaZ5EDdJZF5FXp/"
            @"gGUuDdzaqmyUAFOhJr6OvPh7q+sAieQRoeiIoHFRL8IrBo/"
            @"Lv7wkJ9zdg4NZywWpf1xnzunwB1KC6NxYaipJGViPJzXSaH8MNZ09QJ7SNlUDcSefwFe22nwu0+I+dBfKzY+ZWCj+lTxfD+9t3IhnU/"
            @"wCzjIP41n9TK+t3R41N8O7C/cLcAIoxvLDHFZ/i/wAG2OkaUbDRUWWGRsCN0zk/WvdX8IWYRxq1ljjGFXrWU/"
            @"wbN9cre6fPxG2TG3II9KFhBRxbR86D4ORXMC3R05Yyc+YjjBB9qu6J8PdX0F1e2gDQnPXt9a+k4/"
            @"AekzObfUtM2HpkfzpsHwntrUEWEoZGP3HGfwoWEsyni7nl3h3w1ZS2vl31k6SEA7hXSWPw+"
            @"to0UiQ4fkEj7td7beENOjCrd6cEwOSB1I7Vci8OWE8uJHJRcYUcVX1UaxCZwLeB7WzTdPc+YH645xUGpaLpWk2jSWNiZSxwVAzXp0vh602g+"
            @"WuwfwdzVK48NLcDZZ6eME4OeKHhVYFiFfc8A8Z6ddaqA0cIiRT8ydCK4kfBmXxTqsdpZWhkUtmWZjxGPXPevqW8+EWnag3m6qGYjrt4x/"
            @"jT7fwDp1rbiw0O3WMj78hXBIrm+pzvc6PrVM+avFHgHT/CehzaVo9oV3x7Zm4y5+tcF4X8MavpWtfatMt5whbopwv4g19gav8ABfTLiRrrUZ/"
            @"Pbr5eMCo7b4WwmEQaZo6KvGd6dfxpPBzbsTLGQtY8Ob4Xa9rtgLq5jVWfGQxwce1PsvgfDCH868Coq8nOa99Hw0YRiW9cQ+"
            @"WuAgPWo7j4X6RcvukujyPm9fbFafU2Y/WvM+cvGHwkl+0x29pOsyFP3a7uT+FVIfgrqNsgV7ABlXdyK+h5fgnBcy/"
            @"aF1QqUb90r9TViX4Z3DIYLiVgVGVKnqfSnDCO4SxVz5l1P4WnUoRavbHzFBIXHGav+GvhZqVnac6dgBeTz+lfQ8XwqDFZnXLdGUYrQT4d20UKxC2Occ5Na/"
            @"VGjCWIUmeC2Pw0uwI98BXPOCDXo/"
            @"w58GXdpbxiWMbi3IHXFdxaeCECEyWwAB4BrZ0rwzFHGJI49rqQBgV0UsO0znqVOYueFdOksYVaGJwO+0A10do18socXJb0jaLH8qo2Gm3SRbIhhh2z1q/"
            @"bQ3iRFAZVYnkq2BXenbQ5XdstKl/LCyyM4Gfuuw2j6d6KSO0umTJuEGOu/"
            @"wCYmik9yXe5hnSrCJM3kvzqowM5zS718srp9mAxPzAEc1LZ2UDkybcEAHAHHSi/vZoFeO3Cpj+JRz+tL2kUVFIrtpsb/"
            @"vb+42E8hGNI8aQx7bGy+fuzdCPWpdNtorpfNnyzHqSanv5XsrYC3OPeo9rFvqbJKxnrpc9ycz3AUHrhsAUTaLpOSk0yt2GHHNSEG5TdMxbPUHpU+"
            @"n6bau5BU9MgA9KHUiTy3lZFNNK0nYVFwEPTlzj+VWY9IdIj9nnU8/eDZFObSrQSuCHOVzy56/"
            @"hUMkX2ZwYZGGDwM1LqK2xfI4q7HzAQoRqFspTbjOP1qGDTLSYjUNLuinGNnY1c0e+luLj7NMqkH+LHIpdXs7fTpHltE2MO/"
            @"rU+0j2Juis5RSIdUs8f9NIxkfjTo9MAbzNOuwR6jkH60/RtQmvkK3KIeD0Wp5bOKMGaFmQhf4DijnXYaV3Yq+e1u3l3GnfKW6jkH/CnhdLe4/"
            @"eWLD0wKn03UJppHWVEODgErV9bOBsyFBnGeAKrmiaezmkZhfR4WG2PDHg7lPFSF34S2swFP8RFXntYIsTLEpb1Kis7UtVuYHCRKi8jsf8AGi8SdO5KbCPb5l"
            @"909FpkkRmIhs7L5e8mOlWNPtY55RJMSxfqSak1CaS3YxwnAxiovIvQqT6bZx/vbg7mGAV/vU25jmuYwlrb+WF4q5ZWcD27XUi7n3dTTb6eSH/"
            @"VnFQqibuEooovpEQUteSc46N2qNdL0ufMcUrkhRkqtXoreOaQeZk5OTVltGslBmG/"
            @"cMAHdWntI9jPQym0fTpEEdvOQfWTrUi6Q0IWNwGA+"
            @"62OtX59Is48qNxA6AtVVLme0mWKF8Amn7SPYNCJdPjONrAZ7bfenzackIIfOS3BIrWm021urB7iVDu8vOQaz7O7mLCBiCuQMEdsUe0XYfukEdnCWwseRUqQQ"
            @"QcAg85xUmoW8dlJ51tlT6DpVi0SO8ANxGrH1xV+"
            @"0REku5GiC6IkhYbsdM4qRbe53GKWFiFGc76jkt44ZsoTweMnpUEzNgyBiD7Gn7WFupndIv28Dxt80qoD6nNFVLK4kmjBbA2twVGKKSqQYaH/2Q=="
                            options:0];

    PPCroIDCombinedRecognizerResult *emirResult = [[PPCroIDCombinedRecognizerResult alloc] initWithFirstName:firstName
                                                                                                    lastName:lastName
                                                                                          identityCardNumber:identityCardNumber
                                                                                                         sex:sex
                                                                                                 nationality:nationality
                                                                                                 dateOfBirth:dateOfBirth
                                                                                        documentDateOfExpiry:documentDateOfExpiry
                                                                                                     address:nil
                                                                                            issuingAuthority:nil
                                                                                         documentDateOfIssue:nil
                                                                                                         oib:nil
                                                                                                mrtdVerified:YES
                                                                                                matchingData:NO
                                                                                                 nonResident:NO
                                                                                           documentBilingual:NO
                                                                                                   signature:signature
                                                                                            signatureVersion:signatureVersion
                                                                                                   faceImage:image];

    return emirResult;
}


+ (PPCroIDCombinedRecognizerResult *)juraResult {

    NSString *firstName = @"EMIR";
    NSString *lastName = @"MEMIĆ";
    NSString *identityCardNumber = @"112166943";
    NSString *nationality = @"HRV";
    NSString *address = @"KARLOVAC, KARLOVAC ĐUKE BENCETIČA 2";
    NSString *oib = @"40568374465";
    NSString *sex = @"M/M";
    NSString *issuingAuthority = @"PU KARLOVACKA";

    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd.MM.yyyy"];
    NSDate *dateOfBirth = [dateFormat dateFromString:@"08.02.1967"];
    NSDate *documentDateOfExpiry = [dateFormat dateFromString:@"07.09.2020"];
    NSDate *documentDateOfIssue = [dateFormat dateFromString:@"30.10.2015"];

    NSData *signature = [[NSData alloc]
        initWithBase64EncodedString:@"6x3smRxwE8rTo0zSUH6gnTddoTFvnNlXGH/WqQIs3XLWlONlAQtsOevHAEBC369rra981klcf34z6xbuiI5fxA=="
                            options:0];
    NSString *signatureVersion = @"v3";
    NSData *image = [[NSData alloc]
        initWithBase64EncodedString:
            @"/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAAIBAQEBAQIBAQECAgICAgQDAgICAgUEBAMEBgUGBgYFBgYGBwkIBgcJBwYGCAsICQoKCgoKBggLDAsKDAkKCgr/"
            @"2wBDAQICAgICAgUDAwUKBwYHCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgr/wAARCAEsAPgDASIAAhEBAxEB/"
            @"8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/"
            @"8QAtRAAAgEDAwIEAwUFBAQAAAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3ODk6Q0RFRkdISUpTVFVWV1"
            @"hZW"
            @"mNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/"
            @"8QAHwEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/"
            @"8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSExBhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElKU1RVVl"
            @"dYW"
            @"VpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+Pn6/"
            @"9oADAMBAAIRAxEAPwD9m5Z53dY2cKgBKnHBH92mBlEflQ5QE5UA/dPpTbWRnt2hm++jfMQO/tSxEbmRwee/v616iVzzFN3Jcu8RDO2SeQ3anQo0MQ/eL1+cL/"
            @"CfUVEsbNtQyEkH5ix+9SxhQxXHcgj1q4x11M6tUn88xnzllOF+8B3o+2kSmaGMjjJGeP8A9dVI3EamF25zx9KWJ8BoyCTjP19qqSa2Odzb2LU9/"
            @"NKnmROQuMkDvUNrflkcSuenGe1U1uvs5eMEgKe/as/"
            @"VNattLhN7cXKrHnlicAfWmrcooTvKxp3+plCXt2ydo3jHWsrVfGWj6ahu9Q1OGILx80oya8c+"
            @"NX7UMOjKdG8GzLJKVIMw6Ke9fOXir4leKdau5Lu71aVgX4UMcc+"
            @"1cdXEqHuo2g2mfYGuftB+BbF2li1AO0ecIjjmuG1z9sHR7YSCz0t5GUnAE4yw/Kvl+DxBqKO0ks5OF/irnPFeqX0VwJrVpMH7w38VisTJl87Pqi7/"
            @"AGwGu4gdMRUaLDMrPnA9DzyazJP2tdZZyZNUjGTlAvB+nWvlK38QXIYqs2wscMB19zUMeovHehhdM3zZXLdqp4iQJtn2La/"
            @"tUancWy3C3cZ2Y6HnNZkn7att4T1Hy9ftwYTlo2jc59+vevm3RNclW72rK4+blBXGftA63Mvh4X1vM+"
            @"6KVQVU9MmohiZ87RN5Xsfcvhr9vX4PateQW13fT2Um7BeYDaQfXmvX/D/xM8JeK4473w7rUEwZAymOTJI78V+KVn4t1Vrn/Sbggs2QSx6V13gr9pT4h/"
            @"D3Umk8PeJp7cggKvmEjHpzXTHEPqM/Zv7QN63CykhidwPU1bhuiWWRdzAcHmviD9nH/go/"
            @"pmrWVp4f+Jrss4O1r3dw31r6z8IeOtC8RadDqWjaxFNDMNyuj5BBrrhWU42OV3UrnXShfO3htqkde9SRyAZZs7RwfSs+"
            @"zukaJwW3Hse1TpM2xUXufmJpjU1fQ0I3AhIyoPYHvVSeIyXAYKPYU8fvSp3bsCopJnji3Zw2eKiSOujUVxJLiMNnad33SKq3U7S4EYwF6Ek8/"
            @"lT8sUUYyxJOfWmRLjIY4461DjodsZXILgGWImSQqSfvdz7U+C2YqJHBUdjng05FQEEoOvXNItwxXMa5IbB5rJqxummTtEph3LuIz1zgUhUCLdsVmzwOg/"
            @"OmYYAytIF5x8rc05Yig3Y3Mf4R3oW5poLFFHES7N5ank4BOT9aKjUyAFec5zj0orZaIhtXNj97EuUALbdy7Tnj3pTNHMFeM5I5Y4qQ+UAE3ABjlivBz/"
            @"hTvIaBisMYIbnNOyR490RKTcfOEOR3zTtrSLkDkHOcU+RxGoydpPWmpKr/"
            @"AOqPb86a3OecrsryzIUOU5U8kc1FJdStbNLAQGxj3qa6dLZGbABbse5rgvil8W9C+"
            @"HmmPcX08bXJHyQg81TkkRsavjTx7o3gyxk1DxAxULHkDjJPavlz4yftI6x42v5NG0p3trMMQFTv+NYHxZ+M2seMHnvtYvG8tm/"
            @"dxDI47Vwnh+VLqKXUbkks5OwAVwVqrvox01rcbrWtzzTC3ikPJ5fdk+"
            @"9VI7vepDnJ3E5POMCpriGOCVRNtOeSce9JBbRJKQUO05wPXPevPd3K7OlNIrYlndi7nB+"
            @"6AKH0q3uYZXuZSXCZVRVxRDDIA2QF9O/tRFPLO5itYiCxwQ/YVS0JR55fxvDM0mMFm2txUUEawASFSXU/"
            @"KxrpPFGmw2l4sYVTu+8M+9Zkenz3DZVQFQ4z61otTWJBpmsuL7yt21s9xR4v0y31zSLmymUP5kLbCP72DhvwNXk0+"
            @"Nfnt413gfMzdadcWlxJZvGiYYDIYLnHtWcf4gL4j5hv50t7xrSFHLRuwJK9wafbWDalAZmt2R43zlhwfxrU8daBf6Z4nvFaBhG0pwxXGKoWBvUYxPIzxngKTX"
            @"ZdC"
            @"ehcivWjgWNJDG4fd04PtXsH7Pf7Xnjf4Q61axX+qTT2Eco8yzPI2+30rx2a081hMqPlegPAqeO1ktUG6BQRnnHNK7jsyZQTP1y+Af7TXgP426alx4e1RRPGg+"
            @"0Wr/K6E+3evV7S9WQKA6sMcgHpX48/AH40eJvhP4kj8Q6FMVO9Umj3cSLnnNfpr8A/"
            @"jpoHxa8EWut6ZcIJiFFzGrZKN0P61205qRyyXLK567lIgAMgN3qOWNpG3JznhVNRWt4siZ6+"
            @"gJqwJXJLHj29K0kaxlZkbxYQLGwz0LHsfSoZkkMRTH3Ty3rVgN5ilAgKrzj3qCQsVIYE85x6UpHbSmiEW+Y8hM5OQd3Spbe0BPz/"
            @"ACk+lKHynzMuQOg4o81ni3RISR2rCR1xbTJYoIY4yFQZLZLtyRThIjpky7mHHP8A9aoH3MfnBBb+HPSpEj8mMSPFtDevApJNm4C1dsukiHd1DMB/"
            @"9eikjuUt1MiQjcD8rt8wz9KKvnFypl9B58fkqcFTj61ctj5UXzvnbUSRq0HmImApJDdz7VC900qgxvgHnBrQ8CTaCaaRjtK556mora4dZQmAAM7jmrEKJdKZZ"
            @"R0P"
            @"WszxFc2+laTJfH5RGpZsnmntuZXTMn4jePdL8EaNJf6hMC+SIlzyTXx18VfiHe+KNfudRuNzh5PkBOQoroPjT8W9Z8Va5Ivm/uo5SEXOayPC/"
            @"heDXj9su4t2euRxmuWpO7sila+"
            @"pwk2janq9rIxycthSVq1a6BqFto6lgCehCivU9a8O6da2IWGBUHTgdaoRaFEtgFiiRh3JNc0oNsuCSPMLywgEYEqnceM46VHJpayrko2R0KmvSn8I6bPAY7mP"
            @"G/"
            @"oMVjat4Uh0yBGiLM0j8KB2rCUbGis2cWdPEWGWLPHJPapLSN0ZYwM89SK35dHvlcwy2pQkfLkcGqjaVdwvt8oFwemazTdyrI4vxvo9yl8l0kZxt6j1rAtLbVe"
            @"SIp"
            @"MFjhdpr1CK0upG2z2e/"
            @"ad4BGcfWrtjBBPOZDpyx5X72zgVrz+RSdkcBpujahewhm09lwPvFcVZtdFkEP2d5SGB+"
            @"Y4r0iHwvc6yENpc7lDAYC4zUMPw6vLyZoQpDbiMetEYyctEYqp7x8t/"
            @"G2G0HiyXTQmVGCSF61wtxokcc6GBJdueTt6V9RfEf4AWF9r63d7KyEEeYBgk1RT4T6FpUaxNaKyIeCy8muqMJvdFc9j5/svCt1qOYIopCSM5I7V0H/"
            @"CptSubE3KBju4XPevbR4X0WyjxbWqK4XBIj7UyfT4liVo4wBvyqKOgp8hKqXPnPUfCGo+H3MLlkkySAelezfsbfHq++B/idbzX5ZH029McV1H/"
            @"AHeeGFanibwVpesILme0UkKfmHfNeXax4fTQtdS0khxEpzl2/"
            @"wDr1cbwBpSP1i8C+L9H8S6Na6vpF4JobiIPHIOjCurjlVx98EkdcV8QfsIftFTW7f8ACqPENw7iBc2M27gjPT2z2r7Q0m/"
            @"ju7YTSDAI65zXVF8xl8L1NBF8tFLHPPao7o7nYpgcUjSKy7UkHHc1G0buP9YMk84pyVjopS1GOitklT+"
            @"BqUzNBalMg46Y602RWhbAYHC8c01MSIrSdWPIyKzaVjvjK9iY3yfKrOckdh3pv2hmkMYOcc57imQwHy2YruGemM/5/"
            @"OrCxt5BUxjAGcyEj9Mf1qH7p1RfcrF5AGlB2D06k/"
            @"4UVIrJgo+TuHATp+XeipdjZ+"
            @"70NZbmKFf3YIDtgjstQtCYgCzcHoahhzLKEPTOGHrjvV0tHPCfMA4bkZ6V0HzMmQPOltH5bMQCMkAVwPxx8UxWPhCe3SXMt0pXGenFdnrBEzEAnABxivDvjtP"
            @"dXt"
            @"3DZfatqKScDk0qrtEwR4jP4Yu7y4kvA+47shT0rr/DksFjpqxzNskGMrikh0yKNRu3Bh3xxUE1uZLo7ckAVxpdTR7lvW7tLqDzFZsZ+UEU7SIzJp2ByS/"
            @"NUXlJgdZBjHAHvWr4WKT6YoGFIbrmk1dmkdh8djJNKAoxt74p7eHoZiGkCsy8jNalvbh3LIPlI596twWicFR17mmoRe4lJps5iXwTJqDZu5jgtwAOlYmqfCa7"
            @"huP"
            @"MstSLNnIGM16hDBGDtZh8o5FLHBbeZ5gTkjPSm6UGh87PK4Ph74g8zLYUbcE7a1NG+"
            @"Gt6lyGu5flB4XbxXoaz2Qdo5osnGQc063urPO0kEnoM1P1eiiXVdjCsfClpbKYkhVAxBG0dKW50iOOULFbIDu4bb1+"
            @"tdGjQMPkZQPTvVa4h3qyAdDkHFbRSRndnlHjrSJDqchaFAT04rkr3SY3DF3JPp2FereJtLF5euFAJB4zXK65oUCyt+"
            @"646HHc1psVzHnuoRCKRrZTnB9OaptayRyfIc8YwR2rp9V0uKG7dVjyOv4fWsieA29yzlTgY471mU9DMu1jEZgeEYK8Yrzr4x+"
            @"HPIs01S1Cs7MN3HSvSL15Wd28njPA71z/xAtYrzQXiit2Y5B4FOoVGR518MPGNx4J8e2OtB3/"
            @"dTxbipIGAef0r9OPhb440zxf4ZtNXtJwFlhDYHQ5r80ZfDkyQJOsRU7uVxnAFfbv7F2vC7+G9naXMhMtqPLKn07VVJu5FTVn0WpiZdwYEYzmnMRHHwO2arWU/"
            @"mRZZeM1PJIrDHqOK3nui6TaZXlIkOSCTnHWrEKMGURo3y9QCKrcEqykEgcinJKsgMvX5hkZqJHo02y+vlEb3wTjgen5U25mjEJ8pCWZeSBwKgMiuu9FO3dxs/"
            @"rUhffHhnOF6KR1rKR3U9dyqvlsQXd8jtj5f8aKfMzsR8xj9AvVvxPNFQjd6mvKqIizKuPVlHBFVJbkxyM2cZPA9anF3tia2OSBkr9Kg+"
            @"xsIwGbcM5BrqSufKzdxX/eW+91O4jseK8T+LEH2/V5hbqC0ZwCB0r13Ur5dMtGZnY+o9K8n110vJ7iSIHdIxO5vrWVZ9CVueZX0t1ZybZZiwz8y1ow2yzW/"
            @"m+WoJXlgadruiK1xl5M7jziq9vfRQD7OU5Xj61zlkOs2sVvAFjPzO2S1aXhywENhGpwc5OVFZuoXaXtwsSxkAsO1b1uyQx7FGFUcGgpbFyyjUsHbgKCKtl4/"
            @"LDIBwKy1vWmhxFxjrT4yu0K83UdPemtxPc1rdDKpkjYc+pqzHbiF94cNkcjPGKzbC5jRDFknjkVO1xstihK7W+761YiK6UzTM0LLycDFILYoyuw+"
            @"ZRjFRxwSAMqyYBGc+lSQLKyeWXJH96h7EPclWAS4CMQxPTNaFwscVsSzYwuSSwqDTrZWmBLk7DlsmoNelIsncgMMnAHpVR3Ec7qFzi5aaOZRk4+"
            @"Y1ja9OrBVfDEt1Wpbx0yS5GM/dz0rF1W62M6KDtAySDTkFmZmpRRM0rySD5/lVVFc9qVsBcsylmzjBrTiuHmVo3U/Mcq/"
            @"vVPUZNvUgHOAAKg2kY0sMQmkmbd078VQ1Czju4fKyVRzhiBWtcwNcjYDn6immxx+6KcMR90cACm3zEnP6d4TguI5CGMuwfux/er3b9lC7ttGuH0hV/"
            @"17cAnpivNfDkIguxstVKbgCMds16Z8JrOCy8d28zL5atkoMcGqp/EEj6Y0zDw/"
            @"6zK44OOtWjuaP5VwRnNVdFRvsys65LYwK0FjLE5GcnI9xW8tiqbSKyQlYxuXkjFS21lGibWB4YEirAQEBih4PSnP+"
            @"9OwHaCRnb1qHsd9KWoxLQBdwUAH7uF3GpEsmeMsYSqnvnbk/hn+lOhjxGVVAGHQ7ualgiA4HLY/vGspHoQK62HkMGWMRkjg78N+AGT+tFWyGgixK20n0wv/"
            @"AKDiioR0PYprcKduF56g+3ep5ryBo9644PSovs8eGi46/"
            @"K3bHpVUxSwSlXBII4rsWx8m3czfHEqR6TLMnGQcGvJDdTCYl+"
            @"hU4B78mvTvG8zSaLLFjGFrxjxHrDospiBA5CY6g1hMI7lXWLhZGaaVtoU8GsNrqMTZjG7e33qguZdSul2xh8H1Bqxp1j9kAnuTuI7DoKwe5Zf0uyBk+"
            @"0z4zn92T0q/DcpKzgngZxWZLfAQmdcqB/"
            @"DWemvRxy8SgDqeaQHQxyKoAxlieRWjbRvLDuWJT6VyEPjO1WQl0PHetTSfGunM+"
            @"2MncBlQehprcDora3ZJDLgkEdO1Mef7RcpH5RULUcPiSwuGWGPG8gbhngVoW0MLZlLgeg9asBIlVRnafunrTvLEU4RTwwBA96nSMyMeCRjpt61PZWDXEyokHJ"
            @"bkk"
            @"9BQQ9yzpVikcRklBBJyc1z/"
            @"AItnYYtoBkY5rrbtl09CmQMLyK428eO4u5ZpicBuBVRHynJapbiNz8r7yewqhd2yS5cwYbGGNdRqcVuDJJMFBJ+"
            @"U5rktS1ey064YXF4CueeRTkUYd1ZxxSFtrZVuAKz7yCTzBJuHJGFNWNU8Tac1w6xyknOdo64qkPEtveSrGCFUHnI5qAkWDYltszLk47CpV05CfOdcegIq0j2y"
            @"opU"
            @"7gemKkkt2Z0mU/"
            @"L02igCPw5aQR6m0brlcggeter+GLWzhu7K9NvtkDAdOgrzKxgdb5JNuBgAECvXPCGnLNHC7BiRg5Iq6e4Hs+"
            @"iKr2EbqScYrSVE3fIDhRisnw7Ky6ciY7da0VkLQgMSD7d66HsL7RMhz8vOM+tO8qNP3pJz6ZzUauNnPzfTmkjliG4ENzxyOlZvY7qJbhjXHnFs/"
            @"QUrXGANoUqeuDg1XWMNGCPmIPUEYot4nkwHuCBu4WI8/kOaykepT+EcZGP71cKOxZf6mimPBLGWzbbWJ4kmA/"
            @"wDsj+goqEbvYDMLm3V0wOP5UkkvmxB1HIHNRlXRjGw2gcgU0FoyYu1dp8o22YfjI/"
            @"8AErdyox34rxzxHDHCxlSINvY4HpXsvipgdLmXd0U14jrjySw7JJfnWQ5+lc1bcFuYxjRZGUnn2pkiuYCpHB7ipPLbaWD5ycUySKR1wMjHQisCylLC0/"
            @"8AowzsA5IqS20ixj+R7fIxx70+"
            @"XFoPMmYAtwFFRx61a2uTcShe2M0BqKPCFteSspXaSOMVka14Tv8AT1xp8p3ryDVrVvijoekg77gKMffzWUvxk8NahIB9r5xyPWmtxe8ipp1v4jtNQM0sr8HJy"
            @"3Fe"
            @"haDrl6bVWnkzu4xXN2XifTNSdGVQA68Fqu/aIoZUlhnAUdEHerE5Hc6ZqRk++3J4GDXU6VaIsIY/"
            @"ePciuB8KXkU5FzJGQB91exrrP+EgitIWd7k52fKuelBJX8Xa5bxSG1Mihgeea888U+MBpgkNuc8880viXWxe30k0sxBDH5s9K8+"
            @"1nxBDeak0EtxtwcD396Co7GL40+IPizWZ2hsGkUbsDbWA2g/ETW7hbXfIok5LMTXdRa54Z0tcSMkkkYzylU2/"
            @"aK8BaVcCxvZ4kcjDHHSgozdK+FPiG0jNxqF27OTtyTUt/wCEJrG5HmXBBD810Fr8c/"
            @"BWqK0Nhrds+4nCI4JzSXGsadrg86Cdfl+9n1oArafCYokiWUsF65NbUTcBc/w5GTWfYwRm5+dlIK8YFacIV4VErKSD8vrQR8IRz/"
            @"Z5I2Ynqpr1v4f6hHerDCoO4t3rycrAwBc4KnvXoPwola91aLLkqhGNvarp7j5j33SoEigjQcZQdKvqqrznJHQVR0hy9vEV+bAIOO1XC2Qvl/"
            @"w9WrpWwfaJYyqNkpjPYVNGoDEgjGMnIqujKx3NKQc/nUh2SDBJGOwqJI7KcveRPCyuu5igDHv1FS7baJgWcsM8hgMVWdEjjDMWAJ/"
            @"uk1CzTu+Q3yn1GP51jI9WGyLguoyG+zyFMH7sQxmiqqxJkM2fqTkf0oqDUZLLHLtmjPI6/"
            @"wC7VeZ43YPGcDJ5pqZeM7ePlxmqF7LNbafKEclkBKgdzXZsfLJ6XK/"
            @"iw7tJmjQc+XzjvXh9/drNLLbEtlXP3qf4u8deKLzUpZftkqsrlWQHABrm0ur+SKTUbosC55y3WuWpLm1LSsrmoYNzAsDj2qVTCAytnheM1lxXctym/"
            @"a2SMDmnRs8cLSOvzj5Rg1i9Rp3M3xRqbQxlLSNWYDo1cJqMviDVr94odyBiMuegrvLjSpL1nlkGKS08PSlXlKA4Pep5R3scVqnw9a50Jtp8+"
            @"4ADEbc5rnvCfg/"
            @"VzrcyS6Yn71CuXXAUYr2a00KZ1L4QjbyM1N/YuxQVQF+wAp2E56GFeeH9J03T7WzZQJFjGZF9cU/TNFjmuBdyzMqr0z/"
            @"FWvNopOJ7k5x29KoX2vQaJG095ImxVPlr3NMm1zaXxDY6FZG7ul2BT+7H941jP4k1XVrpppZDGknKoOw9K4s+"
            @"IbrxBqX2m6lCxKf3SYrftLuJCHldiMdKtbCGeJNQkt7V5BEQo7no1ed604l1Nb4ArEqHO313Cu58TTpJavGswIfkAnpXFana3CRGGFFJIyDUy3KiN8KS6Bca0"
            @"iXY"
            @"MqHG7zPug15j+0F4Ku7DVJTp+kRus03mJcRfxL6V6f4f00iRWlADseTtrtrXwpY62iLdWsUoHQOtVGJfNyng3wn+F8/"
            @"i3VBrEmjNp9vBYNGh39ZDt+at5rDxb4Uv3s7WTzo1lO2X1Fe3N4VmtIvJitI0RV42r8tYeoeBmZnnnVTmjl5SOYxvB/"
            @"ia71CIJcQqjhsMWrr1IlUKkStxkselc3baCdPZpjGoC8cV0Wm3P2mzDsMEDimSTyRNJFs2JuZeNvpXb/"
            @"BwSxanHGqfICA1cPJM6kyyEAAdu9XdH+JWp+DnzpFlFK7jKNKv3auI+Vn1RpUwS2RS2A2cVejbdB8z/"
            @"SvAvBX7QXiu+1q3s9WtYjC7DzRGhzk++a9y067Z7ZZChO4jbnrzXSthfaLokkiUA7GGe/WrYYeWHyCO/rVaJY3Uhc7hnPrUtoWMARCSe+RUy2OqHxD4/"
            @"MfOEU+"
            @"glzjH4VN5QSDJlT3VWUD9NzfyqFo1X5mdl5HQmljSRiDHvJzwQoP6molsetDZAiRFvOS3XPTLnP5ZoqSOGUZVywAPzfvFH8hRWTVzZNJGcibEA4weuD0qvfxR"
            @"ovm"
            @"DkdOlXhaxRjahxkZ471HcwNLCWKA4HGRXbVjqfJwd4njHxZ8K2OnagdUjIVLrlh6GuA1lVWxaNUBAYc56V6f8dUmkt7aBR0YkgDivJ7n7TcK0TxHAIJO2uKUb"
            @"M3+"
            @"yTacD9n8uJgPU0/zG3+UoHB5PrTLG0vQ7IkJCNjBNa1r4dlnk3k4XAzUiWhDp2nPIxEgznBFWFspJJDDHCRg81uWGl2sQDGfaRxyKvCCytIi/"
            @"DYHLEUFcxh2uhtEolc4Ddqm8i2skDMR1OCfWodT8R21ju3yqVB+UA55rlta8V3V+qpbyYVydxB+7QRF3di34l8U2WnW7xo6tJz8ua8z1e6udZu/"
            @"PuJBtBOFxxVzWplW4lub6YliRglu1YNxraXFyYoWCxqfTrQXyluF44SSn3l+"
            @"771p2t680KnqfT3rDtz9oYRRyE85XHFdNoujXUUXnuoyR8qkUCe5Tu7WWSESSjJJOVrPOkShxKec/"
            @"dWuh1S2mso0dup+8azf7R8twNynIJGVqeUuIyx01YghcbWUZOa6fw5LscF0BB4Ug1kWzW+"
            @"qxgtONx42itTT4TZIu8HaDxjrVxCR1csqtZmEEcLkntWDqM0c0ZET7QeMYzV2xm3o0E2RleSTxUjafEmx5UVePSnzInlOXfSpkjO4I4alt4HhRIguAOorpbm1"
            @"t0G"
            @"FjGCPvtzj3xWNcwmCUxBs5PDetL4g5RjWwlwnmADaM05vDwmdYRztGc1FMzK2MjaDzgda09PkuGRmQ4wnOafKHwnZ/"
            @"Bz4exanqo1O6H7q3wUXHU17pbRLDbKEBHTjHSuG+DNnHH4UhmkU+Yxyc9+a76EOIVOcg84rop/CKW5YtgySblOQ3Wrdv5YDEEdR/FiqaTBFDNlMjgkZ/"
            @"SrFo4ky6jIYdcUS2N4y1RLJ5k3yQsWGecuAKVElYeWuGK9lDMP5CiTasOZFyQeAecmiNzcqPMgjyvbyWx/PFRLY9Oi+bQZLcQwZ814UJ/"
            @"hLBSfzNFTqUtAChETdT5EaDP1yKKzbsdTVmUVlidQwPIGBn0p/"
            @"nBoDGqnj3rNs5WMR+"
            @"cD58DNTiSSQkZ4BwAO9ejVjqfH0Zc0Dz74xeXiPflcZIya8we6s5LZv3iDcexr07466DqWp6E13Zy4NuAxA6kc5r5qu4tc0y53i6kaJ3JXJ6V501aR1p+"
            @"7Y9Ht7u3iVUe4TCnPWpG8UWNmDKbgYPG1Wry3VNXu8FY7wlyeinoKNCup2GZ2dgDkszdalbgekz/"
            @"ECMIy2cbOcZA9TVG58bapfxtEW8vgZUda5ePWoIlYIu3J4x3qzZea04O/"
            @"d5gHXtVWA0UgbUH2yIRuPWrMuiQWWnPI8Kjr8xHWtPR9PjhiJc7mxn6VFr8pntRbKhHXIo5UNR5Vc8c8V3d/"
            @"qutvp0EeIVI3t0xUVrpkRbyPLJDA8766PWtItbd55lP71vauI8VXeowWrw27NG5Qjcvb3qHuX0Ou0axszcCFSAEQYOepr0DTLS0ktYj5gUgDcBXgvgR/"
            @"EWmzCW61RrmMgEbxyDXp+l+KjIikzqhIGfrQZm/wCMrC0ggXbKMsRiuMvgHJdAoMTYGOpq5r/iCe/"
            @"LbHLmLlfl4Jrh59Q12K+"
            @"S5lvljQSYeEjqM0GsDYn1GXQdTjuoMlBLhsenrXoOgXKa7p8dzbuOTkjHWuF0qyGsHZcMAjN1Nd54D0xdNPkE5UdGpxE5e8aIjuI4TGx/"
            @"iPbtUT6myoCXPHvXQyWAntjchcL93p196wtasEtkMZUpj7pPenyi5kMlv/"
            @"Ni3LMAcD71VtQAZt7feABBXpVEyEnYrDcByPWnTXO5CzyAkKMDPQ0crDmQqOzp8yr15A6GtDTJ/"
            @"OlaElQzLgZrKhaW4uool6EdjWx4Q0q5uvFUFu8e8SygEAdBmq3Iue//"
            @"AA30+"
            @"ew8M2qyFCfJB44611MHnCHZtAYDnFUdCt1hsYreNQBtCjjoBWpEhVME85Nbx0QDGlYQ5JbIAAxU1nLJHEC3aTH4U9Apg2cc9eKbZorRvG7ZPDD65puN0aRLci"
            @"ecd"
            @"hOD2HNJ5JjBKQHOOqrx+tSb1wzMxGOflHNRTXN067LbG0np5OT/"
            @"ADrKR6OFbuBlutpJgdsdQHUf0opv72AF5AE9dwUfzbiisXud5g2moKSEHIxnp3q404AVgowDnIPese0lQ4JXGR2q+"
            @"iho8E849a9itofFYaXLEg1qO2uVxMuVZSpDDsetfMPxOsm8Oa5c6MFA2zu0RP8AdJyP0xX1DdDfBsPI5zXhv7SfhOeZIfE1nb7vLHlTkdvQ1wVIaXPQhqjxG8"
            @"1Av"
            @"IwWNS4bggYqFNXmQtFnBP3sGqeroYWIkmKlWydoqna3avlmYjHUnvXPEvlZvWd4RMiiTcMHhj06V12h3DSyxkqpA68157o14DdHDAjdtANdxoxRUJjJJXsB1o"
            @"ixc"
            @"rOwXV0SMhwBg4BBrn/"
            @"EHidY5lZJwxA2sM1W1bWhZWezb855C55zXNTQCZXursuPM6AGquy2noW9ZvpLkEpggr82Dyaxp9J+"
            @"1oHKnoQcmrdq3lT7J1yhGBzWhHaQswxwT3rPe4nsVvDmj21qixzW64ftWwmhwRg+"
            @"XaBCDwAc4FN06yliBfIcg8A9qlF9NDcbGh9s9amJA240dTYuTHtLNwQa5C60ITXLXLnOCCMnPeu7VZnjyqFlI7+"
            @"tY89jGeAduOGXHeqGm0VNNljtiirBuIPWuv8ADmv2cN0sEuATjgnpXLxwKrFcd+MVb0ywdpPOZXBDZFAj1IanDLAEjRSvFYfiiI3Cl9+V+"
            @"tUNFvJEuCspJ54TPpVjWLjdGIyMbh0Jq+ZActIgV2CsB6ncaesYkiBZ/"
            @"l28cdadc2RSUk9COTT44vKQAdMcUy7IsaFaFxHK4ClTxz2r2f4KeDAsT+J54F3OdsOV6D1ryvwvpN1qd5BZQwAtLgA+"
            @"x5zX0r4T0ePT9Fgs4oseVEFx2zVQjqZz0ZpW1qsShy2M9BVqNVK4MfzBuRmmrEyoEPFOMZjKljz61vysEICiMULZGeB6UthbhptyOB1DA/"
            @"pUUm5JFZVPJ5qeyVGnliA4yCKvoapq5OzzLAFRyGY4ytSCGFYi18iyfLwCR1+hqvbAuOJQhSQhS1OmgmkBmaJ5CDgnCgGsKiO3Dy94aoQITH+"
            @"7O7C7TGmPy5opm5HXLQgEPyBN/hRXPZnpnM2Qc4VIs7fvYq/CjPk9F9TVaCN9mYmdCPvHbgGrasrgHdlcfdFezW3Ph6HwiCLEbgjIJ6kVi6/"
            @"4ftNZ0+4sb+2DQycH61vg4gZnXHPFVbzaQNo69T6VySV1Y7oNo+RPjJ8K9c8E6tNdNAGsbiQ+TMP5V5hcPIlwY5G4DdvSvtX4o+"
            @"Erfxh4ZudIMCbgC8G4dGAr4v8AF1jNpmqyW1zBhkyrAdiGxXJJcux009VqLZTLHdsUUEFu5ruvDl/IU/dgYCDjNec6YZFmC/"
            @"ZwQxJPzYORXWaJexhlQxlcEZ+fNKNinua+qljqitcLkMODjpVDxFq32S1aCFXfbzlRyBW/PJbJbJNJGrsPukGsLVi98JC0a8D5ST/"
            @"hRJibbPMNc+L19ZXH2e3024kxIAWEZArS0X4patdyoBaSEnOVI4GK6BPCkMi4mhjd2bJyKu6b4U0yCcmO0CsFOTxjms3sJtWINN+"
            @"IWrwwNLdWbqgOc4rbtvHsNyyA4O5fTHP5VPaWVkgVFhHA5JxUqWOmyyjMYUnoMcmiKZBTuviCbWMwAE56hTVS48cqSpKKS4yQeua6CHSNHjdmljVsjj92Mg1R"
            @"1Lw"
            @"5p80myHIJHBKD/CmN6mfp3jexkl3XMG0Dvit/"
            @"QfE+"
            @"kX0xRTz7VzknhAGcDduTdgjFbGn6DBpTAQxKGbgsOgoEdFFK39oRzRsenSrGsKyXDD7VuIb5aj05IwiyH5nCkBhUOtX8pkyiIG75NAEF0N8mwzdumKm0uBnnS"
            @"N2G"
            @"wZ3ZPas+4vGYebj5gPxra8FaVN4g1O3sIoPmlILfTuatfEU2ep/A/wADNJH/"
            @"AMJBeAdMQDtj1r2GxVreLao471heEtFt9I0mC1th8kcQCA+"
            @"ldHHtSPDDqK6aaSZk22Of51ynaklkDKqhSSPekZQFB8wge1NlKBQrPWr3C7EuEdyJChGBgAHNPs8R3O8tgnGM1E0YNv8Adz8/"
            @"XJpyGOEIxUjg0NWRcZF6DK7kRc/"
            @"vSSasbo4QfOdAOuHNVraRWdpRgbwMVI5llUKJ3BXuhH9RWU0mjsw7XMVpLlXlYiP5N/ymO4QfzopJBdW7lvNYkjADSH+WP5UVz2PUvPoc5Z2ywhpJWc5/"
            @"hZ+BVuF1XmNQR6VUSQRQ5lkDYOCAc4qza3EbxBkQqTxkivVq3bPjKGxPKhmUl3wPaoZQrgKMcdakbIQ/OOvPvUVw/loxRgMDJ4rmaZ1wMjWgoR0z8o74r5B/"
            @"am0Wz0Xxs7Wq7TcxrIyA9Dmvqjxx4ntdA0SbVLuZFCIWG7jJFfCfjvxtP8Rfinqmo3F40gWLai7uAM9K46rOmje2pnR37G5Ee843NnB+"
            @"ldToWoRRyLZtICrDI56GuHuENvO2xT+7yMVa0rWlZ081yhHGTWKk7mrjfY9JfUPKiMcsp2jnANMSaOXc9sWz6GuXt/"
            @"EJDh2nDAHgHmtjTfEEMsjliFDLzgZqiXdG9ptmkwbL8gZyauRWwDHEeRjkk1l6Vq9q6lI5FDepPWtOPUY5sjdnAwQtD2MxvktI2I1wOmAaWGAzTK8Tkqgwcdj"
            @"UsF"
            @"vI8rCMkDbnIHrV2w0V7cFWY4PJ+"
            @"tVECK2tJhlcsOOcmpFtHkyxLZHcmrKoIBs5Jz1NWnktGhaGVsYXOQOTSZcUrGZIyoNz4AI4x3pJHabA34A6gd6ZqMtvFCgLdDx71Wiu4GkZImIPc9aRBqQak8"
            @"MZS"
            @"I4x0A6VmajqjPcYacYA54rPuNaWGZoEn2gHBB61Vu7+C2Yorbi/LFhQFma1rdtc3S4fI7ntXuv7P/"
            @"ggWtgPEF4V82Zv3Gey1896fcxqSRKQP4Tivpz4J61p+oeEbb7HcLIYIVS55+6doq4ayKnoemWEMflDZ07ewq5IQqfyqlZTghUwBkZ+WrUhdEB25/"
            @"GuuJzXdxD80G1mIJpGk8tNjkexPanF1+VmXr71FcHByeR61qo3ZEpSQpLBciXI7elC3CsoWUZI4+WojMxwI2HHQYpr3ZX5LqLHzjBXitVDn0IVZpampa+"
            @"WYxtkXpjBPSpGm8omKMIxxnLPisYwmWbMMyjb/"
            @"e6U42bTrvd4uD1EtarBRa1IjmM6UtjQn3j948yDI43TEgUVm+"
            @"RHEx8y4DevlfMaKawNJdS551Wb0RlwPaQxh4VDc5wOlTw3U7qF8sAD2rPg1G3BCKMkHnjpUslzMy8cLk4IrOe5hS0iW5JgcxoDz1Oaq3epiKF4zkc8nNKJwYM"
            @"Mpz"
            @"ySQax9evhbWEly7BUVN5ZvTGa55Ox1wZ4h+1/41Sy0MaTDduD5bu6p2+tfGXwq1htV8UapdSyE+ozyOeK+h/jnrp8YaxePIzeXI5jTnnHqK+e/CHhD/"
            @"hEviJqgt7k+XexhkBbpj/8AXXnVfiO6C907O6hSbczqQfmIXODyaw53mt5JEMRO0fLXQXKJGm9G3sU79etUr+3EcnmTEklPugVkWtDJsfEMg/dTgqc9T2rZ0/"
            @"xTDFlVkySAvWucuURlKuPnJOAKovHcxN5kWR8vQ+tO7E0pbnpmk67GLrzVlVhgZXNdr4fvUlUucAMPSvAdN8VXWlzfvU+"
            @"YADiur0D4uiENDOxAHO4niquiHHU91069gSQyNInCDvV+LU4ZZxtTHHc9a8eh+Mvh9bfzDcoCE5Oea0tC+"
            @"NemX0e6Rwp6JzVKSJaserPqtkkXKrkn0rC1TVVt52n80bVwcVzlx470oxK0t4oLHIGayNd8fWM8u22mV8qBtBpSkrjizdv9XF3OX83gjK/"
            @"4VSuNals3yW64zgVzMXiKa4kcwMMA5PsKljlvNQIKliCM5Pei6Jt7xrXGqMyOC6EvySRz+dNiupbxg7cBRzkdaq28UsVyftDZOMbcdK1YLSNVMir/"
            @"AA0FlhdVaIKqquCMjjpWp+zX8epfDfxiufBWrXJFrqUihc9A2MAVyl7dske4qeM5+leRaP4uuk+"
            @"NovLSRg0V6vl4PTB5oTcZBNJn6v6DcRSWy4fnHIrReU52qDjFcB8JfEMuq+EtPvLt/"
            @"wB7JbqWPqSK7YTyKmFYH0ruhscktCYFnUqeueKRjJGSXIZe4phu1bCNwf51C0rKC5k4P8NdETCbY7zI5XPlvtI7YpzSyNE0cyDBxn6VUd4WcMDtJ7VJFcFUxN"
            @"yu7"
            @"5R3rqp6nNObSCZYzF5cPC5z70sKSqCCUG4feKZoWaORy/ldPQ8U8zqRhu54xXZGOhwSd5CQ2aIGeVsv/"
            @"eT5f5UUsc6kMpGQO9FFmiTlob6Hywiw7QGxnuae15Jsw0gRQTgk1zja3NEuywhVCXOCGz/"
            @"Olub9LC2+16tqcMUe3cwkYV5snqenSu46G0+uRoAYpQ7dCQRgfWuF+"
            @"NnijUNL8F3jW0qr56iMkn7vrgVzHj79qXwH4St5YdFH2y4Vh8qLgGvJfHHxi8YfFbTnOobYImb9zHnjHpXLVlDodlOLe5y/"
            @"ivXTcSPi7+ZeNuM9sZry7xLqcmi6tH4h4kWAlZVPAKV1lxcyJJLFeRgPuwGBxmsq7sI9QSZLi3jdJUK7XORnrXBUZ6FNKxtaXeW2t2MV3azoQ8Y2lGB6/"
            @"wCFS6lYNJFgPuZeSwPQV5T8NfFo+HnipvBWuqxtp7lmtbiTjZuOcfTNezQNBew+bHGjlvuuOc1kW0kjjNStVi+ZCoJJy4OeKqNE0iv5xCrt2qw7+9dhq+"
            @"iwxx+"
            @"asCA/xPiqEdjHJ+6FuuOvTOeKdmTc4ltKnkZmErkDoSB0pkOhwS5gE7kHlge1dsdGt3xi3XLcfKP51LYeG7aWQmCFeeGXFKzC92cZa+FbCV/JeTgj5cNWno/"
            @"h5ILsQm4GAOOa6238CTCUFbJeBnOKvWng6dWV309eDyQvNJRZMrGFDoNpIw+"
            @"3XrbgPlAJxT7TSdOgcyecWIPGPWuuTwbKx86NDuz0Ze1W7TwrHBG8U1qrOOSabTZGiOYi04InmWakuwxjsa1dMtvs0KG4Yq2cEDtWolnbpJshhHHBwOlJdWkj"
            @"gKI"
            @"hw33qaVyb6iR24vHBJG5FyPU1ZXyI0WMTEg/wsOaTY4g3qoRuhJPJpLqaSEFi4+VQAQO9WVe+xleMLqPT9MuLiPIEcTE8e1fPfw3vo/"
            @"EnxMWeF2LG5J4HQ54Jr0349/ED+wdEezt8PcXCbcg8gHvXM/"
            @"s5+"
            @"BihfxNe2215XBjZhjgVMndly5Wfob8BdZjl8CWADcwRqkgPUECvTbK6Se2Di4BwfXtXyv8ACz4yN4H09orzTHnhLYyrfdr2rwH8YfCHjG2ElhqSRNnBhc4YH0"
            @"rth"
            @"JWOSomehG6iTDSjr0Y0wucEW0wIPOSazvt0ToJHO9X+6B0FEdwnl+ZaMA2TuBNdUHc5JFhp/MUxNLhh/"
            @"Fipop7iwhCzHzAOrEcVRa5tWIacjJPLHinwSXVuRNFIGUDnb82RXXTOKq2XYplkQzRQeXu5HOc1JDI7AOYuQMn3FV7WWKdQ6jZk8gHvUiNJuZcngdRXdH4Tib"
            @"dy2"
            @"pMCGXA29eaKgLyMN5yMLx7UVQuZnyt4u/aeuIy1r4T0+LhTl5l5BryjxN8VPFPiedW1/V2ZTwyK5AArJ1/+07x3eCMKADkxDB/"
            @"WueuNPijRZZ7xmkxnBNeFUnI9+CSgWNV1KIaqghZmER+bzDwR2q5pmpSy6cy3Fx8qE4CN930rkNZ1KVngk+2hdzbGwPSn6XK6zTxm+"
            @"DADgFutcLbUjrhaxt68WWJpbYBnXksWrLsLqdo2jlU9yGPrRc6iwj8hGHLdeuahtdSaYeSISSjkNzjNZSV2bxaRk/"
            @"EbwdD4rsFu7ZfLuoWDQso5JFaXwM+IdxJJJ4V8R4DwnarMcHNakC3N0BKiqFJwACMisDxl8PrqG4HibSHEN0jAtt6MB9Km1ik+"
            @"ZM9bv447jaiqvlMOMnv61hatG9peMETgDjFZPgD4jRXkSabqMQaZeCznoRXY32kW89sL+GUP5gwRu/kKpeZD0ZzdhK7y7pVK4OQOuRW9pz2CMkWMFzk/"
            @"WqCWOLgeTg/L06VM0c9tIzZjJUcDPNNasR3ukWsV0qxKpA8v5iR1rWs9HiWYRSJ1HBrifDXi62hb7NLI4kOBg/0rsrfUmnj/AHEnKjPJ5xTe5D3J59KgiZ/"
            @"nwFI/"
            @"OszVoPss0k8Mmfl5GKumZ5ir+YT82XFU9QjlmLHGfm5ANHKhGRIDtyqbdx+Y+tKkJZt6kgDopNWvsbtIrEgbm+"
            @"XcamSzM0uNu3B5btQk0BSaIKfMI3q3UDsazPFGo2mj6ZJLcqUCjO5jitfWpfsNuY3YIyDO5ef5V4P8cPiBqWtXP/CPWEjJmQIQW6k8CobsVTTuch4jvbj4m/"
            @"EEW0a5t1kClhyMZr3fRdPOjaPBYWdsAqxgIAMduteefB/"
            @"4cXOhRbtQcCUMWlyvOcdM16haXUUoe3dsYQbRnpRFId0ma+"
            @"izJETBdAncM8njNZUuvXOk3pn0u58iWOX5fLbGafLdPaHziCy5zg1g6lr1ptla5hMcgbIYL2rVaGU3c9s+Hv7T3iXRFi0/XrYXMQALOTyK9a8K/"
            @"FTwx4iQXGmaukUjHPkPJg5P1r42j1uIxpLHdM5Rcsf6Vs2OqxRsl5ZySQtkbijnIPtiumlVSlY5KkGkfaKa6s48u/hJLHCOvP8AKtKwnmhtvMtpDJ6ivk/"
            @"wr8b/"
            @"AB3osq2wvVuYB2kOSV9vevZvhz8WLbxBEkU7SW85H8WcGvSpSTZ59ZSR63YTSTcTxbD16dauhoxhe/qaxrHWUuLdXllzjHzY61oxXtu4/eOuR/"
            @"tA16Edjhloy9E0W4pkc9Oc0VDDKkoLxJuA/uA5opgz87tVm1q5uJzAREEbG5sciud1SW0il817zzH+7sC966qTRNUu7uYSyFV5LEjHesHUdOg0u4/"
            @"dIJnL5GOa+flK578PgPNPGV1qT38EEbmJGlPG2tG3NmkUVz9oLMgw6/3jV3xjoF5rN/Fcyw+Xg4XjGapS2NvpsbQs7M/"
            @"TGO9cstzrjblLlzOpZXiUBFHIUU63hdQ1x5gCEE0ywS/uLYbLfBx/"
            @"dptnZanIzpJjOMcnpWT3Ljexs+"
            @"F2ViUL5O3gZ71ts32tXgnjwqL84NcppGmalZakyifOW6joK662tNTaMTGIkOvJApbApcpweraDFaXj6hp9x5f3vl6YNdJ4F8YX0EqWd7KHVfuk/QVev/"
            @"ClvcMPtcbDdyABWFrugaj4fi+3aZbO6HKhgvFSruSKumei2r6frcZltSFcJk4qe30tlOWVG3fxGvKtA8XanpU4j3EFlwVNep+"
            @"C9fOoWsYkQMccmrj8TJbsTN4esg6zq2yQHOBWvpz+XeJAtxwy8nPStDT4NOvCDcDYVOCcVasvDdkLrzVkUgH5SR1qrakcyY+"
            @"JPIQhHPTGT061BsCyOWJzu5A6GteLQ4IFxNPx1Iptxb2scQntAp2ff96YGetlJMwYRgKpyoxU1w9tY2Xmum5ycgY4FF9ei1sTPNIqAj5QDzXBfET4rWui2/"
            @"kWMrSytHgj0NK+thlT4veM4NOtJnguFQ7TnB6V4V4Q0g+KPHaXFxPJJbQyiaVm6FhyB+dbM9t4r+Il9JFJ86tJl3Y8IPf0rvvBPhPSdHsE0/"
            @"S5YpZSd90wXJJrKVzWDSgaGmxXcIeWaUs0rFiD/"
            @"CKtoHRhcpdAMUyRio9dt7i2cRkbRs6+"
            @"tZBu7q5lFvEuFU4LZ7VasjOxsSareyr5r4ZFHJrldTuX1eeRo328kEZ6YrU1VrvSNL84FTuBwoPJrltEuryAvO8fzNIc7+"
            @"9XdMiaaEur97WNY5n2qWHKdz6V1mk3zrp6sqEKzda47xDp1xJpyzzMFBclsentXQeDFuLjTktvMyccZ/u/"
            @"41rSS5rnNVd2jrtMmgxE0ZYbjjOa9V+Gs88KpMxVmQ4w3pXkFgJEIVojs39O4r1z4V73XyzGMAAjPpXbSbVTQ46zVj3bwNqFxDEgbLLgH5lyK7K2vk2+"
            @"aLeIMx5IjrifCEky2iNAjEDsvIzXaWN/MybAMsy/88ulexH4UeVU+IuRT3THELHnqUXHFFNt/t1wpiQZIHLkbQKKoD5Fh+B1350t3rmp4Rv4WnJ/"
            @"Qc1Sk+Gfh2J3SztpZJFf5XGSP1r3qb4f2iv5mqTsxbtnNJF4U020j8jTrBGck5cjOK4fqiSO6GJ90+Z/F/wOv9XeC9uJjBbq2ckY/"
            @"WqF38LfDVmhFnaPNOOCw5z+FfT03w0i1KPOrXAEO44jxio4/h/4c00FrXT8lz94LnB7Vl9STkbfWWlufLWn/CzxNcXZCaZ5EDdJZF5FXp/"
            @"gGUuDdzaqmyUAFOhJr6OvPh7q+sAieQRoeiIoHFRL8IrBo/"
            @"Lv7wkJ9zdg4NZywWpf1xnzunwB1KC6NxYaipJGViPJzXSaH8MNZ09QJ7SNlUDcSefwFe22nwu0+I+dBfKzY+ZWCj+lTxfD+9t3IhnU/"
            @"wCzjIP41n9TK+t3R41N8O7C/cLcAIoxvLDHFZ/i/wAG2OkaUbDRUWWGRsCN0zk/WvdX8IWYRxq1ljjGFXrWU/"
            @"wbN9cre6fPxG2TG3II9KFhBRxbR86D4ORXMC3R05Yyc+YjjBB9qu6J8PdX0F1e2gDQnPXt9a+k4/"
            @"AekzObfUtM2HpkfzpsHwntrUEWEoZGP3HGfwoWEsyni7nl3h3w1ZS2vl31k6SEA7hXSWPw+"
            @"to0UiQ4fkEj7td7beENOjCrd6cEwOSB1I7Vci8OWE8uJHJRcYUcVX1UaxCZwLeB7WzTdPc+YH645xUGpaLpWk2jSWNiZSxwVAzXp0vh602g+"
            @"WuwfwdzVK48NLcDZZ6eME4OeKHhVYFiFfc8A8Z6ddaqA0cIiRT8ydCK4kfBmXxTqsdpZWhkUtmWZjxGPXPevqW8+EWnag3m6qGYjrt4x/"
            @"jT7fwDp1rbiw0O3WMj78hXBIrm+pzvc6PrVM+avFHgHT/CehzaVo9oV3x7Zm4y5+tcF4X8MavpWtfatMt5whbopwv4g19gav8ABfTLiRrrUZ/"
            @"Pbr5eMCo7b4WwmEQaZo6KvGd6dfxpPBzbsTLGQtY8Ob4Xa9rtgLq5jVWfGQxwce1PsvgfDCH868Coq8nOa99Hw0YRiW9cQ+"
            @"WuAgPWo7j4X6RcvukujyPm9fbFafU2Y/WvM+cvGHwkl+0x29pOsyFP3a7uT+FVIfgrqNsgV7ABlXdyK+h5fgnBcy/"
            @"aF1QqUb90r9TViX4Z3DIYLiVgVGVKnqfSnDCO4SxVz5l1P4WnUoRavbHzFBIXHGav+GvhZqVnac6dgBeTz+lfQ8XwqDFZnXLdGUYrQT4d20UKxC2Occ5Na/"
            @"VGjCWIUmeC2Pw0uwI98BXPOCDXo/"
            @"w58GXdpbxiWMbi3IHXFdxaeCECEyWwAB4BrZ0rwzFHGJI49rqQBgV0UsO0znqVOYueFdOksYVaGJwO+0A10do18socXJb0jaLH8qo2Gm3SRbIhhh2z1q/"
            @"bQ3iRFAZVYnkq2BXenbQ5XdstKl/LCyyM4Gfuuw2j6d6KSO0umTJuEGOu/wCYmik9yXe5hnSrCJM3kvzqowM5zS718srp9mAxPzAEc1LZ2UDkybcEAHAHHSi/"
            @"vZoFeO3Cpj+JRz+tL2kUVFIrtpsb/"
            @"vb+42E8hGNI8aQx7bGy+fuzdCPWpdNtorpfNnyzHqSanv5XsrYC3OPeo9rFvqbJKxnrpc9ycz3AUHrhsAUTaLpOSk0yt2GHHNSEG5TdMxbPUHpU+"
            @"n6bau5BU9MgA9KHUiTy3lZFNNK0nYVFwEPTlzj+VWY9IdIj9nnU8/eDZFObSrQSuCHOVzy56/"
            @"hUMkX2ZwYZGGDwM1LqK2xfI4q7HzAQoRqFspTbjOP1qGDTLSYjUNLuinGNnY1c0e+luLj7NMqkH+LHIpdXs7fTpHltE2MO/"
            @"rU+0j2Juis5RSIdUs8f9NIxkfjTo9MAbzNOuwR6jkH60/RtQmvkK3KIeD0Wp5bOKMGaFmQhf4DijnXYaV3Yq+e1u3l3GnfKW6jkH/CnhdLe4/"
            @"eWLD0wKn03UJppHWVEODgErV9bOBsyFBnGeAKrmiaezmkZhfR4WG2PDHg7lPFSF34S2swFP8RFXntYIsTLEpb1Kis7UtVuYHCRKi8jsf8AGi8SdO5KbCPb5l9"
            @"09F"
            @"pkkRmIhs7L5e8mOlWNPtY55RJMSxfqSak1CaS3YxwnAxiovIvQqT6bZx/vbg7mGAV/vU25jmuYwlrb+WF4q5ZWcD27XUi7n3dTTb6eSH/"
            @"VnFQqibuEooovpEQUteSc46N2qNdL0ufMcUrkhRkqtXoreOaQeZk5OTVltGslBmG/"
            @"cMAHdWntI9jPQym0fTpEEdvOQfWTrUi6Q0IWNwGA+"
            @"62OtX59Is48qNxA6AtVVLme0mWKF8Amn7SPYNCJdPjONrAZ7bfenzackIIfOS3BIrWm021urB7iVDu8vOQaz7O7mLCBiCuQMEdsUe0XYfukEdnCWwseRUqQQQ"
            @"cAg"
            @"85xUmoW8dlJ51tlT6DpVi0SO8ANxGrH1xV+"
            @"0REku5GiC6IkhYbsdM4qRbe53GKWFiFGc76jkt44ZsoTweMnpUEzNgyBiD7Gn7WFupndIv28Dxt80qoD6nNFVLK4kmjBbA2twVGKKSqQYaH/2Q=="
                            options:0];

    PPCroIDCombinedRecognizerResult *emirResult = [[PPCroIDCombinedRecognizerResult alloc] initWithFirstName:firstName
                                                                                                    lastName:lastName
                                                                                          identityCardNumber:identityCardNumber
                                                                                                         sex:sex
                                                                                                 nationality:nationality
                                                                                                 dateOfBirth:dateOfBirth
                                                                                        documentDateOfExpiry:documentDateOfExpiry
                                                                                                     address:address
                                                                                            issuingAuthority:issuingAuthority
                                                                                         documentDateOfIssue:documentDateOfIssue
                                                                                                         oib:oib
                                                                                                mrtdVerified:YES
                                                                                                matchingData:NO
                                                                                                 nonResident:NO
                                                                                           documentBilingual:NO
                                                                                                   signature:signature
                                                                                            signatureVersion:signatureVersion
                                                                                                   faceImage:image];

    return emirResult;
}

@end
