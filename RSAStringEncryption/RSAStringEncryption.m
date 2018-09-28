//
//  RSAStringEncryption.m
//  TestTrials
//
//  Created by Vaibhav Nath on 21/12/16.
//  Copyright © 2016 Macrochips. All rights reserved.
//

#import "RSAStringEncryption.h"
#import  <Security/Security.h>
#include <openssl/rsa.h>
#include <openssl/opensslv.h>
#include <openssl/evp.h>
#include <openssl/bn.h>

@implementation RSAStringEncryption

+ (NSString *)getEncryptedStringByMod:(NSString *)mod exponent:(NSString *)expo fromString:(NSString *)stockString
{
    BIGNUM *modulus = BN_new();
    int res = BN_hex2bn(&modulus,[mod cStringUsingEncoding:NSUTF8StringEncoding]);
    BIGNUM *exponent = BN_new();
    res = BN_hex2bn(&exponent,[expo cStringUsingEncoding:NSUTF8StringEncoding]);
    RSA *rsaKey = RSA_new();
    rsaKey->n = BN_new();
    BN_copy(rsaKey->n,modulus);
    rsaKey->e = BN_new();
    BN_copy(rsaKey->e,exponent);
    rsaKey->iqmp=NULL;
    rsaKey->d=NULL;
    rsaKey->p=NULL;
    rsaKey->q=NULL;
    
    // Calculate the length of the cipher text.
    int maxRsaSize = RSA_size(rsaKey);
    // Create a NSMutableData with the calculated size.
    NSMutableData *cipherData = [[NSMutableData alloc] initWithLength:maxRsaSize] ;
    // Encrypt the plain text using RSA public encryption using the passed in Key. Use OAEP padding because thats what the .net side expects.
    unsigned char *orgTxt = (unsigned char*)strdup([stockString UTF8String]);
    int ret = RSA_public_encrypt((int)strlen((const char*)orgTxt), orgTxt, [cipherData mutableBytes], rsaKey,RSA_PKCS1_PADDING);
    if (ret == -1)
    {
        RSA_free(rsaKey);
        return nil;
    }
    // Free the RSA key.
    RSA_free(rsaKey);
    NSLog(@"Generated Token: %@",[cipherData base64EncodedStringWithOptions:0]);
//    return [cipherData base64EncodedStringWithOptions:0];
    return [self encodeStringTo64:[cipherData base64EncodedStringWithOptions:0]];
}

+ (NSString*)encodeStringTo64:(NSString*)fromString
{
    NSData *plainData = [fromString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String;
    if ([plainData respondsToSelector:@selector(base64EncodedStringWithOptions:)]) {
        base64String = [plainData base64EncodedStringWithOptions:kNilOptions];  // iOS 7+
    } else {
        base64String = [plainData base64EncodedStringWithOptions:0];         // pre iOS7
    }
    
    return base64String;
}

@end
