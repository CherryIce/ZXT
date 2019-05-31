//
//  NSData+MD5Digest.h
//  ZXT
//
//  Created by 1 on 2019/5/30.
//  Copyright © 2019 Free world co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (MD5Digest)

+ (NSData *)MD5Digest:(NSData *)input;

- (NSData *)MD5Digest;

+ (NSString *)MD5HexDigest:(NSData *)input;

- (NSString *)MD5HexDigest;

@end

NS_ASSUME_NONNULL_END
