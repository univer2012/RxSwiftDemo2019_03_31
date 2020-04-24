//
//  SHRxswift_16NewViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by Mac on 2020/4/19.
//  Copyright © 2020 远平. All rights reserved.
//
/*
* 来自：[Swift - RxSwift的使用详解16（调试操作）](https://www.hangge.com/blog/cache/detail_1937.html)
*/
import UIKit
import RxSwift
import RxCocoa

class SHRxswift_16NewViewController: SHBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.actionType = .method
        //section 1
        let tempTitleArray = [
            "1.debug \n可以将 debug 调试操作符添加到一个链式步骤当中，这样系统就能将所有的订阅者、事件、和处理等详细信息打印出来，方便我们开发调试。",
            "1_2.debug() 方法还可以传入标记参数，这样当项目中存在多个 debug 时可以很方便地区分出来。",
            "2.RxSwift.Resources.total \n通过将 RxSwift.Resources.total 打印出来，我们可以查看当前 RxSwift 申请的所有资源数量。这个在检查内存泄露的时候非常有用。",
        ]
        let tempClassNameArray = [
            "demo1",
            "demo1_2",
            "demo2",
            "demo3",
            "demo4",
            "demo5",
            "demo6",
        ]
        self.p_addSectionData(with: tempClassNameArray, titleArray: tempTitleArray, title: "十六、调试操作 ")
    }
    
    //MARK:2.RxSwift.Resources.total
    ///通过将 RxSwift.Resources.total 打印出来，我们可以查看当前 RxSwift 申请的所有资源数量。这个在检查内存泄露的时候非常有用。
    ///
    ///为了使`RxSwift.Resources.total`生效，需要设置Podfile文件，具体请看：[RxSwift-内存管理](https://blog.csdn.net/yahibo/article/details/98957772)
    @objc func demo2() {
        print(RxSwift.Resources.total)
        
        let disposeBag = DisposeBag()
        
        print(RxSwift.Resources.total)
        
        Observable.of("BBB", "CCC")
            .startWith("AAA")
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        print(RxSwift.Resources.total)
    }
    
    //MARK:1_2.debug() 方法还可以传入标记参数，这样当项目中存在多个 debug 时可以很方便地区分出来。
    ///（3）debug() 方法还可以传入标记参数，这样当项目中存在多个 debug 时可以很方便地区分出来。
    @objc func demo1_2() {
        let disposeBag = DisposeBag()
        
        Observable.of("2", "3")
            .startWith("1")
            .debug("调试1")
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    //MARK: 十六、调试操作
    //MARK:1.debug
    ///我们可以将 debug 调试操作符添加到一个链式步骤当中，这样系统就能将所有的订阅者、事件、和处理等详细信息打印出来，方便我们开发调试。
    @objc func demo1() {
        let disposeBag = DisposeBag()
        
        Observable.of("2", "3")
            .startWith("1")
            .debug()
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }

}
