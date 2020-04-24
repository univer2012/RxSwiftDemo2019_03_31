//
//  SHRxswift_46ViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by 远平 on 2019/11/4.
//  Copyright © 2019 远平. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxAlamofire

class SHRxswift_46ViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    var tableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //创建表格视图
        self.tableView = UITableView(frame: self.view.frame, style: .plain)
        //创建一个重用的单元格
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(self.tableView)
        
        //创建URL对象
        let urlString = "https://www.douban.com/j/app/radio/channels"
        let url = URL(string: urlString)!
        
        
        
        //获取列表数据
        let data = requestJSON(.get, url).map{$1}.mapObject(type: Douban.self).map{$0.channels ?? []}
        //将数据绑定到表格
        data.bind(to: tableView.rx.items){ (tableView, row, element) in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
            cell.textLabel?.text = "\(row): \(element.name!)"
            return cell
            
        }.disposed(by: disposeBag)
        
    }
    
}


////创建URL对象
//let urlString = "https://www.douban.com/j/app/radio/channels"
//let url = URL(string: urlString)!
//
////创建并发起请求
//requestJSON(.get, url).map{$1}.mapObject(type: Douban.self).subscribe(onNext: { (douban: Douban) in
//    if let channels = douban.channels {
//        print("--- 共\(channels.count)个频道 ---")
//        for channel in channels {
//            if let name = channel.name, let channelId = channel.channelId {
//                print("\(name) (id:\(channelId)")
//            }
//        }
//    }
//}).disposed(by: disposeBag)






#if false
class SHRxswift_46ViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    var tableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //创建表格视图
        self.tableView = UITableView(frame: self.view.frame, style: .plain)
        //创建一个重用的单元格
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(self.tableView)
        
        //创建URL对象
        let urlString = "https://www.douban.com/j/app/radio/channels"
        let url = URL(string: urlString)!

        //获取列表数据
        let data = requestJSON(.get, url).map{response,data -> [[String: Any]] in
            if let json = data as? [String: Any], let channels = json["channels"] as? [[String: Any]] {
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


////创建URL对象
//let urlString = "https://www.douban.com/j/app/radio/channels"
//let url = URL(string: urlString)!
//
////创建并发起请求
//request(.get, url).responseJSON().subscribe(onNext: { (dataResponse) in
//    let json = dataResponse.value as! [String: Any]
//    print("--- 请求成功！返回的如下数据 ---")
//    print(json)
//}).disposed(by: disposeBag)



////创建URL对象
//let urlString = "https://www.douban.com/j/app/radio/channels"
//let url = URL(string: urlString)!
//
////创建并发起请求
//request(.get, url).data().subscribe(onNext: { (data) in
//    let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any]
//    print("--- 请求成功！返回的如下数据 ---")
//    print(json!)
//}).disposed(by: disposeBag)

