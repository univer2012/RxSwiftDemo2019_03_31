//
//  SHRxswift_9NewViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by Mac on 2020/4/18.
//  Copyright © 2020 远平. All rights reserved.
//
/*
* 来自：[Swift - RxSwift的使用详解9（过滤操作符：filter、take、skip等）](https://www.hangge.com/blog/cache/detail_1933.html)
*/
import UIKit
import RxSwift
import RxCocoa

class SHRxswift_9NewViewController: SHBaseTableViewController {
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.actionType = .method
        //section 1
        let tempTitleArray = [
            "1.filter - 用来过滤掉某些不符合要求的事件",
            "2.distinctUntilChanged - 用于过滤掉连续重复的事件",
            "3.single - 限制只发送一次事件，或者满足条件的第一个事件",
            "4.elementAt - 只处理在指定位置的事件",
            "5.ignoreElements - 忽略掉所有的元素，只发出 error 或 completed 事件。",
            "6.take - 仅发送 Observable 序列中的前 n 个事件，在满足数量之后会自动 .completed",
            "7.takeLast - 仅发送 Observable 序列中的后 n 个事件",
            "8.skip - 跳过源 Observable 序列发出的前 n 个事件",
            "9.Sample - 每当收到 notifier 事件，就会从源序列取一个最新的事件并发送。而如果两次 notifier 事件之间没有源序列的事件，则不发送值\n\n sample取「抽样」的意思。",
            "10.debounce - 常用在用户输入的时候，不需要每个字母敲进去都发送一个事件，而是稍等一下取最后一个事件。",
        ]
        let tempClassNameArray = [
            "demo1",
            "demo2",
            "demo3",
            "demo4",
            "demo5",
            "demo6",
            "demo7",
            "demo8",
            "demo9",
            "demo10",
        ]
        self.p_addSectionData(with: tempClassNameArray, titleArray: tempTitleArray, title: "九、过滤操作符（Filtering Observables） ")
    }
    
    //MARK:10.debounce
    ///debounce 操作符可以用来过滤掉高频产生的元素，它只会发出这种元素：该元素产生后，一段时间内没有新元素产生。
    ///换句话说就是，队列中的元素如果和下一个元素的间隔小于了指定的时间间隔，那么这个元素将被过滤掉。
    ///debounce 常用在用户输入的时候，不需要每个字母敲进去都发送一个事件，而是稍等一下取最后一个事件。
    
    @objc func demo10() {
        //定义好每个事件里的值以及发送的时间
        let times = [
            ["value": 1, "time": 0.1 ],
            ["value": 2, "time": 1.1 ],
            ["value": 3, "time": 1.2 ],
            ["value": 4, "time": 1.2 ],
            ["value": 5, "time": 1.4 ],
            ["value": 6, "time": 2.1 ],
        ]
        
        //生成对应的 Observable 序列并订阅
        Observable.from(times)
            .flatMap { item in
                return Observable.of(Int( item["value"]! ))
                    .delaySubscription(Double( item["time"]! ), scheduler: MainScheduler.instance)
            }
        .debounce(0.5, scheduler: MainScheduler.instance)   //只发出与下一个间隔超过0.5秒的元素
        .subscribe(onNext: {
            print($0)
        }, onCompleted: {
            print("completed")
        })
        //.subscribe(onNext: { print($0) })
        .disposed(by: disposeBag)
    }
    
    //MARK:9.Sample
    /// 1. Sample 除了订阅源 Observable 外，还可以监视另外一个 Observable， 即 notifier 。
    /// 2. 每当收到 notifier 事件，就会从源序列取一个最新的事件并发送。而如果两次 notifier 事件之间没有源序列的事件，则不发送值。
    ///
    ///sample 抽样，检验
    @objc func demo9() {
        let source = PublishSubject<Int>()
        let notifier = PublishSubject<String>()
         
        source
            .sample(notifier)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
         
        source.onNext(1)
         
        //让源序列接收接收消息
        notifier.onNext("A")
         
        source.onNext(2)
         
        //让源序列接收接收消息
        notifier.onNext("B")
        notifier.onNext("C")
         
        source.onNext(3)
        source.onNext(4)
         
        //让源序列接收接收消息
        notifier.onNext("D")
         
        source.onNext(5)
         
        //让源序列接收接收消息
        notifier.onCompleted()
    }
    
    //MARK:8.skip
    ///该方法用于跳过源 Observable 序列发出的前 n 个事件。
    @objc func demo8() {
        Observable.of(1,2,3,4)
        .skip(2)
        .subscribe(onNext: {
            print($0)
        }, onCompleted: {
            print("completed")
        })
        .disposed(by: disposeBag)
    }
    
    //MARK:7.takeLast
    ///该方法实现仅发送 Observable 序列中的后 n 个事件。
    @objc func demo7() {
        Observable.of(1,2,3,4)
        .takeLast(2)
        .subscribe(onNext: {
            print($0)
        }, onCompleted: {
            print("completed")
        })
        .disposed(by: disposeBag)
    }
    
    //MARK:6.take
    ///该方法实现仅发送 Observable 序列中的前 n 个事件，在满足数量之后会自动 .completed。
    @objc func demo6() {
        Observable.of(1,2,3,4)
            .take(2)
            .subscribe(onNext: {
                print($0)
            }, onCompleted: {
                print("completed")
            })
            .disposed(by: disposeBag)
    }
    
    //MARK:5.ignoreElements
    ///该操作符可以忽略掉所有的元素，只发出 error 或 completed 事件。
    @objc func demo5() {
        Observable.of(1,2,3,4)
            .ignoreElements()
            .subscribe{ print($0) }
            .disposed(by: disposeBag)
    }
    
    //MARK:4.elementAt
    ///该方法实现只处理在指定位置的事件。
    @objc func demo4() {
        Observable.of(1,2,3,4)
            .elementAt(2)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    //MARK:3.single
    ///1. 限制只发送一次事件，或者满足条件的第一个事件。
    ///2. 如果存在有多个事件或者没有事件都会发出一个 error 事件。
    ///3. 如果只有一个事件，则不会发出 error 事件。
    @objc func demo3() {
        Observable.of(1, 2, 3, 4)
            .single{ $0 == 2 }
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        Observable.of("A", "B", "C", "D")
            .single()
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    //MARK:2.distinctUntilChanged
    ///该操作符用于过滤掉连续重复的事件。
    @objc func demo2() {
        Observable.of(1, 2, 3, 1, 1, 4)
            .distinctUntilChanged()
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    //MARK:九、过滤操作符（Filtering Observables）
    //MARK:1.filter
    ///该操作符就是用来过滤掉某些不符合要求的事件。
    @objc func demo1() {
        Observable.of(2, 30, 22, 5, 60, 3, 40, 9)
            .filter({ (number) -> Bool in
                return number > 10
            })
            //.filter { $0 > 10 }
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
}
