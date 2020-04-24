//
//  SHRxswift_6NewViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by Mac on 2020/4/17.
//  Copyright © 2020 远平. All rights reserved.
//
/*
* 来自：[Swift - RxSwift的使用详解6（观察者2： 自定义可绑定属性）](https://www.hangge.com/blog/cache/detail_1946.html)
*/
import UIKit

import RxSwift
import RxCocoa

class SHRxswift_6NewViewController: SHBaseTableViewController {
    
    lazy var label: UILabel = {
        let lab = UILabel()
        lab.textColor = .black
        lab.text = "欢迎访问hangge.com"
        self.view.addSubview(lab)
        return lab
    }()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.actionType = .method
        //section 1
        var tempTitleArray = [
            "方式一：通过对 UI 类进行扩展",
            "方式二：通过对 Reactive 类进行扩展",
        ]
        var tempClassNameArray = [
            "demo1",
            "demo2",
        ]
        self.p_addSectionData(with: tempClassNameArray, titleArray: tempTitleArray, title: "五、自定义可绑定属性")
        
        tempTitleArray = [
            "计数demo",
        ]
        tempClassNameArray = [
            "demo3",
        ]
        self.p_addSectionData(with: tempClassNameArray, titleArray: tempTitleArray, title: "六、RxSwift 自带的可绑定属性（UI 观察者）")
    }
    //MARK: 六、RxSwift 自带的可绑定属性（UI 观察者）
    //计数demo
    @objc func demo3() {
        self.label.snp_makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-80)
        }
        
        //Observable序列（每隔1秒钟发出一个索引数）
        let observable = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        observable
            .map{ "当前索引数：\($0)" }
            .bind(to: label.rx.text)   //收到发出的索引数后显示到label上
            .disposed(by: disposeBag)
        
    }
    
    //MARK: 方式二：通过对 Reactive 类进行扩展
    @objc func demo2() {
        self.label.snp_makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-80)
        }
        
        //Observable序列（每隔0.5秒钟发出一个索引数）
        let observable = Observable<Int>.interval(0.5, scheduler: MainScheduler.instance)
        observable
            .map{ CGFloat($0) }
            .bind(to: label.rx.fontSize)   //根据索引数不断变放大字体
            .disposed(by: disposeBag)
    }
    //MARK: 五、自定义可绑定属性
    //MARK: 方式一：通过对 UI 类进行扩展
    @objc func demo1() {
        
        self.label.snp_makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-80)
        }
        
        //Observable序列（每隔0.5秒钟发出一个索引数）
        let observable = Observable<Int>.interval(0.5, scheduler: MainScheduler.instance)
        observable
            .map{ CGFloat($0) }
            .bind(to: label.fontSize)   //根据索引数不断变放大字体
            .disposed(by: disposeBag)
    }

}
//方式二：通过对 Reactive 类进行扩展
extension Reactive where Base: UILabel {
    public var fontSize: Binder<CGFloat> {
        return Binder(self.base) { label, fontSize in
            label.font = UIFont.systemFont(ofSize: fontSize)
        }
    }
}


//方式一：通过对 UI 类进行扩展
extension UILabel {
    public var fontSize: Binder<CGFloat> {
        return Binder(self) { (label, fontSize) in
            label.font = UIFont.systemFont(ofSize: fontSize)
        }
    }
}
