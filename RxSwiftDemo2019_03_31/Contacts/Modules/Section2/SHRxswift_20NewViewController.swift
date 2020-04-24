//
//  SHRxswift_20NewViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by Mac on 2020/4/19.
//  Copyright © 2020 远平. All rights reserved.
//
/*
* 来自：[Swift - RxSwift的使用详解20（调度器、subscribeOn、observeOn）](https://www.hangge.com/blog/cache/detail_1940.html)
*/
import UIKit
import RxSwift
import RxCocoa

class SHRxswift_20NewViewController: SHBaseTableViewController {
    
    let disposeBag = DisposeBag()
    
    let urlText = "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1587320708961&di=ac72014e3647260b2cb418b4ddcc68e8&imgtype=0&src=http%3A%2F%2Fimg.08087.cc%2Fuploads%2F20191223%2F18%2F1577098270-azHRMjKysW.jpg"
    
    var data: Data?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.actionType = .method
        //section 1
        var tempTitleArray = [
            "1.以请求网络数据并显示为例。我们在后台发起网络请求，然后解析数据，最后在主线程刷新页面。",
            "2.如果使用 RxSwift 来实现，代码大概是这样的：",
        ]
        var tempClassNameArray = [
            "demo1",
            "demo2",
        ]
        self.p_addSectionData(with: tempClassNameArray, titleArray: tempTitleArray, title: "二十、调度器（Schedulers）")
    }
    
    //MARK: 3，subscribeOn 与 observeOn 区别
    /*
     ### 3，subscribeOn 与 observeOn 区别
     （1）subscribeOn()

         该方法决定数据序列的构建函数在哪个 Scheduler 上运行。
         比如上面样例，由于获取数据、解析数据需要花费一段时间的时间，所以通过 subscribeOn 将其切换到后台 Scheduler 来执行。这样可以避免主线程被阻塞。

     （2）observeOn()

         该方法决定在哪个 Scheduler 上监听这个数据序列。
         比如上面样例，我们获取并解析完毕数据后又通过 observeOn 方法切换到主线程来监听并且处理结果。
     */
    
    
    //MARK: 2.如果使用 RxSwift 来实现，代码大概是这样的：
    @objc func demo2() {
        let rxData: Observable<Data> = Observable<Data>.create { [weak self] observer in
            guard let `self` = self else {
                return Disposables.create { }
            }
            
            if let url:URL = URL(string: self.urlText),
                let data = try? Data(contentsOf: url) {
                
                observer.onNext(data)
            }
            observer.onCompleted()
            
            return Disposables.create { }
        }
        
        rxData
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .userInitiated)) //后台构建序列
            .observeOn(MainScheduler.instance) //主线程监听并处理序列结果
            .subscribe(onNext: { [weak self] (data) in
                self?.data = data
            })
            .disposed(by: disposeBag)
    }
    
    
    //MARK: 二十、调度器（Schedulers）
    /*
     # 二十、调度器（Schedulers）
     ### 1，基本介绍
     （1）调度器（Schedulers）是 RxSwift 实现多线程的核心模块，它主要用于控制任务在哪个线程或队列运行。
     （2）RxSwift 内置了如下几种 Scheduler：

     * CurrentThreadScheduler：表示当前线程 Scheduler。（默认使用这个）
     * MainScheduler：表示主线程。如果我们需要执行一些和 UI 相关的任务，就需要切换到该 Scheduler 运行。
     * SerialDispatchQueueScheduler：封装了 GCD 的串行队列。如果我们需要执行一些串行任务，可以切换到这个 Scheduler 运行。
     * ConcurrentDispatchQueueScheduler：封装了 GCD 的并行队列。如果我们需要执行一些并发任务，可以切换到这个 Scheduler 运行。
     * OperationQueueScheduler：封装了 NSOperationQueue。


     ### 2，使用样例
    这里以请求网络数据并显示为例。我们在后台发起网络请求，然后解析数据，最后在主线程刷新页面。

     */
    //MARK: 1.以请求网络数据并显示为例。我们在后台发起网络请求，然后解析数据，最后在主线程刷新页面。
    @objc func demo1() {
        if let url:URL = URL(string: urlText) {
            
            //现在后台获取数据
            DispatchQueue.global(qos: .userInitiated).async {
                
                let data = try? Data(contentsOf: url)
                //再到主线程显示结果
                DispatchQueue.main.async {
                    self.data = data
                }
            }
            
        }
        
    }

}
