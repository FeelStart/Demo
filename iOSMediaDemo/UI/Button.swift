//
//  Button.swift
//  Demo
//
//  Created by Jingfu Li on 2024/11/1.
//

import UIKit

open class Button: UIButton {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        layer.cornerRadius = 4
        clipsToBounds = true
        titleLabel?.font = .systemFont(ofSize: 16)
        setTitleColor(.black, for: .normal)
    }
}
