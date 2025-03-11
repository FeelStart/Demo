//
//  Button.swift
//  Demo
//
//  Created by Jingfu Li on 2025/2/5.
//

import UIKit

open class Button: UIButton {
        
    open var margin = UIEdgeInsets.zero
    
    open var spacing: CGFloat = 0
    
    open var title: String?
    
    open var titleColor: UIColor?
    
    open var image: UIImage?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension Button {
    
    public func title(_ title: String) -> Self {
        self.title = title
        return self
    }
    
}
