//
//  SHRxswift_22D3ViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by Mac on 2020/4/21.
//  Copyright © 2020 远平. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SHRxswift_22D3ViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    @IBOutlet weak var textField1: UITextField!
    
    @IBOutlet weak var textField2: UITextField!
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Observable.combineLatest(textField1.rx.text.orEmpty, textField2.rx.text.orEmpty) {
            textValue1, textValue2 -> String in
                return "你输入的号码是：\(textValue1)-\(textValue2)"
            }
            .map{ $0 }
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
    }
    

}
