//
//  JDCPostController.m
//  Reddit-C31
//
//  Created by Jon Corn on 1/29/20.
//  Copyright © 2020 Jon Corn. All rights reserved.
//

#import "JDCPostController.h"

// String helpers
static NSString * const baseURL = @"http://www.reddit.com";
static NSString * const rComponentString = @"r";
static NSString * const funnyComponent = @"funny";
static NSString * const JSONExtension = @"json";

@implementation JDCPostController

// Shared instance
+ (instancetype)shared
{
    static JDCPostController *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [JDCPostController new];
    });
    return shared;
}

#pragma mark - Fetch Post
- (void)fetchPosts:(void (^)(BOOL))completion
{
    // Build url
    NSURL *url = [NSURL URLWithString:baseURL];
    NSURL *rURL = [url URLByAppendingPathComponent:rComponentString];
    NSURL *funnyURL = [rURL URLByAppendingPathComponent:funnyComponent];
    NSURL *finalURL = [funnyURL URLByAppendingPathExtension:JSONExtension];
    // DataTask
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        // Handle Error
        if (error) {
            NSLog(@"%@", error.localizedDescription);
            completion(false);
            return;
        }
        // Handle no data
        if (!data) {
            NSLog(@"%@", error.localizedDescription);
            completion(false);
            return;
        }
        // Access top level dictionary
        NSDictionary *TopLevelJSON = [NSJSONSerialization JSONObjectWithData:data options:2 error: &error];
        
        if(!TopLevelJSON) {
            NSLog(@"%@", error.localizedDescription);
            completion(false);
            return;
        }
        
        // Building the dictionary hierarchy
        NSDictionary *secondLevelJSON = TopLevelJSON[@"data"];
        NSArray<NSDictionary * > *childrenArray = secondLevelJSON[@"children"];
        NSMutableArray *postsArray = [NSMutableArray new];
        // Loop through array of posts and append each to above placeholder array
        for (NSDictionary *currentDictionary in childrenArray) {
            NSDictionary *postDictionary = currentDictionary[@"data"];
            JDCPost *post = [[JDCPost alloc] initWithDictionary:postDictionary];
            [postsArray addObject:post];
        }
        // Throws posts into our source of truth
        if (postsArray.count != 0) {
            JDCPostController.shared.posts = postsArray;
            completion(true);
        } else {
            completion(false);
        }
        
    }] resume];
}

#pragma mark - Fetch Image
- (void)fetchImageForPosts:(JDCPost *)post completion:(void (^)(UIImage * _Nullable))completion
{
    // Build image URL
    NSURL *imageURL = [NSURL URLWithString:post.thumbnail];
    // DataTask
    [[[NSURLSession sharedSession] dataTaskWithURL:imageURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        // Handle error
        if (error) {
            NSLog(@"%@", error.localizedDescription);
            completion(false);
            return;
        }
        
        if (response) {
            NSLog(@"%@", error.localizedDescription);
            completion(false);
            return;
        }
        // Handle data
        if (data) {
        // Decode image
        UIImage *postThumbnail = [UIImage imageWithData:data];
        completion(postThumbnail);
        }
        
    }] resume];
}

@end
