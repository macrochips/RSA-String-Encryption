RSA-Encryption-Using-Modulus-Exponent
=============

An utility to encrypt String using RSA by using Modulus and Exponent parameters

## Features

- Uses openssl framework which is widely supported and used.
- Returns value in base64 encoded string such that no further decoding is needed.

## Usage

1. Add RSAStringEncryption Folder to Project (Preferred to 'Use Groups' and 'Copy Items if Needed').
2. Import "RSAStringEncryption.h" file to your class and use the provided method for the same.

## Example

**Code:**

```objc
#import "RSAStringEncryption.h"

NSString *sampleMod = @"119445732379544598056145200053932732877863846799652384989588303737527328743970559883211146487286317168142202446955508902936035124709397221178664495721428029984726868375359168203283442617134197706515425366188396513684446494070223079865755643116690165578452542158755074958452695530623055205290232290667934914919"; // 1024 bits
NSString *sampleExponent = @"65537"; // In most cases, its value will be this

NSString *encryptedString = [RSAStringEncryption getEncryptedStringByMod:sampleMod exponent:sampleExponent fromString:@"Sample String"];
```