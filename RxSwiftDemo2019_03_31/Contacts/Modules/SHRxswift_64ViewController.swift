//
//  SHRxswift_64ViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by 远平 on 2019/11/25.
//  Copyright © 2019 远平. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SHRxswift_64ViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    var tableView: UITableView!
    
    ///导航栏背景视图
    var barImageView: UIView?
        
    override func viewDidLoad() {
        super.viewDidLoad()

        //导航栏背景色为橙色
        self.navigationController?.navigationBar.barTintColor = .orange
        
        //获取导航栏背景视图
        self.barImageView = self.navigationController?.navigationBar.subviews.first
        
        //创建表格视图
        self.tableView = UITableView(frame: self.view.frame, style: .plain)
        //创建一个重用的单元格
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(self.tableView)
        
        //初始化数据
        let items = Observable.just(Array(0...100).map{ "这个是条目\($0)" })
        
        //设置单元格数据（其实就是对 cellForRowAt 的封装）
        items.bind(to: tableView.rx.items) { (tableView, row, element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
            cell.textLabel?.text = "\(element)"
            return cell
        }
    .disposed(by: disposeBag)
        
        
        //使用kvo来监听视图偏移量变化
        _ = self.tableView.rx.observe(CGPoint.self, "contentOffset")
            .subscribe(onNext: { [weak self] (offset) in
                var delta = offset!.y / CGFloat(64) + 1
                delta = CGFloat.maximum(delta, 0)
                self?.barImageView?.alpha = CGFloat.minimum(delta, 1)
            })
        
    }

}






#if false
class SHRxswift_64ViewController: UIViewController {
    let disposeBag = DisposeBag()
        
    override func viewDidLoad() {
        super.viewDidLoad()

        //监听视图frame的变化
        _ = self.rx.observe(CGRect.self, "view.frame")
            .subscribe(onNext: { (frame) in
                print("--- 视图尺寸发生变化 ---")
                print(frame)
                print("\n")
            })
        
    }

}
#endif





#if false
class SHRxswift_64ViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    @objc dynamic var message = "univer2012"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //定时器（1秒执行一次）
        Observable<Int>.interval(1, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] (_) in
                self.message.append("!")
            })
        .disposed(by: disposeBag)
        
        
        //监听message变量的变化
        _ = self.rx.observeWeakly(String.self, "message")
            .subscribe(onNext: { (value) in
                print(value ?? "")
            })
        
    }

}
#endif
