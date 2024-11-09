//
//  Color.swift
//  Demo
//
//  Created by Jingfu Li on 2024/11/1.
//

import UIKit

extension UIColor {
    var randomColor: UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1)
    }
}
