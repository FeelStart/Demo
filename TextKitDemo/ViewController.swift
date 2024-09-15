//
//  ViewController.swift
//  TextKitDemo
//
//  Created by Jingfu Li on 2024/9/13.
//

import UIKit
import Component
import SnapKit

class ViewController: UIViewController {

    let textView = TextView()

    override func viewDidLoad() {
        super.viewDidLoad()

        textView.backgroundColor = .blue
        textView.attributedString = NSAttributedString(string: "Hi")
        view.addSubview(textView)
        textView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 200, height: 200))
        }
    }
}

