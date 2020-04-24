//
//  Network57Service.swift
//  RxSwiftDemo2019_03_31
//
//  Created by 远平 on 2019/11/10.
//  Copyright © 2019 远平. All rights reserved.
//

import RxSwift
import RxCocoa

class Network57Service {
    
    //获取随机数据
    func getRandomResult() -> Observable<[String]> {
        print("正在请求数据......")
        let items = (0 ..< 15).map { _ in
            "随机数据\(Int(arc4random()))"
        }
        let observable = Observable.just(items)
        return observable.delay(2, scheduler: MainScheduler.instance)
    }
}


