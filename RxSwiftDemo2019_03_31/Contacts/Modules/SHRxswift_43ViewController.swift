//
//  SHRxswift_43ViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by Mac on 2019/11/4.
//  Copyright © 2019 远平. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa
import RxDataSources



class SHRxswift_43ViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    //"发起请求"按钮
    @IBOutlet weak var startBtn: UIButton!
    //“取消请求”按钮
    @IBOutlet weak var cancelBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //创建URL对象
        let urlString = "https://www.douban.com/j/app/radio/channels"
        let url = URL(string: urlString)
        //创建请求对象
        let request = URLRequest(url: url!)

        startBtn.rx.tap.asObservable().flatMap{
            URLSession.shared.rx.data(request: request).takeUntil(self.cancelBtn.rx.tap)
        }
        .subscribe(onNext: { (data) in
            let str = String(data: data, encoding: String.Encoding.utf8)
            print("请求成功！，返回的数据时：",str ?? "")
            
        }, onError: { (error) in
            print("请求失败！错误原因：",error)
            
        }).disposed(by: disposeBag)
        
    }

}
