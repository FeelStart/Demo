//
//  main.m
//  OCDemo
//
//  Created by Jingfu Li on 2024/8/7.
//

#import <Foundation/Foundation.h>

@interface Container : NSObject

@property(nonatomic) id object;

@end

@implementation Container

@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSString *str0 = @"Hi";
        NSString *str1 = str0.copy;
        NSString *str2 = str0.copy;

        Container *c0 = [[Container alloc] init];
        c0.object = str0;

        Container *c1 = [[Container alloc] init];
        c1.object = str0;

        Container *c2 = [[Container alloc] init];
        c2.object = str0;

        NSNumber *n0 = @5;
        NSNumber *n1 = @3;
        NSNumber *n2 = @2222222222222222222;

        NSLog(@"%@", str0);
        NSLog(@"Hello, World!");
    }
    return 0;
}
