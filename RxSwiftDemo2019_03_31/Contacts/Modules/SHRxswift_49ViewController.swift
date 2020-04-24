//
//  SHRxswift_49ViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by Mac on 2019/11/6.
//  Copyright © 2019 远平. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SHRxswift_49ViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //获取数据
        DouBanProvider.rx.request(.channels).subscribe(onSuccess: { (response) in
            //数据处理
            let str = String(data: response.data, encoding: String.Encoding.utf8)
            print("返回的数据时：",str ?? "")
        }) { (error) in
            print("数据请求失败！错误原因：",error)
        }.disposed(by: disposeBag)
        
    }
    
}


////获取数据
//DouBanProvider.rx.request(.channels).subscribe { (event) in
//    switch event {
//    case let .success(response):
//        //数据处理
//        let str = String(data: response.data, encoding: String.Encoding.utf8)
//        print("返回的数据时：",str ?? "")
//    case let .error(error):
//        print("数据请求失败！错误原因：",error)
//    }
//}.disposed(by: disposeBag)


