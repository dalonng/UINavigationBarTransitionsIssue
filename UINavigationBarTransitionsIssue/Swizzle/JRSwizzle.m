// JRSwizzle.m semver:1.0
//   Copyright (c) 2007-2011 Jonathan 'Wolf' Rentzsch: http://rentzsch.com
//   Some rights reserved: http://opensource.org/licenses/MIT
//   https://github.com/rentzsch/jrswizzle

#import "JRSwizzle.h"

#if TARGET_OS_IPHONE
	#import <objc/runtime.h>
	#import <objc/message.h>
#else
	#import <objc/objc-class.h>
#endif

#define SetNSErrorFor(FUNC, ERROR_VAR, FORMAT,...)	\
	if (ERROR_VAR) {	\
		NSString *errStr = [NSString stringWithFormat:@"%s: " FORMAT,FUNC,##__VA_ARGS__]; \
		*ERROR_VAR = [NSError errorWithDomain:@"NSCocoaErrorDomain" \
										 code:-1	\
									 userInfo:[NSDictionary dictionaryWithObject:errStr forKey:NSLocalizedDescriptionKey]]; \
	}
#define SetNSError(ERROR_VAR, FORMAT,...) SetNSErrorFor(__func__, ERROR_VAR, FORMAT, ##__VA_ARGS__)

@implementation NSObject (JRSwizzle)

+ (BOOL)jr_swizzleMethod:(SEL)origSel_ withMethod:(SEL)altSel_ error:(NSError**)error_ {
	Method origMethod = class_getInstanceMethod(self, origSel_);
	if (!origMethod) {
#if TARGET_OS_IPHONE
		SetNSError(error_, @"original method %@ not found for class %@", NSStringFromSelector(origSel_), [self class]);
#else
		SetNSError(error_, @"original method %@ not found for class %@", NSStringFromSelector(origSel_), [self className]);
#endif
		return NO;
	}
	
	Method altMethod = class_getInstanceMethod(self, altSel_);
	if (!altMethod) {
#if TARGET_OS_IPHONE
		SetNSError(error_, @"alternate method %@ not found for class %@", NSStringFromSelector(altSel_), [self class]);
#else
		SetNSError(error_, @"alternate method %@ not found for class %@", NSStringFromSelector(altSel_), [self className]);
#endif
		return NO;
	}
	
	class_addMethod(self,
					origSel_,
					class_getMethodImplementation(self, origSel_),
					method_getTypeEncoding(origMethod));
	class_addMethod(self,
					altSel_,
					class_getMethodImplementation(self, altSel_),
					method_getTypeEncoding(altMethod));
	
	method_exchangeImplementations(class_getInstanceMethod(self, origSel_), class_getInstanceMethod(self, altSel_));
	return YES;
}

+ (BOOL)jr_swizzleClassMethod:(SEL)origSel_ withClassMethod:(SEL)altSel_ error:(NSError**)error_ {
	return [object_getClass((id)self) jr_swizzleMethod:origSel_ withMethod:altSel_ error:error_];
}

@end
