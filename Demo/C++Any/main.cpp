//
//  main.cpp
//  C++Any
//
//  Created by Jingfu Li on 2024/7/10.
//

#include <iostream>
#include <assert.h>
#include <any>

int main(int argc, const char * argv[]) 
{
    using namespace std;

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
