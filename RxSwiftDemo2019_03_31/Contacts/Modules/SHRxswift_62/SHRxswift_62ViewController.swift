//
//  SHRxswift_62ViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by 远平 on 2019/11/24.
//  Copyright © 2019 远平. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SHRxswift_62ViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //创建表格视图
        self.tableView = UITableView(frame: self.view.frame, style: .plain)
        
        //创建一个重用的单元格
        self.tableView.register(SHRxswift_62MyTableViewCell.self, forCellReuseIdentifier: "Cell")
        
        //单元格无法选中
        self.tableView.allowsSelection = false
        self.view.addSubview(self.tableView)
        
        //初始化数据
        let items = Observable.just([
            "文本输入框的用法",
            "开过按钮的用法",
            "进度条的用法",
            "文本标签的用法",
        ])
        
        //设置单元格数据（其实就是对 cellForRowAt 的封装）
        items.bind(to: tableView.rx.items) { (tableView, row, element) in
            //初始化cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! SHRxswift_62MyTableViewCell
            cell.textLabel?.text = "\(element)"
            
            //cell中按钮点击事件订阅
            cell.button.rx.tap.asDriver()
                .drive(onNext: { [weak self] in
                    self?.showAlert(title: "\(row)", message: element)
                })
                .disposed(by: cell.disposeBag)
            
            return cell
        }
        .disposed(by: disposeBag)
    }
    
    
    //显示弹出框消息
    func showAlert(title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
        
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true)
    }

}
