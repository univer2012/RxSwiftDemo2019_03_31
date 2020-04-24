//
//  SHRxswift_19ViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by Mac on 2019/7/22.
//  Copyright © 2019 远平. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa
import RxDataSources

import RxAlamofire
import Alamofire

class SHRxswift_19ViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    var progressView: UIProgressView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progressView = UIProgressView(frame: CGRect.zero)
        view.addSubview(progressView)
        progressView.snp_makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(100)
        }
        
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent("file1/myLogo.png")
            print("fileURL:", fileURL)
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }

        let fileURL = URL(string: "http://www.hangge.com/blog/images/logo.png")!
        
        download(URLRequest(url: fileURL), to: destination)
            .map { (request) in
                //返回一个关于进度的可观察序列
                Observable<Float>.create {observer in
                    request.downloadProgress(closure: { (progress) in
                        observer.onNext(Float(progress.fractionCompleted))
                        if progress.isFinished {
                            observer.onCompleted()
                        }
                    })
                    return Disposables.create()
                }
            }
            .flatMap{$0}
            .bind(to: progressView.rx.progress) //将进度绑定UIProgressView上
            .disposed(by: disposeBag)
        
    }
}
