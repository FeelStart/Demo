//
//  ViewController.swift
//  CollectionView
//
//  Created by Jingfu Li on 2024/8/7.
//

import UIKit

class Layout: UICollectionViewFlowLayout {

    override init() {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepare() {
        super.prepare()
        print(#function)

        if let collectionView, let attributes = layoutAttributesForItem(at: IndexPath(row: 0, section: 0)) {
            let contentOffset = collectionView.contentOffset
            var frame = attributes.frame
            attributes.frame = CGRect(x: 0, y: frame.origin.y - contentOffset.y, width: frame.width, height: 10)
            print("\(contentOffset)")
        }
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)
        return attributes
    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        true
    }

    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        let point = super.targetContentOffset(forProposedContentOffset: proposedContentOffset)
        return point
    }
}

class ViewController: UIViewController {

    lazy var layout: Layout = {
        let layout = Layout()
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.bounds.width, height: 40)

        return layout
    }()

    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        //collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(Cell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])

        layout.invalidateLayout()
        collectionView.reloadData()
    }

}

extension ViewController {

    class Cell: UICollectionViewCell {

        override init(frame: CGRect) {
            super.init(frame: frame)

            let range = 1...265
            let red = CGFloat(range.randomElement() ?? 1) / 256
            let green = CGFloat(range.randomElement() ?? 1) / 256
            let blue = CGFloat(range.randomElement() ?? 1) / 256

            contentView.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }

}

extension ViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        20
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? Cell else {
            fatalError()
        }

        return cell
    }

}

extension ViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.bounds.width, height: 40)
    }

}
