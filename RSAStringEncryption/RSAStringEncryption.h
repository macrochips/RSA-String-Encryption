//
//  RSAStringEncryption.h
//  TestTrials
//
//  Created by Vaibhav Nath on 21/12/16.
//  Copyright © 2016 Macrochips. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSAStringEncryption : NSObject

+ (NSString *)getEncryptedStringByMod:(NSString *)mod exponent:(NSString *)expo fromString:(NSString *)stockString;

@end
