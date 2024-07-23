//
//  ViewController.swift
//  iOSDemo
//
//  Created by Jingfu Li on 2024/7/23.
//

import UIKit
import AsyncDisplayKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let node = Node()
        node.backgroundColor = .red
        node.frame = view.bounds
        view.addSubnode(node)
    }
}

extension ViewController {

    class Node: ASDisplayNode {

        override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
            let imageNode = ASImageNode()

            let textNode = ASTextNode()
            textNode.attributedText = NSAttributedString(string: "Hi")

            return ASStackLayoutSpec(direction: .vertical,
                                     spacing: 10,
                                     justifyContent: .center,
                                     alignItems: .center,
                                     children: [imageNode, textNode])
        }
    }

}

extension ViewController {

    func example() {
        let imageNode = ASImageNode()
        view.addSubnode(imageNode)

        let textNode = ASTextNode()
        textNode.attributedText = NSAttributedString(string: "Hi")
        textNode.frame = CGRect(x: 0, y: 0, width: 200, height: 30)
        imageNode.addSubnode(textNode)

        DispatchQueue.global().async {
            imageNode.frame = CGRect(x: 40, y: 100, width: 200, height: 200)
            imageNode.image = UIImage(named: "cute_girl")
        }
    }

}
