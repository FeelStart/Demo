//
//  compute.metal
//  iOSMetal
//
//  Created by Jingfu Li on 2024/8/20.
//

#include <metal_stdlib>
using namespace metal;

// 并发地将两个数组相加
// 比如 [1, 2, 3] + [1, 2, 3] = [2, 4, 6]
kernel void add_arrays(device float *inA,
                       device float *inB,
                       device float *outResult,
                       uint index[[thread_position_in_grid]])
{
    outResult[index] = inA[index] + inB[index];
}
