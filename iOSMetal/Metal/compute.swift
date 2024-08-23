//
//  compute.swift
//  iOSMetal
//
//  Created by Jingfu Li on 2024/8/20.
//

import Foundation
import Metal

/// 并发地将两个数组相加
/// 比如：[1, 2, 3] + [1, 2, 3] = [2, 4, 6]
/// https://developer.apple.com/documentation/metal/performing_calculations_on_a_gpu
func addArrays() {
    // 1 获取 GPU 设备
    guard let device = MTLCreateSystemDefaultDevice() else {
        return
    }

    // 2 配置函数
    let library = device.makeDefaultLibrary()
    guard let function = library?.makeFunction(name: "add_arrays") else {
        return
    }

    // 将函数转换为可执行的代码
    guard let pipelineState = try? device.makeComputePipelineState(function: function) else {
        return
    }

    // 命令管道。数据通过 MTLCommandQueue 提交到 GPU。
    guard let commandQueue = device.makeCommandQueue() else {
        return
    }

    // 创建缓存
    let length = 5, floatStride = MemoryLayout<Float>.stride, bytesLength = length * floatStride
    guard let buffer1 = device.makeBuffer(length: bytesLength, options: .storageModeShared),
          let buffer2 = device.makeBuffer(length: bytesLength, options: .storageModeShared),
          let resultBuffer = device.makeBuffer(length: bytesLength, options: .storageModeShared) else {
        return
    }

    // 加载数据
    let generateBuffer: ( (any MTLBuffer) -> Void ) = {
        var desc = ""
        var contents = $0.contents()
        for _ in 0...length - 1 {
            let random = Float(Int.random(in: 1...300))
            desc += "\(random)   "
            contents.storeBytes(of: random, as: Float.self)
            contents = contents.advanced(by: floatStride)
        }
        print(desc)
    }
    generateBuffer(buffer1)
    generateBuffer(buffer2)

    // commad buffer
    guard let commandBuffer = commandQueue.makeCommandBuffer() else {
        return
    }

    // encoder
    guard let commandEncoder = commandBuffer.makeComputeCommandEncoder() else {
        return
    }

    commandEncoder.setComputePipelineState(pipelineState)
    commandEncoder.setBuffer(buffer1, offset: 0, index: 0)
    commandEncoder.setBuffer(buffer2, offset: 0, index: 1)
    commandEncoder.setBuffer(resultBuffer, offset: 0, index: 2)

    // thread and organization
    var maxThreadGroup = pipelineState.maxTotalThreadsPerThreadgroup
    if maxThreadGroup > length {
        maxThreadGroup = length
    }

    commandEncoder.dispatchThreadgroups(MTLSizeMake(length, 1, 1), threadsPerThreadgroup: MTLSizeMake(maxThreadGroup, 1, 1))

    commandEncoder.endEncoding()

    commandBuffer.commit()
    commandBuffer.waitUntilCompleted()

    print(resultBuffer.contents().load(as: Float.self))
}
