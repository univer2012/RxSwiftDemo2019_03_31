//
//  SHRxswift_7NewViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by Mac on 2020/4/17.
//  Copyright © 2020 远平. All rights reserved.
//
/*
* 来自：[Swift - RxSwift的使用详解7（Subjects、Variables）](https://www.hangge.com/blog/cache/detail_1929.html)
*/
import UIKit
import RxSwift
import RxCocoa

class SHRxswift_7NewViewController: SHBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.actionType = .method
        //section 1
        let tempTitleArray = [
            "2.PublishSubject",
            "3.BehaviorSubject",
            "4.ReplaySubject",
            "5.Variable - 注意：由于 Variable 在之后版本中将被废弃，建议使用 Varible 的地方都改用下面介绍的 BehaviorRelay 作为替代。）\n\n当这个方法执行完毕后，这个 Variable 对象就会被销毁，同时它也就自动地向它的所有订阅者发出 .completed 事件",
            "6.BehaviorRelay - （2）上面的 Variable 样例我们可以改用成 BehaviorRelay\n\n注意，此时执行完后也没有.completed 事件发出",
            "6.BehaviorRelay - （3）如果想将新值合并到原值上，可以通过 accept() 方法与 value 属性配合来实现。（这个常用在表格上拉加载功能上，BehaviorRelay 用来保存所有加载到的数据）",
        ]
        let tempClassNameArray = [
            "demo1",
            "demo2",
            "demo3",
            "demo5",
            "demo6_1",
            "demo6_2",
        ]
        self.p_addSectionData(with: tempClassNameArray, titleArray: tempTitleArray, title: "七、Subjects 介绍")
    }
    
    //MARK: （3）如果想将新值合并到原值上，可以通过 accept() 方法与 value 属性配合来实现。（这个常用在表格上拉加载功能上，BehaviorRelay 用来保存所有加载到的数据）
    @objc func demo6_2() {
        let disposeBag = DisposeBag()
         
        //创建一个初始值为包含一个元素的数组的BehaviorRelay
        let subject = BehaviorRelay<[String]>(value: ["1"])
         
        //修改value值
        subject.accept(subject.value + ["2", "3"])
         
        //第1次订阅
        subject.asObservable().subscribe {
            print("第1次订阅：", $0)
            }.disposed(by: disposeBag)
         
        //修改value值
        subject.accept(subject.value + ["4", "5"])
         
        //第2次订阅
        subject.asObservable().subscribe {
            print("第2次订阅：", $0)
            }.disposed(by: disposeBag)
         
        //修改value值
        subject.accept(subject.value + ["6", "7"])
    }
    
    //MARK: 6，BehaviorRelay
    //MARK:（2）上面的 Variable 样例我们可以改用成 BehaviorRelay
    @objc func demo6_1() {
        let disposeBag = DisposeBag()
         
        //创建一个初始值为111的BehaviorRelay
        let subject = BehaviorRelay<String>(value: "111")
         
        //修改value值
        subject.accept("222")
         
        //第1次订阅
        subject.asObservable().subscribe {
            print("第1次订阅：", $0)
            }.disposed(by: disposeBag)
         
        //修改value值
        subject.accept("333")
         
        //第2次订阅
        subject.asObservable().subscribe {
            print("第2次订阅：", $0)
            }.disposed(by: disposeBag)
         
        //修改value值
        subject.accept("444")
        
        //注意，此时执行完后也没有.completed 事件发出
    }
    
    //MARK: 5，Variable
    ///注意：由于 Variable 在之后版本中将被废弃，建议使用 Varible 的地方都改用下面介绍的 BehaviorRelay 作为替代。）
    @objc func demo5() {
        let disposeBag = DisposeBag()
         
        //创建一个初始值为111的Variable
        let variable = Variable("111")
         
        //修改value值
        variable.value = "222"
         
        //第1次订阅
        variable.asObservable().subscribe {
            print("第1次订阅：", $0)
        }.disposed(by: disposeBag)
         
        //修改value值
        variable.value = "333"
         
        //第2次订阅
        variable.asObservable().subscribe {
            print("第2次订阅：", $0)
        }.disposed(by: disposeBag)
         
        //修改value值
        variable.value = "444"
        
        //当这个方法执行完毕后，这个 Variable 对象就会被销毁，同时它也就自动地向它的所有订阅者发出 .completed 事件
    }
    
    //MARK: 4，ReplaySubject
    @objc func demo3() {
        let disposeBag = DisposeBag()
         
        //创建一个bufferSize为2的ReplaySubject
        let subject = ReplaySubject<String>.create(bufferSize: 2)
         
        //连续发送3个next事件
        subject.onNext("111")
        subject.onNext("222")
        subject.onNext("333")
         
        //第1次订阅subject
        subject.subscribe { event in
            print("第1次订阅：", event)
        }.disposed(by: disposeBag)
         
        //再发送1个next事件
        subject.onNext("444")
         
        //第2次订阅subject
        subject.subscribe { event in
            print("第2次订阅：", event)
        }.disposed(by: disposeBag)
         
        //让subject结束
        subject.onCompleted()
         
        //第3次订阅subject
        subject.subscribe { event in
            print("第3次订阅：", event)
        }.disposed(by: disposeBag)
    }
        
    //MARK: 3，BehaviorSubject
    //当一个订阅者来订阅它的时候，这个订阅者会立即收到 BehaviorSubjects 上一个发出的 event。之后就跟正常的情况一样，它也会接收到 BehaviorSubject 之后发出的新的 event。
    @objc func demo2() {
        let disposeBag = DisposeBag()
         
        //创建一个BehaviorSubject
        let subject = BehaviorSubject(value: "111")
         
        //第1次订阅subject
        subject.subscribe { event in
            print("第1次订阅：", event)
        }.disposed(by: disposeBag)
         
        //发送next事件
        subject.onNext("222")
         
        //发送error事件
        subject.onError(NSError(domain: "local", code: 0, userInfo: nil))
         
        //第2次订阅subject
        subject.subscribe { event in
            print("第2次订阅：", event)
        }.disposed(by: disposeBag)
    }
    
    //MARK: 七、Subjects 介绍
    //MARK: 1，Subjects 基本介绍
    //MARK: 2.PublishSubject
    @objc func demo1() {
        let disposeBag = DisposeBag()
         
        //创建一个PublishSubject
        let subject = PublishSubject<String>()
         
        //由于当前没有任何订阅者，所以这条信息不会输出到控制台
        subject.onNext("111")
         
        //第1次订阅subject
        subject.subscribe(onNext: { string in
            print("第1次订阅：", string)
        }, onCompleted:{
            print("第1次订阅：onCompleted")
        }).disposed(by: disposeBag)
         
        //当前有1个订阅，则该信息会输出到控制台
        subject.onNext("222")
         
        //第2次订阅subject
        subject.subscribe(onNext: { string in
            print("第2次订阅：", string)
        }, onCompleted:{
            print("第2次订阅：onCompleted")
        }).disposed(by: disposeBag)
         
        //当前有2个订阅，则该信息会输出到控制台
        subject.onNext("333")
         
        //让subject结束
        subject.onCompleted()
         
        //subject完成后会发出.next事件了。
        subject.onNext("444")
         
        //subject完成后它的所有订阅（包括结束后的订阅），都能收到subject的.completed事件，
        subject.subscribe(onNext: { string in
            print("第3次订阅：", string)
        }, onCompleted:{
            print("第3次订阅：onCompleted")
        }).disposed(by: disposeBag)
    }

}
