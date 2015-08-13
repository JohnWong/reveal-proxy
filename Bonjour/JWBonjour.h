//
//  JWBonjour.h
//  RevealIt
//
//  Created by John Wong on 8/13/15.
//  Copyright © 2015 John Wong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JWBonjour : NSObject

@property (nonatomic, strong) NSNetService *service;
@property (nonatomic, strong) NSDictionary *txt;
@property (nonatomic, strong) NSString *ip;
@property (nonatomic) BOOL finished;

- (BOOL)check;

@end
