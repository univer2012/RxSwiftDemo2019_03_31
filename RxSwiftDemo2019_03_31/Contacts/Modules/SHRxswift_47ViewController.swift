//
//  SHRxswift_47ViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by 远平 on 2019/11/5.
//  Copyright © 2019 远平. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxAlamofire
import Alamofire

class SHRxswift_47ViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var progressView: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //字符串
        let strData = "hangge.com".data(using: String.Encoding.utf8)
        //数字
        let intData = String(10).data(using: String.Encoding.utf8)
        //文件1
        let path = Bundle.main.url(forResource: "0", withExtension: "png")!
        let file1Data = try! Data(contentsOf: path)
        //文件2
        let file2URL = Bundle.main.url(forResource: "1", withExtension: "png")
        
        //服务器路径
        let uploadURL = URL(string: "http://www.hangge.com/upload2.php")!
        
        //将文件上传到服务器
        upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(strData!, withName: "value1")
            multipartFormData.append(intData!, withName: "value2")
            multipartFormData.append(file1Data, withName: "file1",fileName: "php.png", mimeType: "image/png")
            multipartFormData.append(file2URL!, withName: "file2")
        }, to: uploadURL) { (encodingResult) in
            switch encodingResult {
            case .success(request: let upload, _, _):
                upload.responseJSON(completionHandler: { (response) in
                    debugPrint(response)
                })
            case .failure(let encodingError):
                print(encodingError)
            }
        }
        
    }

}



////需要上传的文件
//let fileURL1 = Bundle.main.url(forResource: "0", withExtension: "png")
//let fileURL2 = Bundle.main.url(forResource: "1", withExtension: "png")
//
////服务器路径
//let uploadURL = URL(string: "http://www.hangge.com/upload2.php")!
//
////将文件上传到服务器
//upload(multipartFormData: { (multipartFormData) in
//    multipartFormData.append(fileURL1!, withName: "file1")
//    multipartFormData.append(fileURL2!, withName: "file2")
//}, to: uploadURL) { (encodingResult) in
//    switch encodingResult {
//    case .success(request: let upload, _, _):
//        upload.responseJSON(completionHandler: { (response) in
//            debugPrint(response)
//        })
//    case .failure(let encodingError):
//        print(encodingError)
//    }
//}






////需要上传的文件路径
//let fileURL = Bundle.main.url(forResource: "hangge", withExtension: "zip")
////服务器路径
//let uploadURL = URL(string: "http://www.hangge.com/upload.php")!
//
////将文件上传到服务器
//upload(fileURL!, urlRequest: try! urlRequest(.post, uploadURL)).map{request in
//    //返回一个关于进度的可观察序列
//    Observable<Float>.create{observer in
//        request.uploadProgress(closure: { (progress) in
//            observer.onNext(Float(progress.fractionCompleted))
//            if progress.isFinished {
//                observer.onCompleted()
//            }
//        })
//        return Disposables.create()
//    }
//    }
//    .flatMap{$0}
//    .bind(to: progressView.rx.progress)     //将进度绑定UIProgressView上
//    .disposed(by: disposeBag)




////需要上传的文件路径
//let fileURL = Bundle.main.url(forResource: "hangge", withExtension: "zip")
////服务器路径
//let uploadURL = URL(string: "http://www.hangge.com/upload.php")!
//
////将文件上传到服务器
//upload(fileURL!, urlRequest: try! urlRequest(.post, uploadURL)).subscribe(onNext: { (element) in
//    print("--- 开始上传 ---")
//    element.uploadProgress(closure: { (progress) in
//        print("当前进度：\(progress.fractionCompleted)")
//        print(" 已上传载：\(progress.completedUnitCount / 1024)KB")
//        print(" 总大小：\(progress.totalUnitCount / 1024)KB")
//    })
//}, onError: { (error) in
//    print("上传失败！失败原因：\(error)")
//}, onCompleted: {
//    print("上传完毕！")
//}).disposed(by: disposeBag)



////需要上传的文件路径
//let fileURL = Bundle.main.url(forResource: "hangge", withExtension: "zip")
////服务器路径
//let uploadURL = URL(string: "http://www.hangge.com/upload.php")!
//
////将文件上传到服务器
//upload(fileURL!, urlRequest: try! urlRequest(.post, uploadURL)).subscribe(onCompleted: {
//
//    print("上传完毕！")
//}).disposed(by: disposeBag)
