//
//  SH190708ContactsViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by rrd on 2019/7/8.
//  Copyright © 2019 远平. All rights reserved.
//

import UIKit

import RxSwift

import SnapKit


class SH190708ContactsViewController: SHBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "RxSwift Demo"
        
        //MARK: ===========section 1
        var tempTitleArray = [
            "1基本介绍、安装配置",
            "2响应式编程与传统式编程的比较样例",
            "使用详解3（Observable介绍、创建可观察序列）",
            "使用详解4（Observable订阅、事件监听、订阅销毁）",
            "使用详解5（观察者1： AnyObserver、Binder）",
            "使用详解6（观察者2： 自定义可绑定属性）",
            "使用详解7（Subjects、Variables）",
            "使用详解8（变换操作符：buffer、map、flatMap、scan等）",
            "使用详解9（过滤操作符：filter、take、skip等）",
            "使用详解10（条件和布尔操作符：amb、takeWhile、skipWhile等）",
            "使用详解11（结合操作符：startWith、merge、zip等）",
            "使用详解12（算数&聚合操作符：toArray、reduce、concat）",
            "使用详解13（连接操作符：connect、publish、replay、multicast）",
            "使用详解14（其他操作符：delay、materialize、timeout等）",
            "使用详解15（错误处理）",
            "使用详解16（调试操作）",
        ]
        var tempClassNameArray = [
            "SHRxswift_1ViewController",
            "SHRxswift_2ViewController",
            "SHRxswift_3ViewController",
            "SHRxswift_4NewViewController", //"SHRxswift_4ViewController",
            "SHRxswift_5NewViewController",
            "SHRxswift_6NewViewController",
            "SHRxswift_7NewViewController",
            "SHRxswift_8NewViewController",
            "SHRxswift_9NewViewController",
            "SHRxswift_10NewViewController",
            "SHRxswift_11NewViewController",
            "SHRxswift_12NewViewController",
            "SHRxswift_13NewViewController",
            "SHRxswift_14NewViewController",
            "SHRxswift_15NewViewController",
            "SHRxswift_16NewViewController",
        ]
        self.p_addSectionData(with: tempClassNameArray, titleArray: tempTitleArray, title: "第1部分 操作符")
        
        //MARK: ===========section 2
        tempTitleArray = [
            "使用详解17（特征序列1：Single、Completable、Maybe）",
            "使用详解18（特征序列2：Driver）",
            "使用详解19（特征序列3：ControlProperty、 ControlEvent）",
        ]
        
        tempClassNameArray = [
            "SHRxswift_17NewViewController",
            "SHRxswift_18NewViewController",
            "SHRxswift_19NewViewController",
        ]
        
        self.p_addSectionData(with: tempClassNameArray, titleArray: tempTitleArray, title: "第2部分 特征序列")
        
        
        //MARK: ===========section 3
        tempTitleArray = [
            "使用详解21（UI控件扩展1：UILabel）",
            "使用详解22（UI控件扩展2：UITextField、UITextView）",
            "使用详解23（UI控件扩展3：UIButton、UIBarButtonItem）",
            "使用详解24（UI控件扩展4：UISwitch、UISegmentedControl）",
            "使用详解25（UI控件扩展5：UIActivityIndicatorView、UIApplication）",
            "使用详解26（UI控件扩展6：UISlider、UIStepper）",
            "使用详解27（双向绑定：<->）",
            
            
            
            
            "5UITextView",
            "6UIButton",
            "7UISwitch 与 UISegmentedControl",
            "8双向绑定<->",
            "9UIGestureRecognizer",
            "10UITableView",
            "11可编辑表格",
            "12不同单元格混用",
            "13tableView 样式修改",
            "1UICollectionView",
            "2刷新集合数据",
            "3pickView",
            "4weak_unowned",
            "5URLSession结果处理、模型转换",
            "6结合RxAlamofire使用",
            "7结合Moya使用",
            "使用详解43（URLSession的使用1：请求数据）",
            "使用详解44（URLSession的使用2：结果处理、模型转换）",
            "使用详解45（结合RxAlamofire使用1：数据请求）",
            "使用详解46（结合RxAlamofire使用2：结果处理、模型转换）",
            "使用详解47（结合RxAlamofire使用3：文件上传）",
            "使用详解48（结合RxAlamofire使用4：文件下载）",
            "使用详解49（结合Moya使用1：数据请求）",
            "使用详解50（结合Moya使用2：结果处理、模型转换）",
            "使用详解52（MVVM架构演示2：使用Observable样例）",
            "使用详解53（MVVM架构演示3：使用Driver样例）",
            "使用详解54（一个用户注册样例1：基本功能实现）",
            "使用详解55（一个用户注册样例2：显示网络请求活动指示器）",
            "使用详解56（结合MJRefresh使用1：下拉刷新）",
            "使用详解57（结合MJRefresh使用2：上拉加载、以及上下拉组合）",
            "使用详解58（DelegateProxy样例1：获取地理定位信息 ）",
            "使用详解59（DelegateProxy样例2：图片选择功能 ）",
            "使用详解60（DelegateProxy样例3：应用生命周期的状态变化）",
            "使用详解61（sendMessage和methodInvoked的区别）",
            "使用详解62 (订阅UITableViewCell里的按钮点击事件)",
            "使用详解63 (通知NotificationCenter的使用)",
            "使用详解64（键值观察KVO的使用）",
        ]
        
        tempClassNameArray = [
            "SHRxswift_21NewViewController",
            "SHRxswift_22ViewController",
            "SHRxswift_23ViewController",
            "SHRxswift_24ViewController",
            "SHRxswift_25ViewController",
            "SHRxswift_26ViewController",
            "SHRxswift_27ViewController",
            
            
            
            "SHRxswift_5ViewController",
            "SHRxswift_6ViewController",
            "SHRxswift_7ViewController",
            "SHRxswift_8ViewController",
            "SHRxswift_9ViewController",
            "SHRxswift_10ViewController",
            "SHRxswift_11ViewController",
            "SHRxswift_12ViewController",
            "SHRxswift_13ViewController",
            "SHRxswift_14ViewController",
            "SHRxswift_15ViewController",
            "SHRxswift_16ViewController",
            "SHRxswift_17ViewController",
            "SHRxswift_18ViewController",
            "SHRxswift_19ViewController",
            "SHRxswift_20ViewController",
            "SHRxswift_43ViewController",
            "SHRxswift_44ViewController",
            "SHRxswift_45ViewController",
            "SHRxswift_46ViewController",
            "SHRxswift_47ViewController",
            "SHRxswift_48ViewController",
            "SHRxswift_49ViewController",
            "SHRxswift_50ViewController",
            "SHRxswift_52ViewController",
            "SHRxswift_53ViewController",
            "SHRxswift_54ViewController",
            "SHRxswift_55ViewController",
            "SHRxswift_56ViewController",
            "SHRxswift_57ViewController",
            "SHRxswift_58ViewController",
            "SHRxswift_59ViewController",
            "SHRxswift_60ViewController",
            "SHRxswift_61ViewController",
            "SHRxswift_62ViewController",
            "SHRxswift_63ViewController",
            "SHRxswift_64ViewController",
        ]
        self.p_addSectionData(with: tempClassNameArray, titleArray: tempTitleArray, title: "第3部分 UI控件扩展")
        
        
        
        self.inStoryboardVCArray = [
            
            "SHRxswift_1ViewController",
            "SHRxswift_4ViewController",
            "SHRxswift_5ViewController",
            "SHRxswift_6ViewController",
            "SHRxswift_7ViewController",
            "SHRxswift_8ViewController",
            "SHRxswift_10ViewController",
            "SHRxswift_11ViewController",
            "SHRxswift_12ViewController",
            "SHRxswift_15ViewController",
            "SHRxswift_17ViewController",
            "SHRxswift_43ViewController",
            "SHRxswift_45ViewController",
            "SHRxswift_47ViewController",
            "SHRxswift_48ViewController",
            "SHRxswift_54ViewController",
            "SHRxswift_55ViewController",
            "SHRxswift_58ViewController",
            "SHRxswift_59ViewController",
        ]
        
        
        
    }
    
}
