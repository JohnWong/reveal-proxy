//
//  JWBonjourUtil.h
//  RevealIt
//
//  Created by John Wong on 8/13/15.
//  Copyright © 2015 John Wong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JWBonjourUtil : NSObject

+ (NSString *)queryIPByHost:(NSString *)host;
+ (NSString *)deviceIP;

@end
