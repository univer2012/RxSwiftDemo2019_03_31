//
//  SHRxswift_19NewViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by Mac on 2020/4/19.
//  Copyright © 2020 远平. All rights reserved.
//
/*
* 来自：[Swift - RxSwift的使用详解19（特征序列3：ControlProperty、 ControlEvent）](https://www.hangge.com/blog/cache/detail_1943.html)
*/
import UIKit
import RxSwift
import RxCocoa

class SHRxswift_19NewViewController: SHBaseTableViewController {

    let disposeBag = DisposeBag()
    
    lazy var textField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.placeholder = "请输入内容"
        return tf
    }()
    lazy var label: UILabel = {
        let lab = UILabel()
        lab.textColor = .black
        return lab
    }()
    lazy var button: UIButton = {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = .cyan
        btn.setTitleColor(.white, for: .normal)
        btn.setTitle("请点击", for: .normal)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(textField)
        textField.snp_makeConstraints { (make) in
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-50)
            make.top.equalToSuperview().offset(100)
        }
        view.addSubview(label)
        label.snp_makeConstraints { (make) in
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-50)
            make.top.equalTo(textField.snp_bottom).offset(20)
        }
        view.addSubview(button)
        button.snp_makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(40)
            make.top.equalTo(label.snp_bottom)
        }
        
        
        tableView?.snp_remakeConstraints({ (make) in
            make.top.equalTo(button.snp_bottom).offset(10)
            make.left.right.bottom.equalToSuperview()
        })
        

        self.actionType = .method
        //section 1
        var tempTitleArray = [
            "2.如果想让一个 textField 里输入内容实时地显示在另一个 label 上，即前者作为被观察者，后者作为观察者。",
            
        ]
        var tempClassNameArray = [
            "demo1",
        ]
        self.p_addSectionData(with: tempClassNameArray, titleArray: tempTitleArray, title: "五、ControlProperty")
        
        //section 2
        tempTitleArray = [
            "1.使用UIButton 的 rx.tap 方法实现点击事件",
            
        ]
        tempClassNameArray = [
            "sec2demo1",
        ]
        self.p_addSectionData(with: tempClassNameArray, titleArray: tempTitleArray, title: "六 、ControlEvent")
    }
    
    //MARK: 附：给 UIViewController 添加 RxSwift 扩展
    /*
     ### 1，UIViewController+Rx.swift
     这里我们对 UIViewController 进行扩展：

     * 将 viewDidLoad、viewDidAppear、viewDidLayoutSubviews 等各种 ViewController 生命周期的方法转成 ControlEvent 方便在 RxSwift 项目中使用。
     * 增加 isVisible 序列属性，方便对视图的显示状态进行订阅。
     * 增加 isDismissing 序列属性，方便对视图的释放进行订阅。
     
     （代码在`UIViewController+Rx.swift`文件中）
     
      ### 2，使用样例
     （1）通过扩展，我们可以直接对 VC 的各种方法进行订阅。
     */
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        //页面显示状态完毕
        self.rx.isVisible
            .subscribe(onNext: { visible in
                print("当前页面显示状态： \(visible)")
            }).disposed(by: disposeBag)
        
        //页面加载完毕
        self.rx.viewDidLoad
            .subscribe(onNext: {
                print("viewDidLoad")
            }).disposed(by: disposeBag)
        
        //页面将要显示
        self.rx.viewWillAppear
            .subscribe(onNext: { animated in
                print("viewWillAppear")
            }).disposed(by: disposeBag)
        
        //页面显示完毕
        self.rx.viewDidAppear
            .subscribe(onNext: { (animated) in
                print("viewWillAppear")
            }).disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: 六 、ControlEvent
    /*
     # 六 、ControlEvent
     ### 1，基本介绍
     （1）ControlEvent 是专门用于描述 UI 所产生的事件，拥有该类型的属性都是被观察者（Observable）。
     （2）ControlEvent 和 ControlProperty 一样，都具有以下特征：

     * 不会产生 error 事件
     * 一定在 MainScheduler 订阅（主线程订阅）
     * 一定在 MainScheduler 监听（主线程监听）
     * 共享状态变化

     ### 2，使用样例
     （1）同样地，在 RxCocoa 下许多 UI 控件的事件方法都是被观察者（可观察序列）。比如我们查看源码（UIButton+Rx.swift），可以发现 UIButton 的 rx.tap 方法类型便是 ControlEvent<Void>：

     */
    //MARK: 1.使用UIButton 的 rx.tap 方法实现点击事件
    @objc func sec2demo1() {
        //订阅按钮点击事件
        button.rx.tap.subscribe(onNext: {
            print("欢迎访问hangge.com")
            })
            .disposed(by: disposeBag)
    }
    
    
    
    //MARK: 五、ControlProperty
    /*
     # 五、ControlProperty
     ### 1，基本介绍
     （1）ControlProperty 是专门用来描述 UI 控件属性，拥有该类型的属性都是被观察者（Observable）。
     （2）ControlProperty 具有以下特征：

     * 不会产生 error 事件
     * 一定在 MainScheduler 订阅（主线程订阅）
     * 一定在 MainScheduler 监听（主线程监听）
     * 共享状态变化

     ### 2，使用样例
     （2）那么我们如果想让一个 textField 里输入内容实时地显示在另一个 label 上，即前者作为被观察者，后者作为观察者。可以这么写：
     */
    //MARK: 2.如果想让一个 textField 里输入内容实时地显示在另一个 label 上，即前者作为被观察者，后者作为观察者。
    @objc func demo1() {
        //将textField输入的文字绑定到label上
        textField.rx.text
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
    }
    

}
