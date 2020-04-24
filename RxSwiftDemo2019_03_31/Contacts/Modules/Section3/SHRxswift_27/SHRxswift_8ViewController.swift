//
//  SHRxswift_8ViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by rrd on 2019/6/27.
//  Copyright © 2019 远平. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

struct UserViewModel {
    //用户名
    let username = Variable("guest")
    //用户信息
    lazy var userinfo = {
        return self.username.asObservable()
            .map {$0 == "hangge" ? "您是管理员" : "您是普通访客"}
        .share(replay: 1)
    }()
}

class SHRxswift_8ViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!
    
    var userVM = UserViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //将用户名与textField做双向绑定
        userVM.username.asObservable().bind(to: textField.rx.text).disposed(by: disposeBag)
        textField.rx.text.orEmpty.bind(to: userVM.username).disposed(by: disposeBag)
        //将用户信息绑定到label上
        userVM.userinfo.bind(to: label.rx.text).disposed(by: disposeBag)
        
    }
}

