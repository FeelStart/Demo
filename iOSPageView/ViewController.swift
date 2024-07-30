//
//  ViewController.swift
//  iOSPageView
//
//  Created by Jingfu Li on 2024/7/30.
//

import UIKit
import JXPagingView

class ViewController: UIViewController {

    lazy var pagerView = JXPagingView(delegate: self)

    lazy var headerView = UIView()

    lazy var tabBar = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()

        headerView.backgroundColor = .red

        tabBar.backgroundColor = .green

        pagerView.backgroundColor = .gray
        pagerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pagerView)
        NSLayoutConstraint.activate([
            pagerView.topAnchor.constraint(equalTo: view.topAnchor),
            pagerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            pagerView.leftAnchor.constraint(equalTo: view.leftAnchor),
            pagerView.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
    }

}

extension ViewController {

    class TableView: UITableView, JXPagingViewListViewDelegate {

        func listView() -> UIView {
            self
        }
        
        func listScrollView() -> UIScrollView {
            self
        }
        
        func listViewDidScrollCallback(callback: @escaping (UIScrollView) -> ()) {
        }
        
    }
}

extension ViewController: JXPagingViewDelegate {

    func pagingView(_ pagingView: JXPagingView, initListAtIndex index: Int) ->  JXPagingViewListViewDelegate {
        let tableView = TableView()
        tableView.backgroundColor = .cyan
        return tableView
    }

    func tableHeaderViewHeight(in pagingView: JXPagingView) -> Int {
        200
    }
    
    func tableHeaderView(in pagingView: JXPagingView) -> UIView {
        headerView
    }
    
    func heightForPinSectionHeader(in pagingView: JXPagingView) -> Int {
        50
    }
    
    func viewForPinSectionHeader(in pagingView: JXPagingView) -> UIView {
        tabBar
    }
    
    func numberOfLists(in pagingView: JXPagingView) -> Int {
        3
    }
    
}
