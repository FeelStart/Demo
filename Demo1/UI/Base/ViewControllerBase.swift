//
//  ViewControllerBase.swift
//  Demo
//
//  Created by Jingfu Li on 2025/3/11.
//

import UIKit
import Hero

class ViewControllerBase: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.hero.isEnabled = true
        hero.isEnabled = true
        
        view.backgroundColor = .white
    }
}
