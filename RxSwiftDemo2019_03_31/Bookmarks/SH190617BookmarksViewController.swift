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

class SH190617BookmarksViewController: SHBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Bookmarks"
        
        //MARK: section 1
        let tempTitleArray = [
            "1、加速传感器（CoreMotion）的用法（要用真机）",
            "2、解析JSON数据",
            "3、CALayer Demos",
            "4、Swift的基础使用",
        ]
        let tempClassNameArray = [
            "SHCoreMotionDemoViewController",
            "SHJSONSerializationViewController",
            "SHLayerListDemoViewController",
            "SHSwiftUsingViewController",
        ]
                
        self.p_addSectionData(with: tempClassNameArray, titleArray: tempTitleArray, title: "Bookmarks")
        
        //MARK: section 2
        let tempTitleArray2 = [
            "1、调用测试",
        ]
        let tempClassNameArray2 = [
            "SHNativeJSActionViewController",
        ]
                
        self.p_addSectionData(with: tempClassNameArray2, titleArray: tempTitleArray2, title: "原生与H5的交互")
        
    }
}

