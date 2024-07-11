//
//  main.cpp
//  C++ConceptDemo
//
//  Created by Jingfu Li on 2024/7/3.
//

#include <iostream>
#include <concepts>

template<typename T>
concept is_callable = requires(T f) { f(); };

template<typename T>
void run(T callback) requires is_callable<T>
{
    std::cout<<"run"<<std::endl;
    callback();
}

class Callable {
public:
    void operator()()
    {
        std::cout<<"Callable"<<std::endl;
    };
};

template<typename T>
requires std::is_integral_v<T> || std::is_floating_point_v<T>
constexpr auto sum(T v1, T v2)
{
    return v1 + v2;
}

int main(int argc, const char * argv[]) 
{
    run(Callable());

    std::cout << "Hello, World!\n";
    return 0;
}
