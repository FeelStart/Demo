//
//  main.cpp
//  C++Any
//
//  Created by Jingfu Li on 2024/7/10.
//

//
// 该项目已启动 ASLR（）
// https://bellis1000.medium.com/aslr-the-ios-kernel-how-virtual-address-spaces-are-randomised-d76d14dc7ebb
// 启动 ASLR：
// 1，Edit Scheme ——> Debug excuable

#include <iostream>
#include <assert.h>
#include <any>

auto Hello = "Hello";

int main(int argc, const char * argv[]) 
{
    using namespace std;

    printf("ptr **** %p\n", Hello);

    any v;
    assert(!v.has_value());
    v = 30;

    try {
        __unused auto c = any_cast<int>(v);
    } catch (const bad_any_cast e) {
        cout<<e.what()<<endl;
    }

    return 0;
}
