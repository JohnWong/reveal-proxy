//
//  JWBonjour.m
//  RevealIt
//
//  Created by John Wong on 8/13/15.
//  Copyright © 2015 John Wong. All rights reserved.
//

#import "JWBonjour.h"

@implementation JWBonjour

- (NSString *)formatedTxt {
    NSMutableString *mutableString = [NSMutableString string];
    [_txt enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSData *obj, BOOL * __nonnull stop) {
        NSString *value = [[NSString alloc] initWithData:obj encoding:NSUTF8StringEncoding];
        if ([key isEqualToString:@"devName"]) {
            value = [NSString stringWithFormat:@"Proxy %@", value];
        }
        [mutableString appendFormat:@" \"%@=%@\"", key, value];
    }];
    return mutableString;
}

- (BOOL)check {
    if (!_finished && _service.port > 0 && _txt.count > 0 && _service.hostName.length > 0 && _ip.length > 0) {
        _finished = YES;
        NSLog(@"Bonjour Run:\ndns-sd -P %@0000 _reveal._tcp local %@ %@ %@ %@", _service.name, @(_service.port), _ip, _ip, [self formatedTxt]);
    }
    return _finished;
}

@end