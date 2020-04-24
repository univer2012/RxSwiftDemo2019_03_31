//
//  SHRxswift_56ViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by Mac on 2019/11/8.
//  Copyright © 2019 远平. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SHRxswift_56ViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    //表格
    var tableView: UITableView!
        
    override func viewDidLoad() {
        super.viewDidLoad()

        //创建表格视图
        self.tableView = UITableView(frame: self.view.frame, style: .plain)
        //创建一个重用的单元格
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(self.tableView)
        
        //设置头部刷新控件
        self.tableView.mj_header = MJRefreshNormalHeader()
        
        //初始化Rxswift56ViewModel
        let viewModel = Rxswift56ViewModel(headerRefresh: self.tableView.mj_header.rx.refreshing.asDriver())
        
        //单元格数据的绑定
        viewModel.tableData.asDriver()
            .drive(tableView.rx.items) {tableView, row, element in
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
                cell.textLabel?.text = "\(row+1)、\(element)"
                return cell
        }.disposed(by: disposeBag)
        
        //下拉刷新状态结束的绑定
        viewModel.endHeaderRefreshing
            .drive(self.tableView.mj_header.rx.endRefreshing)
            .disposed(by: disposeBag)
    }
    
}
