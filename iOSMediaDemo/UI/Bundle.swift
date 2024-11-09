//
//  Bundle.swift
//  Demo
//
//  Created by Jingfu Li on 2024/11/7.
//

import Foundation

extension Bundle {
    static var resourceBundle: Bundle {
        let url = Bundle.main.url(forResource: "Resource", withExtension: "bundle")!
        return Bundle(url: url)!
    }
}
