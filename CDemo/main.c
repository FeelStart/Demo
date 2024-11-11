//
//  main.c
//  CDemo
//
//  Created by Jingfu Li on 2024/9/14.
//

#include <stdio.h>
#include "Sort.h"
#include "Utils.h"

// C 语言
int main(int argc, const char * argv[])
{
    int array[] = { 7, 5, 3, 2, 1, 4 };
    int length = sizeof(array) / sizeof(int);
    insert_sort_int(array, length);
    print_array_int(array, length);

    return 0;
}
