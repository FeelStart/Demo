//
//  ImageRender.swift
//  MetalDemo
//
//  Created by Jingfu Li on 2024/7/3.
//

import Metal
import MetalKit

class ImageRender: NSObject {

    let image = UIImage(named: "cute_girl")

    var device: MTLDevice!

    override init() {
        super.init()
    }

    convenience init(mtkView: MTKView) {
        self.init()

        device = mtkView.device
    }
}

extension ImageRender: MTKViewDelegate {

    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
    }
    
    func draw(in view: MTKView) {
    }
    
}
