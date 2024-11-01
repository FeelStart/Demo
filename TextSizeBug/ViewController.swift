//
//  ViewController.swift
//  TextSizeBug
//
//  Created by Jingfu Li on 2024/11/1.
//

import UIKit

// 这个函数计算的高度不对
func calculateTextSize(text: String, font: UIFont, lineSpacing: CGFloat, width: CGFloat, numberOfLines: Int) -> CGSize {
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineSpacing = lineSpacing

    let attributes: [NSAttributedString.Key: Any] = [
        .font: font,
        .paragraphStyle: paragraphStyle,
    ]

    let textStorage = NSTextStorage(string: text, attributes: attributes)
    let layoutManager = NSLayoutManager()
    textStorage.addLayoutManager(layoutManager)

    let textContainer = NSTextContainer(size: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude))
    textContainer.lineFragmentPadding = 0
    textContainer.maximumNumberOfLines = numberOfLines
    textContainer.lineBreakMode = .byWordWrapping
    layoutManager.addTextContainer(textContainer)

    layoutManager.ensureLayout(for: textContainer)
    let size = layoutManager.usedRect(for: textContainer).size
    return size
}

/// 这个函数计算的高度会大一点
/// 参考：
/// - https://github.com/badoo/Chatto/issues/129
/// - https://github.com/leavez/Neat
/// - https://stackoverflow.com/questions/22826943/nsattributedstring-reporting-incorrect-sizes-for-uitextview-sizethatfits-and-bou
func calculateTextSize2(text: String, font: UIFont, lineSpacing: CGFloat, width: CGFloat, numberOfLines: Int) -> CGSize {
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineSpacing = lineSpacing

    let attributes: [NSAttributedString.Key: Any] = [
        .font: font,
        .paragraphStyle: paragraphStyle,
        NSAttributedString.Key(rawValue: "NSOriginalFont"): font
    ]

    let textStorage = NSTextStorage(string: text, attributes: attributes)
    let layoutManager = NSLayoutManager()
    textStorage.addLayoutManager(layoutManager)

    let textContainer = NSTextContainer(size: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude))
    textContainer.lineFragmentPadding = 0
    textContainer.maximumNumberOfLines = numberOfLines
    textContainer.lineBreakMode = .byWordWrapping
    layoutManager.addTextContainer(textContainer)

    layoutManager.ensureLayout(for: textContainer)
    let size = layoutManager.usedRect(for: textContainer).size
    return size
}

func calculateTextSize3(text: String, font: UIFont, lineSpacing: CGFloat, width: CGFloat, numberOfLines: Int) -> CGSize {
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineSpacing = lineSpacing

    let attributes: [NSAttributedString.Key: Any] = [
        .font: font,
        .paragraphStyle: paragraphStyle,
    ]

    let textStorage = NSTextStorage(string: text, attributes: attributes)
    textStorage.fixAttributes(in: NSRange(location: 0, length: text.count))

    let layoutManager = NSLayoutManager()
    textStorage.addLayoutManager(layoutManager)

    let textContainer = NSTextContainer(size: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude))
    textContainer.lineFragmentPadding = 0
    textContainer.maximumNumberOfLines = numberOfLines
    textContainer.lineBreakMode = .byWordWrapping
    layoutManager.addTextContainer(textContainer)

    layoutManager.ensureLayout(for: textContainer)
    let size = layoutManager.usedRect(for: textContainer).size
    return size
}

class ViewController: UIViewController {

    let label = UILabel()
    let font = UIFont.systemFont(ofSize: 20)
    let lineSpacing: CGFloat = 3
    let maxLines = 20

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        label.textColor = .black
        label.font = font
        label.numberOfLines = maxLines
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
        ])

        test()
    }
}

extension ViewController {
    func test() {
        let text = "【题材星球】是一个属于中小投资者的“全市场产业链数据库”。\n主要分享题材上下游深度梳理，拆解全市场产业链各环节与核心公司，前瞻政策预期，寻找行业信息差。以后你要看什么题材，直接到这个题材星球检索就可以了！\n————————\n提示：请扫描下方海报中的二维码加入。或者可以查看同名公众号：题材星球   。从公众号菜单找到加入本星球的二维码。"

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing

        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .paragraphStyle: paragraphStyle,
        ]

        let attributedString = NSMutableAttributedString(string: text, attributes: attributes)
        label.attributedText = attributedString

        let size = label.sizeThatFits(CGSize(width: view.bounds.width - 40, height: CGFloat.greatestFiniteMagnitude))
        print("size: \(size)")

        let size2 = calculateTextSize(text: text, font: font, lineSpacing: lineSpacing, width: view.bounds.width - 40, numberOfLines: maxLines)
        print("size2: \(size2)")

        let size3 = calculateTextSize2(text: text, font: font, lineSpacing: lineSpacing, width: view.bounds.width - 40, numberOfLines: maxLines)
        print("size3: \(size3)")

        let size4 = NSAttributedString(string: text, attributes: attributes).boundingRect(with: CGSize(width: view.bounds.width - 40, height: CGFloat.greatestFiniteMagnitude), options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil).size
        print("size4: \(size4)")

        let size5 = attributedString.boundingRect(with: CGSize(width: view.bounds.width - 40, height: CGFloat.greatestFiniteMagnitude), options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil).size
        print("size5: \(size5)")

        let size6 = calculateTextSize3(text: text, font: font, lineSpacing: lineSpacing, width: view.bounds.width - 40, numberOfLines: maxLines)
        print("size6: \(size6)")
    }
}


