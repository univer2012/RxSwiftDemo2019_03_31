//
//  SHRxswift_9ViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by rrd on 2019/6/28.
//  Copyright © 2019 远平. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

//class SHRxswift_9ViewController: UIViewController {
//    let disposeBag = DisposeBag()
//
//    @IBOutlet weak var datePicker: UIDatePicker!
//
//    @IBOutlet weak var label: UILabel!
//
//    lazy var dateFormatter: DateFormatter = {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy年MM月dd日 HH:mm"
//        return formatter
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        datePicker.rx.date
//            .map {[weak self] in
//                "當前選擇時間: " + self!.dateFormatter.string(from: $0)
//            }
//        .bind(to: label.rx.text)
//        .disposed(by: disposeBag)
//    }
//}
class SHRxswift_9ViewController: UIViewController {
    let disposeBag = DisposeBag()
    //倒计时时间选择控件
    var ctimer : UIDatePicker!
    //开始按钮
    var btnstart: UIButton!
    //剩余时间（必须为 60 的整数倍，比如设置为100，值自动变为 60）
    let leftTime = Variable(TimeInterval(180))
    //当前倒计时是否结束
    let countDownStopped = Variable(true)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ctimer = UIDatePicker(frame: CGRect(x: 0, y: 80, width: 320, height: 200))
        ctimer.datePickerMode = UIDatePicker.Mode.countDownTimer
        self.view.addSubview(ctimer)
        
        btnstart = UIButton(type: .system)
        btnstart.frame = CGRect(x: 0, y: 300, width: 320, height: 30)
        btnstart.setTitleColor(.red, for: .normal)
        btnstart.setTitleColor(.darkGray, for: .disabled)
        view.addSubview(btnstart)
        
        //剩余时间与datepicker做双向绑定
        DispatchQueue.main.async {
            //_ = self.ctimer.rx.countDownDuration <-> self.leftTime
            self.ctimer.rx.countDownDuration.bind(to: self.leftTime).disposed(by: self.disposeBag)
            self.leftTime.asObservable().bind(to: self.ctimer.rx.countDownDuration).disposed(by: self.disposeBag)
        }
        //绑定button标题
        Observable.combineLatest(leftTime.asObservable(), countDownStopped.asObservable()) { (leftTimeValue, countDownStoppedValue) in
            if countDownStoppedValue {
                return "開始"
            } else {
                return "倒計時開始，還有\(Int(leftTimeValue)) 秒..."
            }
        }.bind(to: btnstart.rx.title())
        .disposed(by: disposeBag)
        
        //绑定button和datepicker状态（在倒计过程中，按钮和时间选择组件不可用）
        countDownStopped.asDriver().drive(ctimer.rx.isEnabled).disposed(by: disposeBag)
        countDownStopped.asDriver().drive(btnstart.rx.isEnabled).disposed(by: disposeBag)
        
        //按钮点击响应
        btnstart.rx.tap
            .bind {[weak self] in
                self?.startClicked()
        }
        .disposed(by: disposeBag)
        
    }
    //开始倒计时
    func startClicked() {
        self.countDownStopped.value = false
         //创建一个计时器
        Observable<Int>.interval(1, scheduler: MainScheduler.instance)
            .takeUntil(countDownStopped.asObservable().filter{ $0 })
            .subscribe { (event) in
                //每次剩余时间减1
                self.leftTime.value -= 1
                if (self.leftTime.value == 0) {
                    print("倒計時結束！")
                    //结束倒计时
                    self.countDownStopped.value = true
                    //重制时间
                    self.leftTime.value = 180
                }
            }
            .disposed(by: disposeBag)
    }
}
