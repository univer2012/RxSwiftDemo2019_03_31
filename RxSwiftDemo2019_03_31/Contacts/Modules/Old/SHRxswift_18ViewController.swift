//
//  SHRxswift_18ViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by Mac on 2019/7/17.
//  Copyright © 2019 远平. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa
import RxDataSources

import RxAlamofire


class SHRxswift_18ViewController: UIViewController {
    let disposeBag = DisposeBag()
    var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //创建表格视图
        self.tableView = UITableView(frame: self.view.frame, style: .plain)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(self.tableView)
        //创建URL对象
        let urlString = "https://www.douban.com/j/app/radio/channels"
        let url = URL(string: urlString)!
        #if true
        //model
        //获取列表数据
        let data = requestJSON(.get, url)
            .map {$1}
        .mapObject(type: Douban.self)
            .map {$0.channels ?? []}
        //将数据绑定到表格
        data.bind(to: tableView.rx.items) { (tableView, row, element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
            cell.textLabel?.text = "\(row): \(element.name!)"
            return cell
        }.disposed(by: disposeBag)
        
        #else
        //字典
        //获取列表数据
        let data = requestJSON(.get, url)
            .map { (response, data) -> [[String: Any]] in
                if let json = data as? [String: Any], let channels = json["channels"] as? [[String: Any]] {
                    return channels
                } else {
                    return []
                }
        }
        //将数据绑定到表格
        data.bind(to: tableView.rx.items) {(tableView, row, element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
            cell.textLabel?.text = "\(row): \(element["name"]!)"
            return cell
            }.disposed(by: disposeBag)
        #endif
    }
}


