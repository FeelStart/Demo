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

        let flowLayout = UICollectionViewFlowLayout()

        let collectionNode = CollectionNode(collectionViewLayout: flowLayout)
        collectionNode.frame = view.bounds
        collectionNode.dataSource = self
        view.addSubnode(collectionNode)
    }
}

extension ViewController {

    class CollectionNode: ASCollectionNode {
    }

}

extension ViewController: ASCollectionDataSource {

}

extension ViewController {

    class CellNode: ASCellNode {

        let imageNode = ASImageNode()

        let nameNode = ASTextNode()

        let descNode = ASTextNode()

        override init() {
            super.init()

            addSubnode(imageNode)
            addSubnode(nameNode)
            addSubnode(descNode)
        }

        override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
            let layoutV = ASStackLayoutSpec.vertical()
            layoutV.spacing = 4
            layoutV.children = [nameNode, descNode]

            let layoutH = ASStackLayoutSpec.horizontal()

            return layoutH
        }
    }
}
