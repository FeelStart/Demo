//
//  ViewController.swift
//  MetalDemo
//
//  Created by Jingfu Li on 2024/7/3.
//

import UIKit
import MetalKit

class ViewController: UIViewController {

    var mtkView: MTKView { self.view as! MTKView }

    lazy var render = ImageRender(mtkView: mtkView)

    override func loadView() {
        super.loadView()
        self.view = MTKView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        mtkView.delegate = render
        mtkView.clearColor = MTLClearColorMake(1, 0, 0, 1)
        mtkView.enableSetNeedsDisplay = true
    }
}

