//
//  JDCPost.m
//  Reddit-C31
//
//  Created by Jon Corn on 1/29/20.
//  Copyright © 2020 Jon Corn. All rights reserved.
//

#import "JDCPost.h"

#pragma mark - Keys
static NSString * const titleKey = @"title";
static NSString * const thumbnailKey = @"thumbnail";

@implementation JDCPost

#pragma mark - Methods
- (instancetype)initWithTitle:(NSString *)title thumbnail:(NSString *)thumbnail
{
    self = [self init];
    if (self)
    {
        _title = [title copy];
        _thumbnail = [thumbnail copy];
    }
    return self;
}

@end

#pragma mark - Dictionary extension
@implementation JDCPost (JSONConvertable)

- (instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)dictionary
{
    NSString *title = dictionary[titleKey];
    NSString *thumbnail = dictionary[thumbnailKey];
    
    return [self initWithTitle:title thumbnail:thumbnail];
}

@end
