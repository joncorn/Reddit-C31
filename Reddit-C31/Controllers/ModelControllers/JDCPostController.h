//
//  JDCPostController.h
//  Reddit-C31
//
//  Created by Jon Corn on 1/29/20.
//  Copyright © 2020 Jon Corn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JDCPost.h"
#import "UIKit/UIKit.h"

NS_ASSUME_NONNULL_BEGIN

@interface JDCPostController : NSObject

+ (instancetype)shared;

@property (nonatomic, copy) NSArray<JDCPost *> *posts;

- (void)fetchPosts: (void(^)(BOOL))completion;
- (void)fetchImageForPosts: (JDCPost *)post completion:(void(^) (UIImage * _Nullable))completion;

@end

NS_ASSUME_NONNULL_END
