//
//  ViewController.swift
//  iOSMetal
//
//  Created by Jingfu Li on 2024/8/20.
//

import UIKit

class ViewController: UIViewController {

    var tableView: UITableView { view as! UITableView }

    var itemList = [Item]()

    override func viewDidLoad() {
        super.viewDidLoad()

        itemList.append(Item(title: "三角形", handler: { [weak self] in
            guard let self else { return }
        }))

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(Cell.self, forCellReuseIdentifier: "Cell")
        tableView.reloadData()

        addArrays()
    }

}

extension ViewController {

    struct Item {
        let title: String
        let handler: ( () -> Void )
    }

    class Cell: UITableViewCell {

        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    }

}

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itemList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = itemList[indexPath.row].title

        return cell
    }

}

extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        40
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        itemList[indexPath.row].handler()
    }

}
