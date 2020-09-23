//
//  SHLayerListDemoViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by Mac on 2020/3/15.
//  Copyright © 2020 远平. All rights reserved.
//

import UIKit

class SHLayerListDemoViewController: UIViewController,UIGestureRecognizerDelegate {
    var tableView : UITableView!
    let titlesArray: [[String: String]] = [
        ["d1": "1、CALayer"],
        ["d2": "2、CAScrollLayer"],
        ["d3": "3、CATextLayer"],
        ["d4": "4、AVPlayerLayer"],
        ["d5": "5、CAGradientLayer"],
        ["d6": "6、CAReplicatorLayer"],
        ["d7": "7、CATiledLayer"],
        ["d8": "8、CAShapeLayer"],
        ["d9": "9、CATransformLayer"],
        ["d10": "10、CAEmitterLayer"],
    ]
    private func getController(with key:String) -> UIViewController {
        switch key {
        case "d1":
            return SHLayerD1ViewController()
        case "d2":
            return UIViewController()
        case "d3":
            return UIViewController()
        case "d4":
            return UIViewController()
        case "d5":
            return UIViewController()
        case "d6":
            return UIViewController()
        case "d7":
            return UIViewController()
        case "d8":
            return UIViewController()
        case "d9":
            return UIViewController()
        case "d10":
            return UIViewController()
        default:
            break
        }
        return UIViewController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "返回", style: .plain, target: self, action: nil)
            self.title = "CALayer Demos"
            //设置滑动返回
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
            
            
            //初始化tableView的数据
            self.tableView = UITableView(frame: self.view.frame, style: .plain)
            //设置tableView的数据源
            self.tableView.dataSource = self
            //设置tableView的委托
            self.tableView.delegate = self
            self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
            self.view.addSubview(self.tableView)
    }
    
}

extension SHLayerListDemoViewController: UITableViewDelegate, UITableViewDataSource {
    //UITableViewDataSource
    
    //总行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titlesArray.count
    }
    
    //加载数据
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        let row = indexPath.row as Int
        cell.textLabel?.text = self.titlesArray[row].values.first
        return cell
    }
    
    
    ///UITableViewDelegate
    //选择一行
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let key = self.titlesArray[indexPath.row].keys.first {
            
            let viewController = getController(with: key)
            viewController.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
