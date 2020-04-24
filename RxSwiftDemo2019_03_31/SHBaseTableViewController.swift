//
//  SHBaseViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by Mac on 2020/4/16.
//  Copyright © 2020 远平. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class SGHCellModel: NSObject {
    var title: String = ""
    var className: String = ""
    
    init(title: String, className: String) {
        self.title = title
        self.className = className
    }
    
    override convenience init() {
        self.init(title:"", className: "")
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

enum SHBaseTableActionType {
    case method //执行方法
    case newVC  //跳到新的控制器
}

class SHBaseTableViewController: UIViewController, UIGestureRecognizerDelegate {
    
    public var actionType: SHBaseTableActionType = .newVC
    
    var tableView : UITableView?
    var dataArray = [[SGHCellModel]]()
    var sectionTitle = [String]()
    
    var inStoryboardVCArray: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置滑动返回
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        self.tableView = {
            //初始化tableView的数据
            let tableV = UITableView(frame: CGRect.zero, style: .plain)
            //设置tableView的数据源
            tableV.dataSource = self
            //设置tableView的委托
            tableV.delegate = self
            tableV.register(UITableViewCell.self, forCellReuseIdentifier: "bookmarksCell")
            tableV.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "secHeaderIdentifier")
            self.view.addSubview(tableV)
            return tableV
        }()
        self.tableView!.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
    }
    
    func remakeTableViewConstraints(with view: UIView) {
        self.tableView?.snp_remakeConstraints({ (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(view.snp_bottom).offset(10)
        })
    }
    
    public func p_addSectionData(with classNameArray:[String], titleArray:[String],title:String) {
        var firstArray = [SGHCellModel]()
        for (idx,item) in titleArray.enumerated() {
            let cellModel = SGHCellModel()
            cellModel.className = classNameArray[idx]
            cellModel.title = item
            firstArray.append(cellModel)
        }
        
        self.addSection(with: title, sectionArray: firstArray)
    }
    
    private func addSection(with title:String, sectionArray: [SGHCellModel]) {
        self.dataArray.append(sectionArray)
        self.sectionTitle.append(title)
    }
    
    /// 跳转到 新的VC，
    public func pushToNewVC(with className: String,title:String,_ inBookmarkStoryboard:Bool,selText:String = "") {
        
        ///解决方案来自：[Swift 通过字符串 转换成对应的 UIViewController](https://www.jianshu.com/p/d5daa8485227)
        
        // 1.动态获取命名空间
        guard let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"]as? String else {
        return;
        }
        // 2.根据字符串获取对应的Class并转成控制器的类型
        if let cls = NSClassFromString(nameSpace + "." + className) as? UIViewController.Type {
            
            if inBookmarkStoryboard {
                
                let vc = UIStoryboard(name: "Bookmark", bundle: Bundle(for: cls)).instantiateViewController(withIdentifier: className)
                vc.title = title
                vc.hidesBottomBarWhenPushed = true
                _ = vc.rx.viewDidLoad.asObservable().takeUntil(self.rx.deallocated).subscribe(onNext: {[weak vc] in
                    if selText.count > 0 {
                        vc?.executeSelector(with: selText)
                    }
                })
                
                self.navigationController?.pushViewController(vc, animated: true)
                
            } else {

                // 3.创建对应的控制器对象
                let vc: UIViewController = cls.init()
                vc.title = title
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
}

extension SHBaseTableViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let tView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "secHeaderIdentifier")
        
        tView?.textLabel?.numberOfLines = 0
        tView?.textLabel?.font = UIFont.systemFont(ofSize: 10)
        tView?.textLabel?.text = self.sectionTitle[section]
        return tView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookmarksCell", for:indexPath)
        let cellModel = self.dataArray[indexPath.section][indexPath.row]
        cell.textLabel?.text = cellModel.title
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.font = UIFont.systemFont(ofSize: 13)
        return cell
    }
}

extension SHBaseTableViewController: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cellModel = self.dataArray[indexPath.section][indexPath.row]
        let className = cellModel.className
        
        if self.actionType == .newVC {
            
            let inStoryboard = inStoryboardVCArray?.contains(className) ?? false
            
            self.pushToNewVC(with: className, title: cellModel.title, inStoryboard)
            
        } else {
            
            self.executeSelector(with: className)
        }
        
        
    }
}


extension UIViewController {
    //执行方法
    public func executeSelector(with selText: String) {
        let sel = NSSelectorFromString(selText)
        self.perform(sel)
    }
}
