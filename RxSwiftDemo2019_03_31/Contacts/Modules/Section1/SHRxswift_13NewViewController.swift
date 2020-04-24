//
//  SHRxswift_13NewViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by Mac on 2020/4/19.
//  Copyright © 2020 远平. All rights reserved.
//
/*
* 来自：[Swift - RxSwift的使用详解13（连接操作符：connect、publish、replay、multicast）](https://www.hangge.com/blog/cache/detail_1935.html)
*/
import UIKit
import RxSwift
import RxCocoa

class SHRxswift_13NewViewController: SHBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.actionType = .method
        //section 1
        let tempTitleArray = [
            "1.可连接的序列 \n可看到，两个订阅者接收到的值是不同步的。",
            "2.publish \n会将一个正常的序列转换成一个可连接的序列。同时该序列不会立刻发送事件，只有在调用 connect 之后才会开始",
            "3.replay \n新的订阅者还能接收到订阅之前的事件消息（数量由设置的 bufferSize 决定）",
            "4.multicast \n multicast 方法还可以传入一个 Subject，每当序列发送事件时都会触发这个 Subject 的发送。",
            "5.refCount \n可以将可被连接的 Observable 转换为普通 Observable。",
            "6.share(relay:) \n将使得观察者共享源 Observable，并且缓存最新的 n 个元素，将这些元素直接发送给新的观察者。\n\n简单来说 shareReplay 就是 replay 和 refCount 的组合。",
        ]
        let tempClassNameArray = [
            "demo1",
            "demo2",
            "demo3",
            "demo4",
            "demo5",
            "demo6",
        ]
        self.p_addSectionData(with: tempClassNameArray, titleArray: tempTitleArray, title: "十三、连接操作（Connectable Observable Operators） ")
    }
    
    //MARK:6.share(relay:)
    ///1. 该操作符将使得观察者共享源 Observable，并且缓存最新的 n 个元素，将这些元素直接发送给新的观察者。
    ///2. 简单来说 shareReplay 就是 replay 和 refCount 的组合。
    @objc func demo6() {
        //每隔1秒钟发送1个事件
        let interval = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
            .takeUntil(self.rx.deallocated)
            .share(replay: 5)
        
        //第一个订阅者（立刻开始订阅）
        _ = interval.subscribe(onNext: { print("订阅1： \($0)") })
        
        //第二个订阅者（延迟5秒开始订阅）
        delay(5) {
            _ = interval.subscribe(onNext: { print("订阅2： \($0)") })
        }
    }
    
    //MARK:5.refCount
    ///1. refCount 操作符可以将可被连接的 Observable 转换为普通 Observable。
    ///2. 即该操作符可以自动连接和断开可连接的 Observable。当第一个观察者对可连接的 Observable 订阅时，那么底层的 Observable 将被自动连接。当最后一个观察者离开时，那么底层的 Observable 将被自动断开连接。
    ///
    @objc func demo5() {
        //每隔1秒钟发送1个事件
        let interval = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
            .takeUntil(self.rx.deallocated)
            .publish()
            .refCount()
        
        //第一个订阅者（立刻开始订阅）
        _ = interval.subscribe(onNext: { print("订阅1： \($0)") })
        
        //第二个订阅者（延迟5秒开始订阅）
        delay(5) {
            _ = interval.subscribe(onNext: { print("订阅2： \($0)") })
        }
    }
    
    //MARK:4.multicast
    ///1. multicast 方法同样是将一个正常的序列转换成一个可连接的序列。
    ///2. 同时 multicast 方法还可以传入一个 Subject，每当序列发送事件时都会触发这个 Subject 的发送。
    ///
    ///multicast ['mʌltikɑ:st, -kæst]   n. 多路广播；多路传送
    @objc func demo4() {
        //创建一个Subject（后面的multicast()方法中传入）
        let subject = PublishSubject<Int>()
        
        //这个Subject的订阅
        _ = subject.subscribe(onNext: { print("Subject: \($0)") })
        
        //每隔1秒钟发送1个事件
        let interval = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
            .takeUntil(self.rx.deallocated)
            .multicast(subject)
        
        
        //第一个订阅者（立刻开始订阅）
        _ = interval.subscribe(onNext: { print("订阅1： \($0)") })
        
        //相当于把事件消息推迟了两秒
        delay(2) {
            _ = interval.connect()
        }
        
        //第二个订阅者（延迟5秒开始订阅）
        delay(5) {
            _ = interval.subscribe(onNext: { print("订阅2： \($0)") })
        }
        
    }
    
    //MARK:3.replay
    ///1. replay 同上面的 publish 方法相同之处在于：会将将一个正常的序列转换成一个可连接的序列。同时该序列不会立刻发送事件，只有在调用 connect 之后才会开始。
    ///2. replay 与 publish 不同在于：新的订阅者还能接收到订阅之前的事件消息（数量由设置的 bufferSize 决定）。
    ///
    ///replay  [ˈriːpleɪ]   v. 重放（录音带、录像带或电影）；重现，重演
    @objc func demo3() {
        //每隔1秒钟发送1个事件
        let interval = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
            .takeUntil(self.rx.deallocated)
            .replay(5)
            
        //第一个订阅者（立刻开始订阅）
        _ = interval.subscribe(onNext: { print("订阅1： \($0)") })
        
        //相当于把事件消息推迟了两秒
        delay(2) {
            _ = interval.connect()
        }
        
        //第二个订阅者（延迟5秒开始订阅）
        delay(5) {
            _ = interval.subscribe(onNext: { print("订阅2： \($0)") })
        }
    }
    
    //MARK:2.publish
    ///publish 方法会将一个正常的序列转换成一个可连接的序列。同时该序列不会立刻发送事件，只有在调用 connect 之后才会开始。
    @objc func demo2() {
        //每隔1秒钟发送1个事件
        let interval = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
            .takeUntil(self.rx.deallocated)
            .publish()
        
        //第一个订阅者（立刻开始订阅）
        _ = interval.subscribe(onNext: { print("订阅1： \($0)") })
        
        //相当于把事件消息推迟了两秒
        delay(2) {
            _ = interval.connect()
        }
        
        //第二个订阅者（延迟5秒开始订阅）
        delay(5) {
            _ = interval.subscribe(onNext: { print("订阅2： \($0)") })
        }
    }
    
    
    //MARK:十三、连接操作（Connectable Observable Operators）
    //MARK:1，可连接的序列
    ///（1）可连接的序列和一般序列不同在于：有订阅时不会立刻开始发送事件消息，只有当调用 connect() 之后才会开始发送值。
    ///（2）可连接的序列可以让所有的订阅者订阅后，才开始发出事件消息，从而保证我们想要的所有订阅者都能接收到事件消息。
    @objc func demo1() {
        //每隔1秒钟发送1个事件
        let interval = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
            .takeUntil(self.rx.deallocated)
        
        //第一个订阅者（立刻开始订阅）
        _ = interval.subscribe(onNext: { print("订阅1： \($0)") })
        
        //第二个订阅者（延迟5秒开始订阅）
        delay(5) {
            _ = interval.subscribe(onNext: { print("订阅2： \($0)") })
        }
        
    }
    
    
}
extension SHRxswift_13NewViewController {
    ///延迟执行
    /// - Parameters:
    ///   - delay: 延迟时间（秒）
    ///   - closure: 延迟执行的闭包
    public func delay (_ delay: Double, closure: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            closure()
        }
    }
}
