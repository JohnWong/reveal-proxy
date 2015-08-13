//
//  JWBonjourUtil.m
//  RevealIt
//
//  Created by John Wong on 8/13/15.
//  Copyright © 2015 John Wong. All rights reserved.
//

#include <ifaddrs.h>
#include <netdb.h>
#include <arpa/inet.h>

#import "JWBonjourUtil.h"

@implementation JWBonjourUtil

+ (NSString *)queryIPByHost:(NSString *)host {
    struct hostent *ipaddr = gethostbyname([host UTF8String]);
    char *addr = ipaddr->h_addr_list[0];
    NSString *result = nil;
    if (strlen(addr) >= 4) {
        result = [NSString stringWithFormat:@"%u.%u.%u.%u", (unsigned char)addr[0], (unsigned char)addr[1], (unsigned char)addr[2], (unsigned char)addr[3]];
    }
    return result;
}

+ (NSString *)deviceIP {
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
}

@end