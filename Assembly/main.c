//
//  main.c
//  Assembly
//
//  Created by Jingfu Li on 2024/12/23.
//

#include <stdio.h>

extern int add(int a, int b);
extern int greeting(void);

char *hi = "Hello!";

int main(int argc, const char * argv[]) {
    int result = add(8, 2);
    greeting();
    //printf("%s, World!\n", hi);
    return 0;
}
