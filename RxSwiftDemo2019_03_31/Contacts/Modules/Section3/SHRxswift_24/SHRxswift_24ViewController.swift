//
//  SHRxswift_24ViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by Mac on 2020/4/22.
//  Copyright © 2020 远平. All rights reserved.
//
/*
* 来自：[Swift - RxSwift的使用详解24（UI控件扩展4：UISwitch、UISegmentedControl）](https://www.hangge.com/blog/cache/detail_1970.html)
*/
import UIKit
import RxSwift
import RxCocoa

class SHRxswift_24ViewController: SHBaseTableViewController {

    let disposeBag = DisposeBag()
    
    lazy var button: UIButton = {
        let btn = UIButton()
        btn.setTitle("按钮", for: .normal)
        btn.setTitleColor(.systemBlue, for: .normal)
        return btn
    }()
    
    lazy var switch1: UISwitch = {
        let sw = UISwitch()
        return sw
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(switch1)
        switch1.snp_makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(100)
        }
        self.remakeTableViewConstraints(with: switch1)

        self.actionType = .method
        //section 1
        var tempTitleArray = [
            "1.假设我们想实现当 switch 开关状态改变时，输出当前值。",
            "1_2.当我们切换 switch 开关时，button 会在可用和不可用的状态间切换。",
            "2_1.当 UISegmentedControl 选中项改变时，输出当前选中项索引值。",
            "2_2:当 segmentedControl 选项改变时，imageView 会自动显示相应的图片。",
        ]
        var tempClassNameArray = [
            "demo1",
            "demo1_2",
            "demo2_1",
            "demo2_2",
        ]
        self.p_addSectionData(with: tempClassNameArray, titleArray: tempTitleArray, title: "四、UISwitch 与 UISegmentedControl ")
    }
    
    //MARK:2_2:当 segmentedControl 选项改变时，imageView 会自动显示相应的图片。
    ///（2）下面样例当 segmentedControl 选项改变时，imageView 会自动显示相应的图片。
    @objc func demo2_2() {
        self.pushToNewVC(with: "SHRxswift_7ViewController", title: "", true,selText: "particle24demo2_2")
    }
    
    //MARK: 2，UISegmentedControl（分段选择控件）
    //MARK: 2_1.当 UISegmentedControl 选中项改变时，输出当前选中项索引值。
    ///1）我们想实现当 UISegmentedControl 选中项改变时，输出当前选中项索引值。
    @objc func demo2_1() {
        self.pushToNewVC(with: "SHRxswift_7ViewController", title: "", true,selText: "particle24demo2_1")
    }
    
    //MARK: 1_2.当我们切换 switch 开关时，button 会在可用和不可用的状态间切换。
    ///（2）下面样例当我们切换 switch 开关时，button 会在可用和不可用的状态间切换。
    @objc func demo1_2() {
        view.addSubview(button)
        button.snp_makeConstraints { (make) in
            make.left.equalTo(switch1.snp_right).offset(20)
            make.centerY.equalTo(switch1)
            make.width.equalTo(100)
            make.height.equalTo(46)
        }
        button.setTitleColor(.gray, for: .disabled)
        
        switch1.rx.isOn
            .bind(to: button.rx.isEnabled)
            .disposed(by: disposeBag)
    }
    //MARK:四、UISwitch 与 UISegmentedControl
    /*
     ### 1，UISwitch（开关按钮）
     （1）假设我们想实现当 switch 开关状态改变时，输出当前值。
     */
    //MARK: 1.假设我们想实现当 switch 开关状态改变时，输出当前值。
    @objc func demo1() {
        switch1.rx.isOn.asObservable()
            .subscribe(onNext: {
                print("当前开关状态： \($0)")
            }).disposed(by: disposeBag)
    }

}

