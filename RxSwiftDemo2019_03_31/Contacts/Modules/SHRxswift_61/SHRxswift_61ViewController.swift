//
//  SHRxswift_61ViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by 远平 on 2019/11/24.
//  Copyright © 2019 远平. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

//MARK: 拦截自定义方法
class SHRxswift_61ViewController: UIViewController {
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //使用sentMessage获取方法执行前的序列
        self.rx.sentMessage(#selector(SHRxswift_61ViewController.test))
            .subscribe(onNext: { (value) in
                print("1: \(value[0])")
            })
        .disposed(by: disposeBag)
        
        //使用methodInvoked获取方法执行后的序列
        self.rx.methodInvoked(#selector(SHRxswift_61ViewController.test(_:)))
            .map { (a) in
                return try castOrThrow(String.self, a[0])
        }.subscribe(onNext: { (value) in
            print("3: \(value)")
        })
        .disposed(by: disposeBag)
        
        //调用自定义方法
        test("univer2012.com")
    }
    
    //自定义方法
    @objc dynamic func test(_ value: String) {
        print("2: \(value)")
    }
}

//转类型的函数（转换失败后，会发出Error）
fileprivate func castOrThrow<T>(_ resultType: T.Type, _ object: Any) throws -> T {
    guard let returnValue = object as? T else {
        throw RxCocoaError.castingError(object: object, targetType: resultType)
    }
    
    return returnValue
}









#if false
//MARK: 拦截 VC 的 viewWillAppear 方法
class SHRxswift_61ViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //使用sentMwessage方法获取Observable
        self.rx.sentMessage(#selector(SHRxswift_61ViewController.viewWillAppear(_:)))
            .subscribe(onNext: { (value) in
                print("1")
            })
            .disposed(by: disposeBag)
        
        //使用methodInvoked方法获取Observable
        self.rx.methodInvoked(#selector(SHRxswift_61ViewController.viewWillAppear(_:)))
            .subscribe(onNext: { (value) in
                print("3")
            })
            .disposed(by: disposeBag)
    }
    
    //默认的viewWillAppear方法
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("2")
    }

}
#endif
