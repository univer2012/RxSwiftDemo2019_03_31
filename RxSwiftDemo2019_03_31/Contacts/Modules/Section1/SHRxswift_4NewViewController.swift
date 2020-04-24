//
//  SHRxswift_4NewViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by Mac on 2020/4/17.
//  Copyright © 2020 远平. All rights reserved.
//
/*
 * 来自：[Swift - RxSwift的使用详解4（Observable订阅、事件监听、订阅销毁）](https://www.hangge.com/blog/cache/detail_1924.html)
 */
import UIKit
import RxSwift
import RxCocoa

class SHRxswift_4NewViewController: SHBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.actionType = .method
        //section 1
        let tempTitleArray = [
            "1.订阅 Observable - 第一种用法",
            "2.订阅 Observable - 第二种用法",
            "2.订阅 Observable - 第二种用法-简写",
            "3.doOn 介绍",
            "4.dispose() 方法",
            "5.DisposeBag",
        ]
        let tempClassNameArray = [
            "demo1",
            "demo2",
            "demo2_1",
            "demo3",
            "demo4",
            "demo5",
        ]
        self.p_addSectionData(with: tempClassNameArray, titleArray: tempTitleArray, title: "第1部分")
        
    }
    
    //MARK: 5.DisposeBag
    @objc func demo5() {
        let disposeBag = DisposeBag()
        
        //第1个Observable，及其订阅
        let observable1 = Observable.of("A", "B", "C")
        observable1.subscribe { (event) in
            print(event)
        }.disposed(by: disposeBag)
        
        //第2个Observable，及其订阅
        let observable2 = Observable.of(1,2,3)
        observable2.subscribe { (event) in
            print(event)
        }.disposed(by: disposeBag)
        
        
    }
    
    ///七、Observable 的销毁（Dispose）
    //MARK: 4.dispose() 方法
    @objc func demo4() {
        let observable = Observable.of("A", "B", "C")
        
        //使用subscription常量存储这个订阅方法
        let subscription = observable.subscribe { (event) in
            print(event)
        }
        
        //调用这个订阅的dispose()方法
        subscription.dispose()
        
    }
    
    ///六、监听事件的生命周期
    //MARK: 3.doOn 介绍
    @objc func demo3() {
        let observable = Observable.of("A", "B", "C")
        observable.do(onNext: { (elemet) in
            print("Intercepted Next:", elemet)
        }, onError: { (error) in
            print("Intercepted Error:", error)
        }, onCompleted: {
            print("Intercepted Completed")
        })
            .subscribe(onNext: { (element) in
                print(element)
            }, onError: { (error) in
                print(error)
            }, onCompleted: {
                print("completed")
            }) {
                print("disposed")
        }
    }
    
    //MARK:2.订阅 Observable - 第二种用法-简写
    @objc func demo2_1() {
        let observable = Observable.of("A", "B", "C")
        observable.subscribe(onNext: { (element) in
            print(element)
        })
    }
    //MARK:2.订阅 Observable - 第二种用法
    @objc func demo2() {
        let observable = Observable.of("A", "B", "C")
        observable.subscribe(onNext: { (element) in
            print(element)
        }, onError: { (error) in
            print(error)
        }, onCompleted: {
            print("completed")
        }) {
            print("disposed")
        }
    }
    
    //MARK:1.订阅 Observable - 第一种用法
    ///五、订阅 Observable
    @objc func demo1() {
        let observable = Observable.of("A", "B", "C")
        observable.subscribe { event in
            print(event)
        }
    }
    

}
