//
//  SHRxswift_26ViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by Mac on 2020/4/22.
//  Copyright © 2020 远平. All rights reserved.
//
/*
* 来自：[Swift - RxSwift的使用详解26（UI控件扩展6：UISlider、UIStepper）](https://www.hangge.com/blog/cache/detail_1972.html)
*/
import UIKit
import RxSwift
import RxCocoa

class SHRxswift_26ViewController: SHBaseTableViewController {

    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.actionType = .method
        //section 1
        var tempTitleArray = [
            "1.当我们拖动滑块时，在控制台中实时输出 slider 当前值。",
            "2.UIStepper（步进器）- 当 stepper 值改变时，在控制台中实时输出当前值。",
            "2_2.我们使用滑块（slider）来控制 stepper 的步长。",
        ]
        var tempClassNameArray = [
            "demo1",
            "demo2",
            "demo2_2",
        ]
        self.p_addSectionData(with: tempClassNameArray, titleArray: tempTitleArray, title: "六、UISlider、UIStepper")
    }
    
    
    //MARK:2_2.我们使用滑块（slider）来控制 stepper 的步长。
    ///（2）下面样例我们使用滑块（slider）来控制 stepper 的步长。
    @objc func demo2_2() {
        self.pushToNewVC(with: "SHRxswift_7ViewController", title: "", true,selText: "particle26demo2_2")
    }
    
    /*
     ### 2，UIStepper（步进器）
     （1）下面样例当 stepper 值改变时，在控制台中实时输出当前值。
     */
    //MARK:2.UIStepper（步进器）- 当 stepper 值改变时，在控制台中实时输出当前值。
    @objc func demo2() {
        self.pushToNewVC(with: "SHRxswift_7ViewController", title: "", true,selText: "particle26demo2")
    }
    
    //MARK:六、UISlider、UIStepper
    /*
     ### 1，UISlider（滑块）
     （1）效果图
     当我们拖动滑块时，在控制台中实时输出 slider 当前值。
     */
    //MARK:1.当我们拖动滑块时，在控制台中实时输出 slider 当前值。
    @objc func demo1() {
        self.pushToNewVC(with: "SHRxswift_7ViewController", title: "", true,selText: "particle26demo1")
    }

}
