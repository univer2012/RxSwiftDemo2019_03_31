//
//  SHRxswift_48ViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by 远平 on 2019/11/6.
//  Copyright © 2019 远平. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxAlamofire
import Alamofire

class SHRxswift_48ViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var progressView: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //指定下载路径（文件名不变）
        let destination: DownloadRequest.DownloadFileDestination = {_, response in
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            print("documentsURL:",documentsURL)
            let fileURL = documentsURL.appendingPathComponent("file1/myLogo.png")
            //两个参数表示如果有同名文件则会覆盖，如果路径中文件夹不存在则会自动创建
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        //需要下载的文件
        let fileURL = URL(string: "http://www.hangge.com/blog/images/logo.png")!
        
        //开始下载
        download(URLRequest(url: fileURL), to: destination).map{request in
            //返回一个关于进度的可观察序列
            Observable<Float>.create { (observer) -> Disposable in
                request.downloadProgress { (progress) in
                   
                    observer.onNext(Float(progress.fractionCompleted))
                    
                    if progress.isFinished {
                        observer.onCompleted()
                    }
                }
                return Disposables.create()
            }
        }
        .flatMap{$0}
        .bind(to: progressView.rx.progress) //将进度绑定UIProgressView上
        .disposed(by: disposeBag)
        
    }
    
}


////指定下载路径（文件名不变）
//let destination: DownloadRequest.DownloadFileDestination = {_, response in
//    let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
//    print("documentsURL:",documentsURL)
//    let fileURL = documentsURL.appendingPathComponent("file1/myLogo.png")
//    //两个参数表示如果有同名文件则会覆盖，如果路径中文件夹不存在则会自动创建
//    return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
//}
//
////需要下载的文件
//let fileURL = URL(string: "http://www.hangge.com/blog/images/logo.png")!
//
////开始下载
//download(URLRequest(url: fileURL), to: destination).subscribe(onNext: { (element) in
//    print("开始下载。")
//    element.downloadProgress { (progress) in
//        print("当前进度：\(progress.fractionCompleted)")
//        print(" 已下载：\(progress.completedUnitCount / 1024)KB")
//        print(" 总大小：\(progress.totalUnitCount / 1024)KB")
//    }
//}, onError: { (error) in
//    print("下载失败！失败原因：\(error)")
//}, onCompleted: {
//    print("下载完毕！")
//}).disposed(by: disposeBag)


////指定下载路径（文件名不变）
//let destination: DownloadRequest.DownloadFileDestination = {_, response in
//    let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
//    print("documentsURL:",documentsURL)
//    let fileURL = documentsURL.appendingPathComponent("file1/myLogo.png")
//    //两个参数表示如果有同名文件则会覆盖，如果路径中文件夹不存在则会自动创建
//    return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
//}
//
////需要下载的文件
//let fileURL = URL(string: "http://www.hangge.com/blog/images/logo.png")!
//
////开始下载
//download(URLRequest(url: fileURL), to: destination).subscribe(onNext: { (element) in
//    print("开始下载。")
//}, onError: { (error) in
//    print("下载失败！失败原因：\(error)")
//}, onCompleted: {
//    print("下载完毕")
//}).disposed(by: disposeBag)






////指定下载路径（文件名不变）
//let destination: DownloadRequest.DownloadFileDestination = {_, response in
//    let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
//    let fileURL = documentsURL.appendingPathComponent(response.suggestedFilename!)
//    //两个参数表示如果有同名文件则会覆盖，如果路径中文件夹不存在则会自动创建
//    return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
//}
//
////需要下载的文件
//let fileURL = URL(string: "http://www.hangge.com/blog/images/logo.png")!
//
////开始下载
//download(URLRequest(url: fileURL), to: destination).subscribe(onNext: { (element) in
//    print("开始下载。")
//}, onError: { (error) in
//    print("下载失败！失败原因：\(error)")
//}, onCompleted: {
//    print("下载完毕")
//}).disposed(by: disposeBag)

