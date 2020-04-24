//
//  SHRxswift_12NewViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by Mac on 2020/4/19.
//  Copyright © 2020 远平. All rights reserved.
//
/*
* 来自：[Swift - RxSwift的使用详解12（算数&聚合操作符：toArray、reduce、concat）](https://www.hangge.com/blog/cache/detail_1934.html)
*/
import UIKit
import RxSwift
import RxCocoa

class SHRxswift_12NewViewController: SHBaseTableViewController {
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.actionType = .method
        //section 1
        let tempTitleArray = [
            "1.toArray \n该操作符先把一个序列转成一个数组，并作为一个单一的事件发送，然后结束",
            "2.reduce \n将给定的初始值，与序列里的每个值进行累计运算。得到一个最终结果，并将其作为单个值发送出去。",
            "3.concat \n把多个 Observable 序列合并（串联）为一个 Observable 序列，并且只有当前面一个 Observable 序列发出了 completed 事件，才会开始发送下一个 Observable 序列事件",
        ]
        let tempClassNameArray = [
            "demo1",
            "demo2",
            "demo3",
            "demo3_1",
            "demo4",
            "demo5",
            "demo6",
        ]
        self.p_addSectionData(with: tempClassNameArray, titleArray: tempTitleArray, title: "十二、算数、以及聚合操作（Mathematical and Aggregate Operators）")
    }
    
    //MARK:3.concat
    ///1. concat 会把多个 Observable 序列合并（串联）为一个 Observable 序列。
    ///2. 并且只有当前面一个 Observable 序列发出了 completed 事件，才会开始发送下一个 Observable 序列事件。
    ///
    ///concat      n. 合并多个数组；合并多个字符串
    @objc func demo3() {
        let subject1 = BehaviorSubject(value: 1)
        let subject2 = BehaviorSubject(value: 2)
        
        let variable = Variable(subject1)
        variable.asObservable()
            .concat()
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        subject2.onNext(2)
        subject1.onNext(1)
        subject1.onNext(1)
        subject1.onCompleted()
        
        variable.value = subject2
        subject2.onNext(2)
    }
    
    //MARK:2.reduce
    ///1. reduce 接受一个初始值，和一个操作符号。
    ///2. reduce 将给定的初始值，与序列里的每个值进行累计运算。得到一个最终结果，并将其作为单个值发送出去。
    ///
    ///reduce  [rɪˈdjuːs] vi. 减少；缩小；归纳为
    @objc func demo2() {
        Observable.of(1,2,3,4,5)
            .reduce(0, accumulator: +)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    //MARK: 十二、算数、以及聚合操作（Mathematical and Aggregate Operators）
    //MARK:1，toArray
    ///该操作符先把一个序列转成一个数组，并作为一个单一的事件发送，然后结束。
    @objc func demo1() {
        Observable.of(1,2,3)
            .toArray()
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
}
