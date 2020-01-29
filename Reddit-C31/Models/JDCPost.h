//
//  JDCPost.h
//  Reddit-C31
//
//  Created by Jon Corn on 1/29/20.
//  Copyright © 2020 Jon Corn. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JDCPost : NSObject
// Properties
@property (nonatomic, copy, readonly, nonnull) NSString *title;
@property (nonatomic, copy, readonly, nullable) NSString *thumbnail;
// Initializer
- (instancetype)initWithTitle:(NSString *)title
                    thumbnail:(NSString *)thumbnail;

@end

// Extension for dictionary
@interface JDCPost (JSONConvertable)
// Dictionary initializer
- (instancetype)initWithDictionary:(NSDictionary<NSString *, id> *)dictionary;

@end

NS_ASSUME_NONNULL_END
