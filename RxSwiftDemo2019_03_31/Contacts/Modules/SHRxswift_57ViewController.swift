//
//  SHRxswift_57ViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by 远平 on 2019/11/10.
//  Copyright © 2019 远平. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

//MARK:上下拉刷新的改进 - 用到是Observable
class SHRxswift_57ViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    //表格
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //创建表格视图
        self.tableView = UITableView(frame: self.view.frame, style: .plain)
        //创建一个重用的单元格
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(self.tableView!)
        
        //设置头部刷新控件
        self.tableView.mj_header = MJRefreshNormalHeader()
        //设置尾部刷新控件
        self.tableView.mj_footer = MJRefreshBackNormalFooter()
        
        //初始化 Rxswift57ViewModel
        let viewModel = Rxswift57ViewModel(
            input: (
                headerRefresh: self.tableView.mj_header.rx.refreshing.asObservable(),
                footerRefresh: self.tableView.mj_footer.rx.refreshing.asObservable()
            ),
            dependency: (disposeBag: self.disposeBag,
                         networkService: Network57Service()))
        
        //单元格数据的绑定
        viewModel.tableData.bind(to: tableView.rx.items) { (tableView, row, element) in
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
                cell.textLabel?.text = "\(row + 1)、\(element)"
                return cell
            }.disposed(by: disposeBag)
        
        //下拉刷新状态结束的绑定
        viewModel.endHeaderRefreshing
            .bind(to: self.tableView.mj_header.rx.endRefreshing)
            .disposed(by: disposeBag)
        
        //上拉刷新状态结束的绑定
        viewModel.endFooterRefreshing
            .bind(to: self.tableView.mj_footer.rx.endRefreshing)
            .disposed(by: disposeBag)
    }
    
}







#if false
//MARK:有上下拉刷新 - 用到是Driver
class SHRxswift_57ViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    //表格
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //创建表格视图
        self.tableView = UITableView(frame: self.view.frame, style: .plain)
        //创建一个重用的单元格
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(self.tableView!)
        
        //设置头部刷新控件
        self.tableView.mj_header = MJRefreshNormalHeader()
        //设置尾部刷新控件
        self.tableView.mj_footer = MJRefreshBackNormalFooter()
        
        //初始化 Rxswift57ViewModel
        let viewModel = Rxswift57ViewModel(
            input: (
                headerRefresh: self.tableView.mj_header.rx.refreshing.asDriver(),
                footerRefresh: self.tableView.mj_footer.rx.refreshing.asDriver()
            ),
            dependency: (disposeBag: self.disposeBag,
                         networkService: Network56Service()))
        
        //单元格数据的绑定
        viewModel.tableData.asDriver()
            .drive(tableView.rx.items) { (tableView, row, element) in
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
                cell.textLabel?.text = "\(row + 1)、\(element)"
                return cell
            }.disposed(by: disposeBag)
        
        //下拉刷新状态结束的绑定
        viewModel.endHeaderRefreshing
            .drive(self.tableView.mj_header.rx.endRefreshing)
            .disposed(by: disposeBag)
        
        //上拉刷新状态结束的绑定
        viewModel.endFooterRefreshing
            .drive(self.tableView.mj_footer.rx.endRefreshing)
            .disposed(by: disposeBag)
    }
    
}
#endif










#if false
//MARK: 只有上拉  - 用到是Driver
class SHRxswift_57ViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    //表格
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //创建表格视图
        self.tableView = UITableView(frame: self.view.frame, style: .plain)
        //创建一个重用的单元格
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(self.tableView!)
        
        //设置尾部刷新控件
        self.tableView.mj_footer = MJRefreshBackNormalFooter()
        
        //初始化 Rxswift57ViewModel
        let viewModel = Rxswift57ViewModel(
            footerRefresh: self.tableView.mj_footer.rx.refreshing.asDriver(),
            dependency: (disposeBag: self.disposeBag,
                         networkService: Network56Service()))
        
        //单元格数据的绑定
        viewModel.tableData.asDriver()
            .drive(tableView.rx.items) { (tableView, row, element) in
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
                cell.textLabel?.text = "\(row + 1)、\(element)"
                return cell
        }.disposed(by: disposeBag)
        
        //上拉刷新状态结束的绑定
        viewModel.endFooterRefreshing
        .drive(self.tableView.mj_footer.rx.endRefreshing)
        .disposed(by: disposeBag)
    }

}
#endif
