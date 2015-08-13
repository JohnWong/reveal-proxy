//
//  JWBonjourManager.m
//  RevealIt
//
//  Created by John Wong on 8/13/15.
//  Copyright © 2015 John Wong. All rights reserved.
//

#import "JWBonjourManager.h"
#import "JWBonjourUtil.h"
#import "JWBonjour.h"

@interface JWBonjourManager () <NSNetServiceBrowserDelegate, NSNetServiceDelegate>

@property (nonatomic, strong) NSString *hostName;

@end

@implementation JWBonjourManager

+ (void)load {
    [[self sharedInstance] start];
}

+ (instancetype)sharedInstance {
    static JWBonjourManager *helper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[JWBonjourManager alloc] init];
    });
    return helper;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _services = [NSMutableDictionary dictionary];
        _netBrowser = [[NSNetServiceBrowser alloc] init];
        _netBrowser.delegate = self;
        
    }
    return self;
}

- (void)start {
    [_netBrowser searchForServicesOfType:@"_reveal._tcp" inDomain:@"local"];
}

- (void)netServiceBrowser:(NSNetServiceBrowser *)browser didNotSearch:(NSDictionary *)errorDict {
    NSLog(@"%@:%s", self.class, __FUNCTION__);
}

- (void)netServiceBrowser:(NSNetServiceBrowser *)browser didFindService:(NSNetService *)service moreComing:(BOOL)moreComing {
    JWBonjour *bonjour = [[JWBonjour alloc] init];
    bonjour.service = service;
    _services[service.name] = bonjour;
    service.delegate = self;
    [service startMonitoring];
    [service resolveWithTimeout:5];
}

- (void)netServiceBrowser:(NSNetServiceBrowser *)browser didRemoveService:(NSNetService *)service moreComing:(BOOL)moreComing {
    if ([_services.allKeys containsObject:service.name]) {
        [_services removeObjectForKey:service.name];
    }
}

- (void)netServiceDidResolveAddress:(NSNetService *)sender {
    
    if ([_services.allKeys containsObject:sender.name]) {
        JWBonjour *bonjour = _services[sender.name];
        NSString *ip = [JWBonjourUtil queryIPByHost:sender.hostName];
        bonjour.ip = ip;
        [bonjour check];
    }
}


- (void)netService:(NSNetService *)sender didNotResolve:(NSDictionary *)errorDict {
    NSLog(@"%@:%s", self.class, __FUNCTION__);
}

- (void)netService:(NSNetService *)sender didUpdateTXTRecordData:(NSData *)data {
    if ([_services.allKeys containsObject:sender.name]) {
        JWBonjour *bonjour = _services[sender.name];
        bonjour.txt = [NSNetService dictionaryFromTXTRecordData:data];
        [bonjour check];
    }
}

@end