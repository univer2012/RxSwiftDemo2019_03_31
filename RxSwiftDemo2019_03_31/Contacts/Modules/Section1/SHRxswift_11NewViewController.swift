//
//  SHRxswift_11NewViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by Mac on 2020/4/18.
//  Copyright © 2020 远平. All rights reserved.
//
/*
* 来自：[Swift - RxSwift的使用详解11（结合操作符：startWith、merge、zip等）](https://www.hangge.com/blog/cache/detail_1930.html)
*/
import UIKit
import RxSwift
import RxCocoa

class SHRxswift_11NewViewController: SHBaseTableViewController {
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.actionType = .method
        //section 1
        let tempTitleArray = [
            "1.startWith - 会在 Observable 序列开始之前插入一些事件元素。",
            "1.startWith - （3）当然插入多个数据也是可以的",
            "2.merge - 可以将多个（两个或两个以上的）Observable 序列合并成一个 Observable 序列。",
            "3.zip - 将多个（两个或两个以上的）Observable 序列压缩成一个 Observable 序列。\n等到每个 Observable 事件一一对应地凑齐之后再合并",
            "附：zip 常常用在整合网络请求上。",
            "4.combineLatest - 每当任意一个 Observable 有新的事件发出时，它会将每个 Observable 序列的最新的一个事件元素进行合并。",
            "5.withLatestFrom - 每当 self 队列发射一个元素时，便从第二个序列中取出最新的一个值",
            "6.switchLatest - 本来监听的 subject1，我可以通过更改 variable 里面的 value 更换事件源。变成监听 subject2",
        ]
        let tempClassNameArray = [
            "demo1",
            "demo1_2",
            "demo2",
            "demo3",
            "demo3_1",
            "demo4",
            "demo5",
            "demo6",
        ]
        self.p_addSectionData(with: tempClassNameArray, titleArray: tempTitleArray, title: "十一、结合操作（Combining Observables） ")
    }
    //MARK: 6.switchLatest
    ///1. switchLatest 有点像其他语言的 switch 方法，可以对事件流进行转换。
    ///2. 比如本来监听的 subject1，我可以通过更改 variable 里面的 value 更换事件源。变成监听 subject2。
    @objc func demo6() {
        let subject1 = BehaviorSubject(value: "A")
        let subject2 = BehaviorSubject(value: "1")
        
        let variable = Variable(subject1)
        
        variable.asObservable()
            .switchLatest()
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        subject1.onNext("B")
        subject1.onNext("C")
        
        //改变事件源
        variable.value = subject2
        subject1.onNext("D")
        subject2.onNext("2")
        
        //改变事件源
        variable.value = subject1
        subject2.onNext("3")
        subject1.onNext("E")
    }
    
    //MARK: 5.withLatestFrom
    ///该方法将两个 Observable 序列合并为一个。每当 self 队列发射一个元素时，便从第二个序列中取出最新的一个值。
    @objc func demo5() {
        let subject1 = PublishSubject<String>()
        let subject2 = PublishSubject<String>()
        
        subject1.withLatestFrom(subject2)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        subject1.onNext("A")
        subject2.onNext("1")
        subject1.onNext("B")
        subject1.onNext("C")
        subject2.onNext("2")
        subject1.onNext("D")
    }
    
    //MARK: 4.combineLatest
    ///1. 该方法同样是将多个（两个或两个以上的）Observable 序列元素进行合并。
    ///2. 但与 zip 不同的是，每当任意一个 Observable 有新的事件发出时，它会将每个 Observable 序列的最新的一个事件元素进行合并。
    @objc func demo4() {
        let subject1 = PublishSubject<Int>()
        let subject2 = PublishSubject<String>()
        
        Observable.combineLatest(subject1, subject2) {
            "\($0)\($1)"
        }
        .subscribe(onNext: { print($0) })
        .disposed(by: disposeBag)
        
        subject1.onNext(1)
        subject2.onNext("A")
        subject1.onNext(2)
        subject2.onNext("B")
        subject2.onNext("C")
        subject2.onNext("D")
        subject1.onNext(3)
        subject1.onNext(4)
        subject1.onNext(5)
    }
    
    //MARK: 附：zip 常常用在整合网络请求上。
    ///比如我们想同时发送两个请求，只有当两个请求都成功后，再将两者的结果整合起来继续往下处理。这个功能就可以通过 zip 来实现。
    @objc func demo3_1() {
        //第一个请求
        let userRequest: Observable<User> = API.getUser("me")
        
        //第二个请求
        let friendsRequest: Observable<Friends> = API.getFriends("me")
        
        //将两个请求合并处理
        Observable.zip(userRequest, friendsRequest) { (user, friends) in
                //将两个信号合并成一个信号，并压缩成一个元组返回（两个信号均成功）
                return (user, friends)
        }.observeOn(MainScheduler.instance)
            .subscribe(onNext: { (user, friends) in
                //将数据绑定到界面上
                //... ...
            }).disposed(by: disposeBag)
    }
    
    //MARK: 3.zip
    ///该方法可以将多个（两个或两个以上的）Observable 序列压缩成一个 Observable 序列。
    ///而且它会等到每个 Observable 事件一一对应地凑齐之后再合并。
    @objc func demo3() {
        let subject1 = PublishSubject<Int>()
        let subject2 = PublishSubject<String>()
        
        Observable.zip(subject1, subject2) {
                "\($0)\($1)"
            }
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        subject1.onNext(1)
        subject2.onNext("A")
        subject1.onNext(2)
        subject2.onNext("B")
        subject2.onNext("C")
        subject2.onNext("D")
        subject1.onNext(3)
        subject1.onNext(4)
        subject1.onNext(5)
    }
    
    //MARK: 2，merge
    ///该方法可以将多个（两个或两个以上的）Observable 序列合并成一个 Observable 序列。
    @objc func demo2() {
        let subject1 = PublishSubject<Int>()
        let subject2 = PublishSubject<Int>()
        
        Observable.of(subject1,subject2)
            .merge()
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        subject1.onNext(20)
        subject1.onNext(40)
        subject1.onNext(60)
        subject2.onNext(1)
        subject1.onNext(80)
        subject1.onNext(100)
        subject2.onNext(1)
    }
    
    //MARK: （3）当然插入多个数据也是可以的
    @objc func demo1_2() {
        Observable.of("2", "3")
            .startWith("a")
            .startWith("b")
            .startWith("c")
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    //MARK: 十一、结合操作（Combining Observables）
    //MARK:1.startWith
    ///该方法会在 Observable 序列开始之前插入一些事件元素。即发出事件消息之前，会先发出这些预先插入的事件消息。
    @objc func demo1() {
        Observable.of("2", "3")
            .startWith("1")
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    

}


class User: NSObject {
    
}
class Friends: NSObject {
    
}
struct API {
    static func getFriends(_ text:String) -> Observable<Friends> {
        return Observable<Friends>.of(Friends())
    }
    
    static func getUser(_ text:String) -> Observable<User> {
        return Observable<User>.of(User())
    }
}
