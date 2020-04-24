//
//  SHRxswift_17DetailViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by rrd on 2019/7/9.
//  Copyright © 2019 远平. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SHRxswift_17DetailViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.rx.text.orEmpty.asDriver().drive(onNext: {[unowned self] (text) in
            print("当前输入内容：\(String(describing: text))")
            self.label.text = text
        })
        .disposed(by: disposeBag)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    deinit {
        print(#file,#function)
    }
}
