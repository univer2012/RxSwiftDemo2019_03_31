//
//  SHRxswift_6ViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by rrd on 2019/6/25.
//  Copyright © 2019 远平. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class SHRxswift_23D7ViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        //默认选中第一个按钮
        button1.isSelected = true
        //强制解包，避免后面还需要处理可选类型
        let buttons = [button1, button2, button3].map {$0!}
        //创建一个可观察序列，它可以发送最后一次点击的按钮（也就是我们需要选中的按钮）
        let selectButton = Observable.from(buttons.map {button in
            button.rx.tap.map {button}
        }).merge()
        //对于每一个按钮都对selectedButton进行订阅，根据它是否是当前选中的按钮绑定isSelected属性
        for button in buttons {
            selectButton.map {$0 == button}
            .bind(to: button.rx.isSelected)
            .disposed(by: disposeBag)
        }
    }
}
