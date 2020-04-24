//
//  SHRxswift_5NewViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by Mac on 2020/4/17.
//  Copyright © 2020 远平. All rights reserved.
//
/*
 * 来自：[Swift - RxSwift的使用详解5（观察者1： AnyObserver、Binder）](https://www.hangge.com/blog/cache/detail_1941.html)
 */
import UIKit

import RxSwift
import RxCocoa

class SHRxswift_5NewViewController: SHBaseTableViewController {

    lazy var label: UILabel = {
        let lab = UILabel()
        lab.textColor = .black
        self.view.addSubview(lab)
        return lab
    }()
    
    lazy var button: UIButton = {
        let btn = UIButton()
        btn.setTitle("立即登录", for: .normal)
        
        btn.setBackgroundImage(UIImage.image(withColor: .blue), for: .normal)
        btn.setBackgroundImage(UIImage.image(withColor: .gray), for: .disabled)
        btn.layer.cornerRadius = 6
        btn.layer.masksToBounds = true
        view.addSubview(btn)
        return btn
    }()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.actionType = .method
        //section 1
        var tempTitleArray = [
            "1.在 subscribe 方法中创建",
            "2.在 bind 方法中创建",
            "1.使用 AnyObserver 创建观察者 - 配合 subscribe 方法使用",
            "2.使用 AnyObserver 创建观察者 - 配合 bindTo 方法使用",
        ]
        var tempClassNameArray = [
            "demo1",
            "demo2",
            "demo3",
            "demo4",
        ]
        self.p_addSectionData(with: tempClassNameArray, titleArray: tempTitleArray, title: "二、直接在 subscribe、bind 方法中创建观察者")
        
        //
        tempTitleArray = [
            "1.配合 subscribe 方法使用",
            "2.配合 bindTo 方法使用",
        ]
        tempClassNameArray = [
            "demo3",
            "demo4",
        ]
        self.p_addSectionData(with: tempClassNameArray, titleArray: tempTitleArray, title: "三、使用 AnyObserver 创建观察者")
        
        tempTitleArray = [
            "2.使用样例",
        ]
        tempClassNameArray = [
            "demo5",
        ]
        self.p_addSectionData(with: tempClassNameArray, titleArray: tempTitleArray, title: "四、使用 Binder 创建观察者")
        
        tempTitleArray = [
            "交替变换button背景色",
        ]
        tempClassNameArray = [
            "demo6",
        ]
        self.p_addSectionData(with: tempClassNameArray, titleArray: tempTitleArray, title: "附：Binder 在 RxCocoa 中的应用")
    }
    
    //MARK:附：Binder 在 RxCocoa 中的应用
    //交替变换button背景色
    @objc func demo6() {
        self.button.snp_makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-80)
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
        
        //Observable序列（每隔1秒钟发出一个索引数）
        let observable = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        observable
            .map { $0 % 2 == 0 }
            .bind(to: button.rx.isEnabled)
            .disposed(by: disposeBag)
    }
    
    //MARK:四、使用 Binder 创建观察者
    //MARK:2，使用样例
    @objc func demo5() {
        self.label.snp_makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(100)
        }
        
        //观察者
        let observer: Binder<String> = Binder(label) { (view,text) in
            //收到发出的索引数后显示到label上
            view.text = text
        }
        
        //
        let observable = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        observable
            .map { "当前索引数：\($0)" }
            .bind(to: observer)
            .disposed(by: disposeBag)
    }
    
    //2.配合 bindTo 方法使用
    //MARK:2.配合 bindTo 方法使用
    @objc func demo4() {
        self.label.snp_makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(100)
        }
        
        //观察者
        let observer: AnyObserver<String> = AnyObserver {[weak self] (event) in
            switch event {
            case .next(let text):
                //收到发出的索引数后显示到label上
                self?.label.text = text
            default:
                break
            }
        }
        
        //Observable序列（每隔1秒钟发出一个索引数）
        let observable = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        observable.map{ "当前索引数：\($0)" }
            .bind(to: observer)
            .disposed(by: disposeBag)
        
    }
    //MARK: 三、使用 AnyObserver 创建观察者
    ///1，配合 subscribe 方法使用
    //MARK:1.配合 subscribe 方法使用
    @objc func demo3() {
        let observer: AnyObserver<String> = AnyObserver { event in
            switch event {
            case .next(let data):
                print(data)
            case .error(let error):
                print(error)
            case .completed:
                print("completed")
            }
        }
        
        let observable = Observable.of("A", "B", "C")
        observable.subscribe(observer)
    }
    
    //MARK:2.在 bind 方法中创建
    @objc func demo2() {
        self.label.snp_makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(100)
        }
        
        let observable = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        
        observable
            .map { "当前索引数：\($0)" }
            .bind { [weak self] text in
                self?.label.text = text
            }
            .disposed(by: disposeBag)
    }
    
    //MARK:一、观察者（Observer）介绍
    //MARK:二、直接在 subscribe、bind 方法中创建观察者
    ///
    //MARK:1.在 subscribe 方法中创建
    @objc func demo1() {
        let observable = Observable.of("A", "B", "C")
        
        observable.subscribe(onNext: { (element) in
            print(element)
        }, onError: { (error) in
            print(error)
        }, onCompleted: {
            print("completed")
        })
    }

}
