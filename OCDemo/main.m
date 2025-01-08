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

@interface Div : Container

@end

@implementation Div

@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSString *str0 = @"Hi0000end";
        NSString *str1 = str0.copy;
        NSString *str2 = str0.copy;

        Class cls = NSClassFromString(@"Div");

        typedef struct {
            Class isa;
            Class supperclass;

            // cache
            uintptr_t bucket;
            uint32_t mask;
            uint32_t occupied;

            uintptr_t bits;
        } CLASS;

        CLASS *clsInfo = (__bridge CLASS *)(cls);

        Container *c0 = [[Container alloc] init];
        c0.object = str0;
        //[c0 performSelector:NSSelectorFromString(@"test:")];

        Container *c1 = [[Container alloc] init];
        c1.object = str0;

        Container *c2 = [[Container alloc] init];
        c2.object = str0;

        NSNumber *n0 = @5;
        NSNumber *n1 = @(3UL);
        NSNumber *n2 = @2222222222222222222;

        NSLog(@"%@ %@", NSStringFromClass(Container.class), NSStringFromClass(Container.superclass));

        NSLog(@"%@", str0);
        NSLog(@"Hello, World!");
    }
    return 0;
}
