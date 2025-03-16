//
//  HTURLRouteAction.m
//  HeartTrip
//
//  Created by vin on 2021/6/19.
//  Copyright © 2021 Vin. All rights reserved.
//

#import "URLRouteAction.h"

NSString * const HTURLRoute_CtrName = @"ctr";
NSString * const HTURLRoute_VmName = @"vm";
NSString * const HTURLRoute_SignName = @"sign";
NSString * const HTURLRoute_Jump = @"jump";

static URLRouteAction *_instance = nil;

@implementation URLRouteAction

#pragma mark - Life
+ (instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[URLRouteAction alloc] init];
    });
    return _instance;
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}
- (id)copy{
    return self;
}
- (id)mutableCopy{
    return self;
}

#pragma mark - Action
+ (void)customScheme:(NSString * _Nullable)scheme
             andHost:(NSString * _Nullable)host
           signCheck:(NSString * _Nullable)signSalt{
    URLRouteAction.sharedInstance.scheme = scheme;
    URLRouteAction.sharedInstance.host = host;
    URLRouteAction.sharedInstance.signSalt = signSalt;
}

+ (NSString *)mapNativeRouteBaseUrl {
    NSMutableString *urlstring = [NSMutableString stringWithString:URLRouteAction.sharedInstance.scheme];
    [urlstring appendString:@"://"];
    [urlstring appendString:URLRouteAction.sharedInstance.host];
    [urlstring appendString:@"/"];
    NSString *result = [NSString stringWithString:urlstring];
    return result;
}

+ (NSString *)mapNativeRouteUrl:(id _Nullable)value {
    if (![value isKindOfClass:NSDictionary.class] ||
        ![value isKindOfClass:NSMutableDictionary.class]) {
        return @"";
    }
    NSString *absoluteString = [URLRouteAction mapNativeRouteBaseUrl];
    NSMutableString *_add = nil;
    if (NSNotFound != [absoluteString rangeOfString:@"?"].location) {
        _add = [NSMutableString stringWithString:@"&"];
    }else {
        _add = [NSMutableString stringWithString:@"?"];
    }
    for (NSString *key in [value allKeys]) {
        if ([value objectForKey:key] && [[value objectForKey:key] length] > 0) {
            [_add appendFormat:@"%@=%@&",key,[[value objectForKey:key] stringByURLEncode]];
        }
    }
    if ([URLRouteAction.sharedInstance.signSalt isNotBlank]) {
        // 生成的签名串
        NSString *signatureStr = [URLRouteAction mapSignCheck:value];
        [_add appendFormat:@"%@=%@&",HTURLRoute_SignName,signatureStr];
    }
    return [NSString stringWithFormat:@"%@%@",absoluteString,[_add substringToIndex:[_add length] - 1]];
}

+ (NSString *)mapSignCheck:(id)params {
    
    NSString *signatureStr = @"";
    if ([params isKindOfClass:NSDictionary.class] ||
        [params isKindOfClass:NSMutableDictionary.class]) {
        // 将参数的key按字母进行排序
        NSArray *keys = [[params allKeys] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            return [obj1 compare:obj2 options:NSNumericSearch] == NSOrderedDescending;
        }];
        // 将除签名串外的参数的key与值拼接成字符串
        for (NSString *key in keys) {
            if (![key isEqualToString:HTURLRoute_SignName] && params[key]) {
                NSString *temp = [NSString vv_stringWithFormat:@"%@=%@",key,params[key]];
                signatureStr = [signatureStr isNotBlank] ? [NSString vv_stringWithFormat:@"%@&%@",signatureStr,temp] : temp;
            }
        }
        // 最后拼接一个固定的sign=签名串
        signatureStr = [NSString vv_stringWithFormat:@"%@&salt=%@",signatureStr,URLRouteAction.sharedInstance.signSalt];
        // 将拼接好的key进行一次MD5的哈希
        signatureStr = [signatureStr md5String];
    }
    return signatureStr;
}
@end
