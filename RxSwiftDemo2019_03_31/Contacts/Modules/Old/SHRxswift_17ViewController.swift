//
//  SHRxswift_17ViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by rrd on 2019/7/9.
//  Copyright © 2019 远平. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa
import RxDataSources

import RxAlamofire

class SHRxswift_17ViewController: UIViewController {
    let disposeBag = DisposeBag()
    @IBOutlet weak var startBtn: UIButton!
    
    @IBOutlet weak var cancelBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        #if false //URLSessioni请求
        let urlString = "https://www.douban.com/j/app/radio/channels"
        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        
        startBtn.rx.tap.asObservable()
            .flatMap {
                URLSession.shared.rx.data(request: request)
                .takeUntil(self.cancelBtn.rx.tap)
            }
            .subscribe(onNext: { (data) in
                let str = String(data: data, encoding: String.Encoding.utf8)
                print("请求成功！返回的数据是：",str ?? "")
            }, onError: { (error) in
                print("请求失败！错误原因：",error)
            }).disposed(by: disposeBag)
        #else
        // RxAlamofire
        let urlString = "https://www.douban.com/j/app/radio/channels"
        let url = URL(string: urlString)!

        requestJSON(.get, url)
            .map{$1}
        .mapObject(type: Douban.self)
            .subscribe(onNext: { (douban: Douban) in
                if let channels = douban.channels {
                    print("--- 共\(channels.count)个频道 ----")
                    for channel in channels {
                        if let name = channel.name, let channelId = channel.channelId {
                            print("\(name) (id:\(channelId)")
                        }
                    }
                }
            }).disposed(by: disposeBag)
        
        //需要上传的文件路径
        let fileURL = Bundle.main.url(forResource: "hangge", withExtension: "zip")
        //服务器路径
        let uploadURL = URL(string: "http://www.hangge.com/upload.php")!
        //将文件上传到服务器
        upload(fileURL!, urlRequest: try! urlRequest(.post, uploadURL))
            .subscribe(onCompleted: {
                print("上传完毕！")
            }).disposed(by: disposeBag)
        
        
//        startBtn.rx.tap.asObservable()
//            .flatMap {
//                request(.get, url).responseString()
//                .takeUntil(self.cancelBtn.rx.tap)//如果“取消按钮”点击则停止请求
//            }
//        .subscribe(onNext: {
//            response,data in
//            print("请求成功！返回的数据是：",data)
//        }, onError: {error in
//            print("请求失败！错误原因：",error)
//        }).disposed(by: disposeBag)
        #endif
    }
}
