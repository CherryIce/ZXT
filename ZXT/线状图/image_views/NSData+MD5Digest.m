//
//  NSData+MD5Digest.m
//  ZXT
//
//  Created by 1 on 2019/5/30.
//  Copyright © 2019 Free world co., LTD. All rights reserved.
//

#import "NSData+MD5Digest.h"

#import <CommonCrypto/CommonDigest.h>

@implementation NSData (MD5Digest)

+(NSData *)MD5Digest:(NSData *)input {
    
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(input.bytes, (CC_LONG)input.length, result);
    
    return [[NSData alloc] initWithBytes:result length:CC_MD5_DIGEST_LENGTH];
    
}

- (NSData *)MD5Digest {
    return [NSData MD5Digest:self];
}

+(NSString *)MD5HexDigest:(NSData *)input {
    
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    
    
    
    CC_MD5(input.bytes, (CC_LONG)input.length, result);
    
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];
    
    for (int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    
    return ret;
}

- (NSString *)MD5HexDigest {
    return [NSData MD5HexDigest:self];
}

@end
