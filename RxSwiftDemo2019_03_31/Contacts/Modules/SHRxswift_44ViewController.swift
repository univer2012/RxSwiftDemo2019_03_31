//
//  SHRxswift_44ViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by Mac on 2019/11/4.
//  Copyright © 2019 远平. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SHRxswift_44ViewController: UIViewController {
    
    var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //创建表格视图
        self.tableView = UITableView(frame: self.view.frame, style: .plain)
        //创建一个重用的单元格
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(self.tableView)


        //创建URL对象
        let urlString = "https://www.douban.com/j/app/radio/channels"
        let url = URL(string: urlString)
        //创建请求对象
        let request = URLRequest(url: url!)
        
        //获取列表数据
        let data = URLSession.shared.rx.json(request: request).mapObject(type: Douban.self).map{$0.channels ?? []}
        
        //将数据绑定到表格
        data.bind(to: tableView.rx.items){ (tableView, row, element) in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
            cell.textLabel?.text = "\(row): \(element.name!)"
            return cell
            
        }.disposed(by: disposeBag)
        
    }

}


//MARK: 字典
#if false
class SHRxswift_44ViewController: UIViewController {
    
    var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //创建表格视图
        self.tableView = UITableView(frame: self.view.frame, style: .plain)
        //创建一个重用的单元格
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(self.tableView)


        //创建URL对象
        let urlString = "https://www.douban.com/j/app/radio/channels"
        let url = URL(string: urlString)
        //创建请求对象
        let request = URLRequest(url: url!)
        
        //获取列表数据
        let data = URLSession.shared.rx.json(request: request).map{ result -> [[String: Any]] in
            if let data = result as? [String: Any], let channels = data["channels"] as? [[String: Any]] {
                return channels
            } else {
                return []
            }
        }
        
        //将数据绑定到表格
        data.bind(to: tableView.rx.items){ (tableView, row, element) in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
            cell.textLabel?.text = "\(row): \(element["name"]!)"
            return cell
            
        }.disposed(by: disposeBag)
        
    }

}
#endif
