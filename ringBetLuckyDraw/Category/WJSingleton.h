//
//  WJSingleton.h
//  goldenGame
//
//  Created by CoderJay on 16/1/3.
//  Copyright © 2016年 golden. All rights reserved.
//

#ifndef WJSingleton_h
#define WJSingleton_h

#define WJSingletonH(methodName) + (instancetype)shared##methodName;
#if __has_feature(objc_arc) // 是ARC
#define WJSingletonM(methodName) \
static id instance = nil; \
+ (id)allocWithZone:(struct _NSZone *)zone \
{ \
if (instance == nil) { \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
instance = [super allocWithZone:zone]; \
}); \
} \
return instance; \
} \
\
- (id)init \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
instance = [super init]; \
}); \
return instance; \
} \
\
+ (instancetype)shared##methodName \
{ \
return [[self alloc] init]; \
} \
- (id)copyWithZone:(struct _NSZone *)zone \
{ \
return instance; \
} \
\
- (id)mutableCopyWithZone:(struct _NSZone *)zone{\
return instance;\
}
#else // 不是ARC
#define BHBSingletonM(methodName) \
static id instance = nil; \
+ (id)allocWithZone:(struct _NSZone *)zone \
{ \
if (instance == nil) { \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
instance = [super allocWithZone:zone]; \
}); \
} \
return instance; \
} \
\
- (id)init \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
instance = [super init]; \
}); \
return instance; \
} \
\
+ (instancetype)shared##methodName \
{ \
return [[self alloc] init]; \
} \
\
+ (oneway void)release \
{ \
\
} \
\
- (id)retain \
{ \
return self; \
} \
\
- (NSUInteger)retainCount \
{ \
return 1; \
} \
- (id)copyWithZone:(struct _NSZone *)zone \
{ \
return instance; \
} \
- (id)mutableCopyWithZone:(struct _NSZone *)zone \
{ \
return instance; \
}
#endif


#endif
