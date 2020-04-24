//
//  SHRxswift_14NewViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by Mac on 2020/4/19.
//  Copyright © 2020 远平. All rights reserved.
//
/*
* 来自：[Swift - RxSwift的使用详解14（其他操作符：delay、materialize、timeout等）](https://www.hangge.com/blog/cache/detail_1950.html)
*/
import UIKit
import RxSwift
import RxCocoa

class SHRxswift_14NewViewController: SHBaseTableViewController {
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.actionType = .method
        //section 1
        let tempTitleArray = [
            "1.delay \n会将 Observable 的所有元素都先拖延一段设定好的时间，然后才将它们发送出来",
            "2.delaySubscription \n经过所设定的时间后，才对 Observable 进行订阅操作。",
            "3.materialize \n将序列产生的事件，转换成元素。",
            "4.dematerialize \n可以将 materialize 转换后的元素还原。",
            "5.timeout \n设置一个超时时间",
            "6.using \n使用 using 操作符创建 Observable 时，同时会创建一个可被清除的资源，一旦 Observable 终止了，那么这个资源就会被清除掉了。",
        ]
        let tempClassNameArray = [
            "demo1",
            "demo2",
            "demo3",
            "demo4",
            "demo5",
            "demo6",
        ]
        self.p_addSectionData(with: tempClassNameArray, titleArray: tempTitleArray, title: "十四、其他一些实用的操作符（Observable Utility Operators）")
    }
    
    //MARK:6.using
    ///使用 using 操作符创建 Observable 时，同时会创建一个可被清除的资源，一旦 Observable 终止了，那么这个资源就会被清除掉了。
    @objc func demo6() {
        //一个无限序列（每隔0.1秒创建一个序列数 ）
        let infiniteInterval$ = Observable<Int>.interval(0.1, scheduler: MainScheduler.instance)
            .do(onNext: { print("infinite$: \($0)") },
                onSubscribe: { print("开始订阅 infinite$") },
                onDispose: { print("销毁 infinite$") }
        )
        
        //一个有限序列（每隔0.5秒创建一个序列数，共创建三个 ）
        let limit$ = Observable<Int>.interval(0.5, scheduler: MainScheduler.instance)
            .take(2)
            .do(onNext: { print("limit$: \($0)") },
                onSubscribe: { print("开始订阅 limit$") },
                onDispose: { print("销毁 limit$") }
        )
        
        //使用using操作符创建序列
        let o: Observable<Int> = Observable.using({ () -> AnyDisposable in
            return AnyDisposable(infiniteInterval$.subscribe())
        }, observableFactory: {_ in return limit$ }
        )
        o.subscribe()
    }
    
    //MARK:5.timeout
    ///使用该操作符可以设置一个超时时间。如果源 Observable 在规定时间内没有发出任何元素，就产生一个超时的 error 事件。
    @objc func demo5() {
        
        //定义好每个事件里的值以及发送的时间
        let times = [
            ["value": 1, "time": 0],
            ["value": 2, "time": 0.5],
            ["value": 3, "time": 0.5],
            ["value": 4, "time": 4],
            ["value": 5, "time": 5],
        ]
        
        //生成对应的 Observable 序列并订阅
        Observable.from(times).flatMap { item in
                return Observable.of(Int( item["value"]! ))
                    .delaySubscription(Double( item["time"]! ), scheduler: MainScheduler.instance)
            }
            .timeout(2, scheduler: MainScheduler.instance)  //超过两秒没发出元素，则产生error事件
            .subscribe(onNext: { (element) in
                print(element)
            }, onError: { (error) in
                print(error)
            }).disposed(by: disposeBag)
    }
    
    //MARK:4.dematerialize
    ///该操作符的作用和 materialize 正好相反，它可以将 materialize 转换后的元素还原。
    @objc func demo4() {
        Observable.of(1,2,1)
            .materialize()
            .dematerialize()
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    //MARK:3.materialize
    ///1. 该操作符可以将序列产生的事件，转换成元素。
    ///2. 通常一个有限的 Observable 将产生零个或者多个 onNext 事件，最后产生一个 onCompleted 或者 onError 事件。而 materialize 操作符会将 Observable 产生的这些事件全部转换成元素，然后发送出来。
    @objc func demo3() {
        Observable.of(1,2,1)
            .materialize()
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    
    //MARK:2.delaySubscription
    ///使用该操作符可以进行延时订阅。即经过所设定的时间后，才对 Observable 进行订阅操作。
    @objc func demo2() {
        Observable.of(1,2,1)
            .delaySubscription(3, scheduler: MainScheduler.instance)//延迟3秒才开始订阅
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    //MARK:1.delay
    ///该操作符会将 Observable 的所有元素都先拖延一段设定好的时间，然后才将它们发送出来。
    @objc func demo1() {
        Observable.of(1,2,1)
            .delay(3, scheduler: MainScheduler.instance)//元素延迟3秒才发出
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
}

class AnyDisposable: Disposable {
    let _dispose: () -> Void
    
    init(_ disposable: Disposable) {
        _dispose = disposable.dispose
    }
    
    func dispose() {
         _dispose()
    }
}
