//
//  Utils.c
//  CDemo
//
//  Created by Jingfu Li on 2024/9/14.
//

#include "Utils.h"

void print_array_int(int array[], int length)
{
    for (int i = 0; i < length; i++) {
        printf("%d  ", array[i]);
    }
    printf("\n");
}
