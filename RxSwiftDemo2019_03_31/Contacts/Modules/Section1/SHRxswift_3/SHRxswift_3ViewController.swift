//
//  SHRxswift_3ViewController.swift
//  
//
//  Created by rrd on 2019/6/17.
//
/*
 * 来自：
 * 1.[Swift - RxSwift的使用详解3（Observable介绍、创建可观察序列）](https://www.hangge.com/blog/cache/detail_1922.html)
 */
import UIKit

import RxSwift
import RxCocoa

class SHRxswift_3ViewController: SHBaseTableViewController {
    
    let viewModel = SHRxswift_3ViewModel()
    let disposeBag = DisposeBag()
    
    let priceTextFld = UITextField()
    
    var priceDispose :Disposable?
    var observer : Observable<String>?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.actionType = .method
        //section 1
        let tempTitleArray = [
            "1.just() 方法",
            "2.of() 方法",
            "3.from() 方法",
            "4.empty() 方法",
            "5，never() 方法",
            "6，error() 方法",
            "7，range() 方法",
            "8，repeatElement() 方法",
            "9.generate() 方法",
            "10.create() 方法",
            "11.deferred() 方法",
            "12.interval() 方法",
            "13.timer() 方法1",
            "13.timer() 方法2",
            "14.有关输入框的监听-没有回调",
            "15.有关输入框的监听-有回调",
            "16.测试多次调用.subscribe(onNext:)，看是否会多次被监听。初始化代码块",
            "16.测试多次调用.subscribe(onNext:)，看是否会多次被监听。监听代码块",
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
            "demo11",
            "demo12",
            "demo13_1",
            "demo13_2",
            "demo14",
            "demo15",
            "demo16_code1",
            "demo16_code2",
        ]
        
        self.p_addSectionData(with: tempClassNameArray, titleArray: tempTitleArray, title: "第1部分")
        
        
        
    }
    //MARK: 16.测试多次调用.subscribe(onNext:)，看是否会多次被监听。监听代码块，改进
    @objc func demo16_code3() {
        self.priceTextFld.rx.text.orEmpty.distinctUntilChanged().asObservable().subscribe(onNext: {[weak self] (text) in
            guard let `self` = self else { return }
            
            self.viewModel.didClickOpen("你好").subscribe(onSuccess: { (text) in
                print("callBack_succeed：\(text)__haode")
            }).disposed(by: self.disposeBag)
                                    
        }).disposed(by: self.disposeBag)
    }
    
    //MARK: 16.测试多次调用.subscribe(onNext:)，看是否会多次被监听。监听代码块
    /*
     * 测试结果：
     * 1. 点击多少次demo16_code2 方法，就会有多少次监听。
     * 2. 一开始时就会调用`.subscribe(onNext:)`block里面的代码。
     */
    @objc func demo16_code2() {
        self.priceTextFld.rx.text.asObservable().subscribe(onNext: {[weak self] (text) in
            guard let `self` = self else { return }
            
            self.viewModel.didClickOpen("你好").subscribe(onSuccess: { (text) in
                print("callBack_succeed：\(text)__haode")
            }).disposed(by: self.disposeBag)
                                    
        }).disposed(by: self.disposeBag)
    }
    
    //MARK: 16.测试多次调用.subscribe(onNext:)，看是否会多次被监听。初始化代码块
    @objc func demo16_code1() {
        self.priceTextFld.frame = CGRect(x: 0, y: 200, width: self.view.frame.size.width, height: 50)
        self.priceTextFld.backgroundColor = UIColor.gray
        self.view.addSubview(priceTextFld)
    }
    
    //MARK: 15.有关输入框的监听-有回调
    @objc func demo15() {
        self.priceTextFld.frame = CGRect(x: 0, y: 200, width: self.view.frame.size.width, height: 50)
        self.priceTextFld.backgroundColor = UIColor.gray
        self.view.addSubview(priceTextFld)
        
//        self.observer = self.viewModel.didClickOpen("").asObservable()
//
//        observer?.subscribe(onNext: { (text) in
//            print("callBack_succeed_observer：\(text)__OK") //返回的text，是singleFunc(.success("OK"))发出来的"OK"
//        }).disposed(by: self.disposeBag)
        
        self.priceTextFld.rx.text.asObservable().subscribe(onNext: {[weak self] (text) in
            guard let `self` = self else { return }
            
            print("callBack_succeed_observer:\(String(describing: text))__OK")
            self.viewModel.didClickOpen("有回调").subscribe(onSuccess: { (text) in
                print("callBack_succeed：\(text)__haode")
            }).disposed(by: self.disposeBag)
                        
            //响应
//            self.priceDispose?.dispose()
//            self.priceDispose = nil
//            self.priceDispose = self.viewModel.priceSpreadResponse.takeUntil(self.rx.deallocated).subscribe(onNext: { [weak self] (isOK) in
//                guard let `self` = self else { return }
//
//                print("监听priceTextFld的值2：")
//            })
//            self.viewModel.priceSpreadSubject.onNext(true)
            
            
        }).disposed(by: self.disposeBag)
    }
    
    //MARK: 14.有关输入框的监听-没有回调
    @objc func demo14() {
        
        self.priceTextFld.frame = CGRect(x: 0, y: 200, width: self.view.frame.size.width, height: 50)
        self.priceTextFld.backgroundColor = UIColor.gray
        self.view.addSubview(priceTextFld)
        
//        self.observer = self.viewModel.didClickOpen("").asObservable()
//
//        observer?.subscribe(onNext: { (text) in
//            print("callBack_succeed_observer：\(text)__OK")
//        }).disposed(by: self.disposeBag)
        
        self.priceTextFld.rx.text.asObservable().subscribe(onNext: {[weak self] (text) in
            guard let `self` = self else { return }
            
            print("callBack_succeed_observer:\(String(describing: text))__OK")
            let _ = self.viewModel.didClickOpen("没有回调")
                        
            //响应
//            self.priceDispose?.dispose()
//            self.priceDispose = nil
//            self.priceDispose = self.viewModel.priceSpreadResponse.takeUntil(self.rx.deallocated).subscribe(onNext: { [weak self] (isOK) in
//                guard let `self` = self else { return }
//
//                print("监听priceTextFld的值2：")
//            })
//            self.viewModel.priceSpreadSubject.onNext(true)
            
            
        }).disposed(by: self.disposeBag)
    }
    
    //MARK: 13.timer() 方法2
    //（2）另一种是创建的 Observable 序列在经过设定的一段时间后，每隔一段时间产生一个元素。
    @objc func demo13_2() {
        //延时5秒种后，每隔1秒钟发出一个元素
        let observable = Observable<Int>.timer(5, period: 1, scheduler: MainScheduler.instance).takeUntil(self.rx.deallocated)
        
        observable.subscribe { event in
            print(event)
        }
        
        
    }
    
    //MARK: 13.timer() 方法1
    //（1）一种是创建的 Observable 序列在经过设定的一段时间后，产生唯一的一个元素。
    @objc func demo13_1() {
        //5秒种后发出唯一的一个元素0
        let observable = Observable<Int>.timer(5, scheduler: MainScheduler.instance).takeUntil(self.rx.deallocated)
        
        observable.subscribe { event in
            print(event)
        }
    }
    
    //MARK: 12.interval() 方法
    @objc func demo12() {
        let observable = Observable<Int>.interval(1, scheduler: MainScheduler.instance).takeUntil(self.rx.deallocated)
        
        observable.subscribe { event in
            print(event)
        }
    }
    
    //MARK: 11.deferred() 方法
    @objc func demo11() {
        //用于标记是奇数、还是偶数
        var isOdd = true
         
        //使用deferred()方法延迟Observable序列的初始化，通过传入的block来实现Observable序列的初始化并且返回。
        let factory : Observable<Int> = Observable.deferred {
             
            //让每次执行这个block时候都会让奇、偶数进行交替
            isOdd = !isOdd
             
            //根据isOdd参数，决定创建并返回的是奇数Observable、还是偶数Observable
            if isOdd {
                return Observable.of(1, 3, 5 ,7)
            }else {
                return Observable.of(2, 4, 6, 8)
            }
        }
         
        //第1次订阅测试
        factory.subscribe { event in
            print("\(isOdd)", event)
        }
         
        //第2次订阅测试
        factory.subscribe { event in
            print("\(isOdd)", event)
        }
    }
    //MARK: 10.create() 方法
    @objc func demo10() {
        //这个block有一个回调参数observer就是订阅这个Observable对象的订阅者
        //当一个订阅者订阅这个Observable对象的时候，就会将订阅者作为参数传入这个block来执行一些内容
        let observable = Observable<String>.create{observer in
            //对订阅者发出了.next事件，且携带了一个数据"hangge.com"
            observer.onNext("hangge.com")
            //对订阅者发出了.completed事件
            observer.onCompleted()
            //因为一个订阅行为会有一个Disposable类型的返回值，所以在结尾一定要returen一个Disposable
            return Disposables.create()
        }
         
        //订阅测试
        observable.subscribe {
            print($0)
        }
    }
    
    //MARK: 9.generate() 方法
    @objc func demo9() {
        //使用generate()方法
        let observable = Observable.generate(
            initialState: 0,
            condition: { $0 <= 10 },
            iterate: { $0 + 2 }
        )
         
        //使用of()方法
        let observable2 = Observable.of(0 , 2 ,4 ,6 ,8 ,10)
    }
    //MARK: 8，repeatElement() 方法
    @objc func demo8() {
        let observable8 = Observable.repeatElement(1)
    }
    //MARK: 7，range() 方法
    @objc func demo7() {
        //使用range()
        let observable7_1 = Observable.range(start: 1, count: 5)
        //使用of()
        let observable7_2 = Observable.of(1,2,3,4,5)
    }
    //MARK: 6，error() 方法
    @objc func demo6() {
        enum MyError: Error {
            case A
            case B
        }
        let observable6 = Observable<Int>.error(MyError.A)
    }
    //MARK: 5，never() 方法
    @objc func demo5() {
        let observable5 = Observable<Int>.never()
    }
    //MARK: 4，empty() 方法
    @objc func demo4() {
        let observable4 = Observable<Int>.empty()
    }
    //MARK: 3，from() 方法
    @objc func demo3() {
        let observable3 = Observable.from(["A","B","C"])
    }
    //MARK: 2，of() 方法
    @objc func demo2() {
        let observable2 = Observable.of("A","B","C")
    }
    //MARK: 1，just() 方法
    @objc func demo1() {
        let observable = Observable<Int>.just(5)
    }

}
