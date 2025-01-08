//
//  Utils.s
//  Assembly
//
//  Created by Jingfu Li on 2024/12/23.
//

// 代码段
.text

// 外部函数声明
.global _add

// 4 字节对齐（ power(2) ）
.align 2

// 函数定义
_add:
    // ABI: x0 ~ x7 为参数寄存器
    // ABI: x0 为返回值寄存器
    add x0, x0, x1
    ret
