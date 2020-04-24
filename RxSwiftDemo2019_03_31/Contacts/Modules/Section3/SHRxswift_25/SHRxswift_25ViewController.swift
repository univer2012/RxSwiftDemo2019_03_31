//
//  SHRxswift_25ViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by Mac on 2020/4/22.
//  Copyright © 2020 远平. All rights reserved.
//
/*
* 来自：[Swift - RxSwift的使用详解25（UI控件扩展5：UIActivityIndicatorView、UIApplication）](https://www.hangge.com/blog/cache/detail_1971.html)
*/
import UIKit
import RxSwift
import RxCocoa

class SHRxswift_25ViewController: SHBaseTableViewController {

    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.actionType = .method
        //section 1
        var tempTitleArray = [
            "1.通过开关我们可以控制活动指示器是否显示旋转。",
            "2.通过 UIApplication的isNetworkActivityIndicatorVisible可以设置是否显示联网指示器（网络请求指示器）",
        ]
        var tempClassNameArray = [
            "demo1",
            "demo2",
            
        ]
        self.p_addSectionData(with: tempClassNameArray, titleArray: tempTitleArray, title: "五、UIActivityIndicatorView 与 UIApplication ")
    }
    
    //MARK:2.通过 UIApplication的isNetworkActivityIndicatorVisible可以设置是否显示联网指示器（网络请求指示器）
    /*
    ### 2，UIApplication
    RxSwift 对 UIApplication 增加了一个名为 isNetworkActivityIndicatorVisible 绑定属性，我们通过它可以设置是否显示联网指示器（网络请求指示器）。
     
     （1）效果图
     * 当开关打开时，顶部状态栏上会有个菊花状的联网指示器。
     * 当开关关闭时，联网指示器消失。

    */
    @objc func demo2() {
        self.pushToNewVC(with: "SHRxswift_7ViewController", title: "", true,selText: "particle25demo2")
    }

    //MARK: 五、UIActivityIndicatorView 与 UIApplication
    /*
     ### 1，UIActivityIndicatorView（活动指示器）
     通过开关我们可以控制活动指示器是否显示旋转。
     */
    //MARK:1.通过开关我们可以控制活动指示器是否显示旋转。
    @objc func demo1() {
        self.pushToNewVC(with: "SHRxswift_7ViewController", title: "", true,selText: "particle25demo1")
    }

}
