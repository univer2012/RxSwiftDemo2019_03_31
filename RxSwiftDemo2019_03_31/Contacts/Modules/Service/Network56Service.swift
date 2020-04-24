//
//  Network56Service.swift
//  RxSwiftDemo2019_03_31
//
//  Created by Mac on 2019/11/8.
//  Copyright © 2019 远平. All rights reserved.
//

import RxSwift
import RxCocoa

class Network56Service {
    
    //获取随机数据
    func getRandomResult() -> Driver<[String]> {
        print("正在请求数据......")
        let items = (0 ..< 15).map { _ in
            "随机数据\(Int(arc4random()))"
        }
        let observable = Observable.just(items)
        return observable.delay(1, scheduler: MainScheduler.instance).asDriver(onErrorDriveWith: Driver.empty())
    }
}
