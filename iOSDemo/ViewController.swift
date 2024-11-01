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

/// 参考： https://github.com/badoo/Chatto/issues/129
extension ViewController {
    func sizeBug() {
        let text = "【题材星球】是一个属于中小投资者的“全市场产业链数据库”。\n主要分享题材上下游深度梳理，拆解全市场产业链各环节与核心公司，前瞻政策预期，寻找行业信息差。以后你要看什么题材，直接到这个题材星球检索就可以了！\n————————\n提示：请扫描下方海报中的二维码加入。或者可以查看同名公众号：题材星球   。从公众号菜单找到加入本星球的二维码。"

        let width: CGFloat = 200
        let height: CGFloat = .greatestFiniteMagnitude
        let maxline = 6

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3

        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 14),
            .paragraphStyle: paragraphStyle,
            //NSAttributedString.Key(rawValue: "NSOriginalFont"): font
        ]

        let label = UILabel()
        label.numberOfLines = maxline
        label.attributedText = NSAttributedString(string: text, attributes: attributes)
        let size = label.sizeThatFits(CGSize(width: width, height: height))
        print("size: \(size)")

        let textStorage = NSTextStorage(string: text,
                                        attributes: attributes)
        let layoutManager = NSLayoutManager()
        textStorage.addLayoutManager(layoutManager)
        let textContainer = NSTextContainer(size: CGSize(width: width, height: height))
        textContainer.maximumNumberOfLines = maxline
        layoutManager.addTextContainer(textContainer)
        let size2 = layoutManager.usedRect(for: textContainer).size
        print("size2: \(size2)")
    }
}
