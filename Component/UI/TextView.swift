//
//  TextView.swift
//  Component
//
//  Created by Jingfu Li on 2024/9/13.
//

import UIKit

// https://developer.apple.com/documentation/appkit/textkit/using_textkit_2_to_interact_with_text
@available(iOS 15, *)
public class TextView: UIView {
    let textLayoutManager = NSTextLayoutManager()
    let textViewport: NSTextViewportLayoutController
    let textStorage = NSTextContentStorage()
    let textContainer: NSTextContainer

    public var attributedString: NSAttributedString? {
        didSet {
            textStorage.textStorage?.append(attributedString ?? NSAttributedString())
            setNeedsDisplay()
        }
    }

    public override init(frame: CGRect) {
        textStorage.addTextLayoutManager(textLayoutManager)

        textContainer = NSTextContainer(size: frame.size)
        textLayoutManager.textContainer = textContainer

        textViewport = NSTextViewportLayoutController(textLayoutManager: textLayoutManager)

        super.init(frame: frame)

        textStorage.delegate = self
        textLayoutManager.delegate = self
        textViewport.delegate = self
    }

    public override var bounds: CGRect {
        didSet {
            textContainer.size = bounds.size
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func draw(_ rect: CGRect) {
        super.draw(rect)

        guard let ctx = UIGraphicsGetCurrentContext() else {
            return
        }

        if let fragment = textLayoutManager.textLayoutFragment(for: .zero) {
            fragment.draw(at: .zero, in: ctx)
        }
    }
}

//MARK: - NSTextLayoutManagerDelegate
extension TextView: NSTextLayoutManagerDelegate {
    public func textLayoutManager(_ textLayoutManager: NSTextLayoutManager, textLayoutFragmentFor location: any NSTextLocation, in textElement: NSTextElement) -> NSTextLayoutFragment {
        let textRange = NSTextRange(location: location)
        let fragment = TextLayoutFragment(textElement: textElement, range: textRange)
        return fragment
    }
}

//MARK: - NSTextViewportLayoutControllerDelegate
extension TextView: NSTextViewportLayoutControllerDelegate {
    public func viewportBounds(for textViewportLayoutController: NSTextViewportLayoutController) -> CGRect {
        bounds
    }
    
    public func textViewportLayoutController(_ textViewportLayoutController: NSTextViewportLayoutController, configureRenderingSurfaceFor textLayoutFragment: NSTextLayoutFragment) {
    }
}

//MARK: - NSTextContentStorageDelegate
extension TextView: NSTextContentStorageDelegate {
}

//MARK: - TextLayoutFragment
extension TextView {
    class TextLayoutFragment: NSTextLayoutFragment {
        override var topMargin: CGFloat { 5 }
    }
}
