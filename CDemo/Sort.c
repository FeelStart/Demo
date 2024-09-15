//
//  Sort.c
//  CDemo
//
//  Created by Jingfu Li on 2024/9/14.
//

#include "Sort.h"

void buddle_sort_int(int array[], int length)
{
    for (int i = length - 1; i > 0; i--) {
        for (int j = 0; j < i; j++) {
            int temp = array[j + 1];
            if (array[j] > temp) {
                array[j + 1] = array[j];
                array[j] = temp;
            }
        }
    }
}

void insert_sort_int(int array[], int length)
{
    if (length <= 1) {
        return;
    }

    for (int i = 1; i < length; i++) {
        int temp = array[i];
        for (int j = i - 1; j >= 0; j--) {
            if (temp < array[j]) {
                array[j + 1] = array[j];
                array[j] = temp;
            }
        }
    }
}
