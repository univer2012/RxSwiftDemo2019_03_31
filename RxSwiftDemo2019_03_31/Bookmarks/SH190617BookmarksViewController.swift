//
//  SH190617BookmarksViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by rrd on 2019/6/17.
//  Copyright © 2019 远平. All rights reserved.
//

import UIKit
import RxSwift

import SnapKit



class SH190617BookmarksViewController: UIViewController,UIGestureRecognizerDelegate {
    
    var tableView : UITableView?
    
    var dataArray = [[SGHCellModel]]()
    var sectionTitle = [String]()
    
    var inStoryboardVCArray: [String]?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Bookmarks"
        //设置滑动返回
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        //初始化tableView的数据
        self.tableView = UITableView(frame: CGRect.zero, style: .plain)
        //设置tableView的数据源
        self.tableView!.dataSource = self
        //设置tableView的委托
        self.tableView!.delegate = self
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "bookmarksCell")
        self.view.addSubview(self.tableView!)
        self.tableView!.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        //section 1
        let tempTitleArray = [
            "1、加速传感器（CoreMotion）的用法（要用真机）",
            "2、解析JSON数据",
            "3、CALayer Demos",
        ]
        let tempClassNameArray = [
        "SHCoreMotionDemoViewController",
        "SHJSONSerializationViewController",
        "SHLayerListDemoViewController",
        ]
        
        self.inStoryboardVCArray = []
        
        self.p_addSectionData(with: tempClassNameArray, titleArray: tempTitleArray, title: "Bookmarks")

    }
    
    private func p_addSectionData(with classNameArray:[String], titleArray:[String],title:String) {
        var firstArray = [SGHCellModel]()
        for (idx,item) in classNameArray.enumerated() {
            let cellModel = SGHCellModel()
            cellModel.className = item
            cellModel.title = titleArray[idx]
            firstArray.append(cellModel)
        }
        
        self.addSection(with: title, sectionArray: firstArray)
    }
    
    private func addSection(with title:String, sectionArray: [SGHCellModel]) {
        self.dataArray.append(sectionArray)
        self.sectionTitle.append(title)
    }
}

extension SH190617BookmarksViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sectionTitle[section]
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookmarksCell", for:indexPath)
        let cellModel = self.dataArray[indexPath.section][indexPath.row]
        cell.textLabel?.text = cellModel.title
        cell.textLabel?.font = UIFont.systemFont(ofSize: 13)
        return cell
    }
}
extension SH190617BookmarksViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cellModel = self.dataArray[indexPath.section][indexPath.row]
        let className = cellModel.className
        
        ///解决方案来自：[Swift 通过字符串 转换成对应的 UIViewController](https://www.jianshu.com/p/d5daa8485227)
        
        // 1.动态获取命名空间
        guard let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"]as? String else{
        return;
        }
        // 2.根据字符串获取对应的Class并转成控制器的类型
        if let cls = NSClassFromString(nameSpace + "." + className) as? UIViewController.Type {
            
            if inStoryboardVCArray?.contains(className) ?? false {
                
                let vc = UIStoryboard(name: "Bookmark", bundle: Bundle(for: cls)).instantiateViewController(withIdentifier: className)
                vc.title = cellModel.title
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
                
            } else {

                // 3.创建对应的控制器对象
                let vc: UIViewController = cls.init()
                vc.title = cellModel.title
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        }
    }
}
