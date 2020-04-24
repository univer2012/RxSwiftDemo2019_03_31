//
//  SHRxswift_21NewViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by Mac on 2020/4/19.
//  Copyright © 2020 远平. All rights reserved.
//
/*
* 来自：[Swift - RxSwift的使用详解21（UI控件扩展1：UILabel）](https://www.hangge.com/blog/cache/detail_1963.html)
*/
import UIKit
import RxSwift
import RxCocoa


class SHRxswift_21NewViewController: SHBaseTableViewController {

    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.actionType = .method
        //section 1
        var tempTitleArray = [
            "1.将数据绑定到 text 属性上（普通文本）",
            "2.将数据绑定到 attributedText 属性上（富文本）",
        ]
        var tempClassNameArray = [
            "demo1",
            "demo2",
        ]
        self.p_addSectionData(with: tempClassNameArray, titleArray: tempTitleArray, title: "一、UILabel")
    }
    
    ///2，将数据绑定到 attributedText 属性上（富文本）
    //MARK: 2.将数据绑定到 attributedText 属性上（富文本）
    @objc func demo2() {
        //创建文本标签
        let label = UILabel(frame: CGRect(x: 20, y: 100, width: 300, height: 100))
        self.view.addSubview(label)
        
        self.remakeTableViewConstraints(with: label)
        
        //创建一个计时器（每0.1秒发送一个索引数）
        let timer = Observable<Int>.interval(0.1, scheduler: MainScheduler.instance)
        
        //将已过去的时间格式化成想要的字符串，并绑定到label上
        timer.map(formatTimeInterval)
            .bind(to: label.rx.attributedText)
            .disposed(by: disposeBag)
    }
    
    //MARK: 一、UILabel
    ///1，将数据绑定到 text 属性上（普通文本）
    //MARK: 1.将数据绑定到 text 属性上（普通文本）
    @objc func demo1() {
        //创建文本标签
        let label = UILabel(frame: CGRect(x: 20, y: 100, width: 300, height: 100))
        self.view.addSubview(label)
        
        self.remakeTableViewConstraints(with: label)
        
        //创建一个计时器（每0.1秒发送一个索引数）
        let timer = Observable<Int>.interval(0.1, scheduler: MainScheduler.instance)
        
        //将已过去的时间格式化成想要的字符串，并绑定到label上
        timer.map{ String(format: "%0.2d:%0.2d.%0.1d", arguments: [($0 / 600) % 600, ($0 % 600) / 10, $0 % 10]) }
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
    }

}

extension UIViewController {
    
    //将数字转成对应的富文本
    func formatTimeInterval(ms: NSInteger) -> NSMutableAttributedString {
        let string = String(format: "%0.2d:%0.2d.%0.1d", arguments: [(ms / 600) % 600, (ms % 600) / 10, ms % 10])
        
        //
        let attributeString = NSMutableAttributedString(string: string)
        //从文本0开始6个字符字体HelveticaNeue-Bold,16号
        attributeString.addAttribute(NSAttributedString.Key.font, value: UIFont(name: "HelveticaNeue-Bold", size: 16)!, range: NSMakeRange(0, 5))
        //设置字体颜色
        attributeString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSMakeRange(0, 5))
        //设置文字背景颜色
        attributeString.addAttribute(NSAttributedString.Key.backgroundColor, value: UIColor.orange, range: NSMakeRange(0, 5))
        return attributeString
    }
}
