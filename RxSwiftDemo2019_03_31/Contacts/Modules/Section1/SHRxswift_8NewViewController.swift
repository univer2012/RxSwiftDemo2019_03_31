//
//  SHRxswift_8NewViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by Mac on 2020/4/18.
//  Copyright © 2020 远平. All rights reserved.
//
/*
* 来自：[Swift - RxSwift的使用详解8（变换操作符：buffer、map、flatMap、scan等）](https://www.hangge.com/blog/cache/detail_1932.html)
*/
import UIKit
import RxSwift
import RxCocoa

class SHRxswift_8NewViewController: SHBaseTableViewController {
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.actionType = .method
        //section 1
        let tempTitleArray = [
            "1.buffer",
            "2.window",
            "3.map",
            "4.flatMap",
            "5.flatMapLatest",
            "6.flatMapFirst",
            "7.concatMap - 当前一个 Observable 元素发送完毕后，后一个Observable 才可以开始发出元素.\n\n类似于串联线程",
            "8.scan - 就是先给一个初始化的数，然后不断的拿前一个结果和最新的值进行处理操作",
            "9.groupBy - 将奇数偶数分成两组",
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
        ]
        self.p_addSectionData(with: tempClassNameArray, titleArray: tempTitleArray, title: "八、变换操作（Transforming Observables）")
        
    }
    
    //MARK:9.groupBy
    ///也就是说该操作符会将元素通过某个键进行分组，然后将分组后的元素序列以 Observable 的形态发送出来。
    @objc func demo9() {
        //将奇数偶数分成两组
        Observable<Int>.of(0,1,2,3,4,5)
            .groupBy(keySelector: { (element) -> String in
                return element % 2 == 0 ? "偶数" : "基数"   //产生key值
            })
            .subscribe { [weak self] (event) in
                switch event {
                case .next(let group):
                    group.asObservable().subscribe { (event) in
                        print("key: \(group.key)  event: \(event)")
                    }.disposed(by: self!.disposeBag)
                default:
                    print("")
                }
            }
            .disposed(by: disposeBag)
    }
    
    
    //MARK:8.scan
    ///scan 就是先给一个初始化的数，然后不断的拿前一个结果和最新的值进行处理操作。
    @objc func demo8() {
        Observable.of(1,2,3,4,5)
            .scan(0) { (accumulate, element) in
                accumulate + element
            }
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    //MARK:7.concatMap
    ///concatMap 与 flatMap 的唯一区别是：当前一个 Observable 元素发送完毕后，后一个Observable 才可以开始发出元素。
    ///或者说等待前一个 Observable 产生完成事件后，才对后一个 Observable 进行订阅。
    
    ///类似于串联线程
    @objc func demo7() {
        let subject1 = BehaviorSubject(value: "A")
        let subject2 = BehaviorSubject(value: "1")
         
        let variable = Variable(subject1)
        
        variable.asObservable()
            .concatMap{ subject -> BehaviorSubject<String> in
                print(subject)
                return subject
            }
            .subscribe(onNext: { (text) in
                print(text)
            })
            //.concatMap{ $0 }
            //.subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        subject1.onNext("B")
        variable.value = subject2
        subject2.onNext("2")
        subject1.onNext("C")
        subject1.onCompleted()  //只有前一个序列结束后，才能接收下一个序列
    }
    
    //MARK:6，flatMapFirst
    ///flatMapFirst 与 flatMapLatest 正好相反：flatMapFirst 只会接收最初的 value 事件。
    @objc func demo6() {
        let subject1 = BehaviorSubject(value: "A")
        let subject2 = BehaviorSubject(value: "1")
         
        let variable = Variable(subject1)
        
        variable.asObservable()
            .flatMapFirst{ subject -> BehaviorSubject<String> in
                print(subject)
                return subject
            }
            .subscribe(onNext: { (text) in
                print(text)
            })
            //.flatMapFirst{ $0 }
            //.subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        subject1.onNext("B")
        variable.value = subject2
        subject2.onNext("2")
        subject1.onNext("C")
    }
    
    //MARK: 5，flatMapLatest
    ///flatMapLatest 与 flatMap 的唯一区别是：flatMapLatest 只会接收最新的 value 事件。
    @objc func demo5() {
        let subject1 = BehaviorSubject(value: "A")
        let subject2 = BehaviorSubject(value: "1")
         
        let variable = Variable(subject1)
        
        variable.asObservable()
            .flatMapLatest{ subject -> BehaviorSubject<String> in
                print(subject)
                return subject
            }
            .subscribe(onNext: { (text) in
                print(text)
            })
            //.flatMapLatest{ $0 }
            //.subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        subject1.onNext("B")
        variable.value = subject2
        subject2.onNext("2")
        subject1.onNext("C")
    }
    
    //MARK: 4，flatMap
    @objc func demo4() {
        let subject1 = BehaviorSubject(value: "A")
        let subject2 = BehaviorSubject(value: "1")
        
        let variable = Variable(subject1)
        
        variable.asObservable()
            .flatMap{ subject -> BehaviorSubject<String> in
                print(subject)
                return subject
            }
            .subscribe(onNext: { (text) in
                print(text)
            })
            //.flatMap{ $0 }
            //.subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        subject1.onNext("B")
        variable.value = subject2
        subject2.onNext("2")
        subject1.onNext("C")
        
    }
    
    
    //MARK: 3，map
    ///该操作符通过传入一个函数闭包把原来的 Observable 序列转变为一个新的 Observable 序列。
    @objc func demo3() {
        Observable.of(1,2,3)
            .map{ $0 * 10 }
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    //MARK: 2，window
    /// 1. buffer 是周期性的将缓存的元素集合发送出来，而 window 周期性的将元素集合以 Observable 的形态发送出来。
    ///2. 同时 buffer 要等到元素搜集完毕后，才会发出元素序列。而 window 可以实时发出元素序列。
    @objc func demo2() {
        let subject = PublishSubject<String>()
        
        subject
            .window(timeSpan: 1, count: 3, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                
                print("subscribe: \($0)")
                $0.asObservable()
                    .subscribe(onNext: { print($0)})
                    .disposed(by: self!.disposeBag)
            })
            .disposed(by: disposeBag)
        
        subject.onNext("a")
        subject.onNext("b")
        subject.onNext("c")
        
        subject.onNext("1")
        subject.onNext("2")
        subject.onNext("3")
    }
    
    //MARK: 八、变换操作（Transforming Observables）
    //MARK: 1，buffer
    @objc func demo1() {
        let subject = PublishSubject<String>()
        
        //每缓存3个元素则组合起来一起发出。
        //如果1秒钟内不够3个也会发出（有几个发几个，一个都没有发空数组 []）
        subject
            .buffer(timeSpan: 1, count: 3, scheduler: MainScheduler.instance)
            .subscribe(onNext: { print($0)
            })
            .disposed(by: disposeBag)
        
        subject.onNext("a")
        subject.onNext("b")
        subject.onNext("c")
        
        subject.onNext("1")
        subject.onNext("2")
        subject.onNext("3")
    }
}
