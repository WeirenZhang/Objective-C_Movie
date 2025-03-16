//
//  HTBaseViewModel.h
//  HeartTrip
//
//  Created by vin on 2021/5/26.
//  Copyright © 2021 Vin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewModelProtocol.h"
#import "BaseEnum.h"

NS_ASSUME_NONNULL_BEGIN

#define isKey(_key) [key isEqualToString:_key]

@interface BaseViewModel : NSObject <ViewModelProtocol>

/// 空占位图类型
@property (nonatomic,assign) EmptyType  emptyType;

/// 根据key，配置相应的Command
/// @param key key
- (RACCommand *)commandForKey:(NSString * _Nullable)key;

/// 根据key，配置相应的EnabledSignal
/// @param key key
- (RACSignal *)commandEnabledSignalForKey:(NSString * _Nullable)key;

/// 根据key，配置Command的执行Signal
/// @param input Command的input
/// @param key key
- (RACSignal *)commandSignalWithInput:(id _Nullable)input forKey:(NSString * _Nullable)key;


@end

NS_ASSUME_NONNULL_END
