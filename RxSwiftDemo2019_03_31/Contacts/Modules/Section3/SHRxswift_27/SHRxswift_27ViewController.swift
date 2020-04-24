//
//  SHRxswift_27ViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by Mac on 2020/4/22.
//  Copyright © 2020 远平. All rights reserved.
//
/*
* 来自：[Swift - RxSwift的使用详解27（双向绑定：<->）](https://www.hangge.com/blog/cache/detail_1974.html)
*/
import UIKit
import RxSwift
import RxCocoa

class SHRxswift_27ViewController: SHBaseTableViewController {

    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.actionType = .method
        //section 1
        var tempTitleArray = [
            "1.简单的双向绑定",
            
        ]
        var tempClassNameArray = [
            "demo1",
            "demo2",
            "demo2_2",
        ]
        self.p_addSectionData(with: tempClassNameArray, titleArray: tempTitleArray, title: "一、简单的双向绑定")
    }
    

    //MARK: 一、简单的双向绑定
    //MARK:1.简单的双向绑定
    /*
     ### 1，效果图
     （1）页面上方是一个文本输入框，用于填写用户名。它与 VM 里的 username 属性做双向绑定。
     （2）下方的文本标签会根据用户名显示对应的用户信息。（只有 hangge 显示管理员，其它都是访客）
     */
    @objc func demo1() {
        self.pushToNewVC(with: "SHRxswift_8ViewController", title: "", true)
    }

}
