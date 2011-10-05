//
//  SPDeepCopy.h
//
//  Created by Sherm Pendley on 3/15/09.
//
// Deep -copy and -mutableCopy methods for NSArray and NSDictionary

//http://stackoverflow.com/questions/5453481/how-to-do-true-deep-copy-for-nsarray-and-nsdictionary-with-have-nested-arrays-dic

#import <Foundation/Foundation.h>

@interface NSArray (SPDeepCopy)

- (NSArray*) deepCopy;
- (NSMutableArray*) mutableDeepCopy;

@end

@interface NSDictionary (SPDeepCopy)

- (NSDictionary*) deepCopy;
- (NSMutableDictionary*) mutableDeepCopy;

@end

