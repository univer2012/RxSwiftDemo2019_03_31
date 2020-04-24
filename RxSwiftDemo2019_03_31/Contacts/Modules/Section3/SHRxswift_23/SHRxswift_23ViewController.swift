//
//  SHRxswift_23ViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by Mac on 2020/4/21.
//  Copyright © 2020 远平. All rights reserved.
//
/*
* 来自：[Swift - RxSwift的使用详解23（UI控件扩展3：UIButton、UIBarButtonItem）](https://www.hangge.com/blog/cache/detail_1969.html)
*/
import UIKit
import RxSwift
import RxCocoa

class SHRxswift_23ViewController: SHBaseTableViewController {
    
    let disposeBag = DisposeBag()
    
    lazy var button: UIButton = {
        let btn = UIButton()
        btn.setTitle("按钮", for: .normal)
        btn.setTitleColor(.systemBlue, for: .normal)
        return btn
    }()
    
    lazy var switch1: UISwitch = {
        let sw = UISwitch()
        return sw
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(button)
        button.snp_makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(100)
            make.width.equalTo(200)
            make.height.equalTo(46)
        }
        self.remakeTableViewConstraints(with: button)

        self.actionType = .method
        //section 1
        var tempTitleArray = [
            "1.按钮点击响应 - 点击响应我们可以这么写",
            "1_2.或者这么写也行",
            "2.按钮标题（title）的绑定",
            "3.按钮富文本标题（attributedTitle）的绑定",
            "4.按钮图标（image）的绑定",
            "5.按钮背景图片（backgroundImage）的绑定",
            "6.按钮是否可用（isEnabled）的绑定",
            "7.按钮是否选中（isSelected）的绑定",
        ]
        var tempClassNameArray = [
            "demo1",
            "demo1_2",
            "demo2",
            "demo3",
            "demo4",
            "demo5",
            "demo6",
            "demo7",
        ]
        self.p_addSectionData(with: tempClassNameArray, titleArray: tempTitleArray, title: "三、UIButton 与 UIBarButtonItem ")
    }
    
    //MARK: 7.按钮是否选中（isSelected）的绑定
    /*
     ### 7，按钮是否选中（isSelected）的绑定
     */
    @objc func demo7() {
        self.pushToNewVC(with: "SHRxswift_23D7ViewController", title: "7.按钮是否选中（isSelected）的绑定", true)
    }
    
    //MARK: 6.按钮是否可用（isEnabled）的绑定
    /*
     ### 6，按钮是否可用（isEnabled）的绑定
     */
    @objc func demo6() {
        view.addSubview(switch1)
        switch1.snp_makeConstraints { (make) in
            make.centerY.equalTo(button)
            make.right.equalTo(button.snp_left).offset(-20)
        }
        button.setTitleColor(UIColor.gray, for: .disabled)
        
        switch1.rx.isOn
            .bind(to: button.rx.isEnabled)
            .disposed(by: disposeBag)
    }
    
    //MARK: 5.按钮背景图片（backgroundImage）的绑定
    /*
     ### 5，按钮背景图片（backgroundImage）的绑定
     （2）代码如下，其中 rx.backgroundImage 为 setBackgroundImage(_:for:) 的封装。
     */
    @objc func demo5() {
        //创建一个计时器（每1秒发送一个索引数）
        let timer = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        
        //根据索引数选择对应的按钮背景图，并绑定到button上
//        timer.map{ UIImage(named: "\($0 % 2)")! }
//            .bind(to: button.rx.backgroundImage())
//        .disposed(by: disposeBag)
        
        timer.map{ UIImage.image(withColor: $0 % 2 == 0 ? UIColor.lightGray : UIColor.cyan) }
            .bind(to: button.rx.backgroundImage())
        .disposed(by: disposeBag)
    }
    
    //MARK: 4.按钮图标（image）的绑定
    /*
     ### 4，按钮图标（image）的绑定
     （2）代码如下，其中 rx.image 为 setImage(_:for:) 的封装。
     */
    @objc func demo4() {
        //创建一个计时器（每1秒发送一个索引数）
        let timer = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        
        //根据索引数选择对应的按钮图标，并绑定到button上
        timer.map({
            let name = $0 % 2 == 0 ? "back" : "forward"
            return UIImage(named: name)!
        })
            .bind(to: button.rx.image())
        .disposed(by: disposeBag)
    }
    
    //MARK: 3.按钮富文本标题（attributedTitle）的绑定
    /*
     ### 3，按钮富文本标题（attributedTitle）的绑定
     （2）代码如下，其中 rx.attributedTitle 为 setAttributedTitle(_:controlState:) 的封装。
     */
    @objc func demo3() {
        //创建一个计时器（每1秒发送一个索引数）
        let timer = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        
        //将已过去的时间格式化成想要的字符串，并绑定到button上
        timer.map(formatTimeInterval)
            .bind(to: button.rx.attributedTitle())
            .disposed(by: disposeBag)
    }
    
    //MARK: 2.按钮标题（title）的绑定
    /*
     ### 2，按钮标题（title）的绑定
     （2）代码如下，其中 rx.title 为 setTitle(_:for:) 的封装。
     */
    @objc func demo2() {
        //创建一个计时器（每1秒发送一个索引数）
        let timer = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        
        //根据索引数拼接最新的标题，并绑定到button上
        timer.map{ "计数\($0)" }
            .bind(to: button.rx.title(for: .normal))
            .disposed(by: disposeBag)
    }
    
    
    //MARK: 1_2.或者这么写也行
    ///（3）或者这么写也行：
    @objc func demo1_2() {
        //按钮点击响应
        button.rx.tap.bind { [weak self] in
            self?.showMessage("按钮被点击")
        }.disposed(by: disposeBag)
    }
    
    //MARK:三、UIButton 与 UIBarButtonItem
    /*
     ### 1，按钮点击响应
     （2）点击响应我们可以这么写：
     */
    //MARK: 1.按钮点击响应 - 点击响应我们可以这么写
    @objc func demo1() {
        //按钮点击响应
        button.rx.tap.subscribe(onNext: { [weak self] in
                self?.showMessage("按钮被点击")
            }).disposed(by: disposeBag)
    }
    

}

extension UIViewController {
    //显示消息提示框
    func showMessage(_ text: String) {
        let alertController = UIAlertController(title: text, message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
