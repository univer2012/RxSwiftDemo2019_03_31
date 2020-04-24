//
//  SHRxswift_15NewViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by Mac on 2020/4/19.
//  Copyright © 2020 远平. All rights reserved.
//
/*
* 来自：[Swift - RxSwift的使用详解15（错误处理）](https://www.hangge.com/blog/cache/detail_1936.html)
*/
import UIKit
import RxSwift
import RxCocoa

class SHRxswift_15NewViewController: SHBaseTableViewController {

    enum MyError: Error {
        case A
        case B
    }
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.actionType = .method
        //section 1
        let tempTitleArray = [
            "1.catchErrorJustReturn \n当遇到 error 事件的时候，就返回指定的值，然后结束。",
            "2.catchError \n可以捕获 error，并对其进行处理。\n同时还能返回另一个 Observable 序列进行订阅（切换到新的序列）。",
            "3.retry \n使用该方法当遇到错误的时候，会重新订阅该序列。比如遇到网络请求失败时，可以进行重新连接。\n可以传入数字表示重试次数。不传的话只会重试一次。",
        ]
        let tempClassNameArray = [
            "demo1",
            "demo2",
            "demo3",
            "demo4",
            "demo5",
            "demo6",
        ]
        self.p_addSectionData(with: tempClassNameArray, titleArray: tempTitleArray, title: "十五、错误处理操作（Error Handling Operators） ")
    }
    
    //MARK:3.retry
    ///1. 使用该方法当遇到错误的时候，会重新订阅该序列。比如遇到网络请求失败时，可以进行重新连接。
    ///2. retry() 方法可以传入数字表示重试次数。不传的话只会重试一次。
    ///
    ///retry  [ˌriːˈtraɪ]  vt. [计] 重试；重审
    @objc func demo3() {
        var count = 1
        
        let sequenceThatErrors = Observable<String>.create { observer in
            observer.onNext("a")
            observer.onNext("b")
            
            //让第一个订阅时发生错误
            if count == 1 {
                observer.onError(MyError.A)
                print("Error encountered")
                count += 1
            }
            
            observer.onNext("c")
            observer.onNext("d")
            observer.onCompleted()
            
            return Disposables.create()
        }
        
        sequenceThatErrors
            .retry(2)   //重试2次（参数为空则只重试一次）
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    //MARK:2.catchError
    ///1. 该方法可以捕获 error，并对其进行处理。
    ///2. 同时还能返回另一个 Observable 序列进行订阅（切换到新的序列）。
    @objc func demo2() {
        let sequenceThatFails = PublishSubject<String>()
        let recoverySequence = Observable.of("1", "2", "3")
        
        sequenceThatFails
            .catchError {
                print("Error:", $0)
                return recoverySequence
            }
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        sequenceThatFails.onNext("a")
        sequenceThatFails.onNext("b")
        sequenceThatFails.onNext("c")
        sequenceThatFails.onError(MyError.A)
        sequenceThatFails.onNext("d")
    }
    
    //MARK: 十五、错误处理操作（Error Handling Operators）
    //MARK:1.catchErrorJustReturn
    ///当遇到 error 事件的时候，就返回指定的值，然后结束。
    @objc func demo1() {
        let sequenceThatFails = PublishSubject<String>()
        
        sequenceThatFails
            .catchErrorJustReturn("错误")
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        sequenceThatFails.onNext("a")
        sequenceThatFails.onNext("b")
        sequenceThatFails.onNext("c")
        sequenceThatFails.onError(MyError.A)
        sequenceThatFails.onNext("d")
    }

    
}
