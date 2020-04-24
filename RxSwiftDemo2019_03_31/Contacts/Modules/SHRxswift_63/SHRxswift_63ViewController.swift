//
//  SHRxswift_63ViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by 远平 on 2019/11/24.
//  Copyright © 2019 远平. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SHRxswift_63ViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    let observers = [SHRxswift_63MyObserver(name: "观察器1"),SHRxswift_63MyObserver(name: "观察器2")]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("发送通知")
        let notificationName = Notification.Name(rawValue: "DownloadImageNotification")
        NotificationCenter.default.post(name: notificationName, object: self, userInfo: ["value1": "univer2012.com", "value2": 123456])
        print("通知完毕")
    }
}







#if false
//MARK:监听键盘的通知
class SHRxswift_63ViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //添加文本输入框
        let textField = UITextField(frame: CGRect(x: 20, y: 100, width: 200, height: 30))
        textField.borderStyle = .roundedRect
        textField.returnKeyType = .done
        view.addSubview(textField)
        
        //点击键盘上的完成按钮后，收起键盘
        textField.rx.controlEvent(.editingDidEndOnExit)
            .subscribe(onNext: { (_) in
                //收起键盘
                textField.resignFirstResponder()
            })
            .disposed(by: disposeBag)
        
        //监听键盘弹出通知
        _ = NotificationCenter.default.rx
            .notification(UIApplication.keyboardWillShowNotification)
            .takeUntil(self.rx.deallocated)
            .subscribe(onNext: { (_) in
                print("键盘出现了")
            })
        
        //监听键盘隐藏通知
        _ = NotificationCenter.default.rx
            .notification(UIApplication.keyboardWillHideNotification)
            .takeUntil(self.rx.deallocated)
            .subscribe(onNext: { (_) in
                print("键盘消失了")
            })
        
    }
}
#endif






#if false
//MARK: 监听应用进入后台的通知
class SHRxswift_63ViewController: UIViewController {

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()


        //监听应用进入后台通知
        _ = NotificationCenter.default.rx.notification(UIApplication.didEnterBackgroundNotification)
            .takeUntil(self.rx.deallocated) //页面销毁自动移除通知监听
            .subscribe(onNext: { (_) in
                print("程序进入到后台了")
            })
    }
}
#endif
