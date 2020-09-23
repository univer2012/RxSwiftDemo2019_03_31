//
//  SHSwiftUsingViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by blue on 2020/6/11.
//  Copyright © 2020 远平. All rights reserved.
//

import UIKit
import LocalAuthentication
import RxSwift

extension URLComponents {
    
    mutating func setQueryItems(with parameters: [String: String]) {
        self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
}

class SHSwiftUsingViewController: SHBaseTableViewController {

    //上一次的touchId data
    private var lastTouchIdData:Data?
    
    lazy var kvoPerson = SHKVOPrivatePerson()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: 验证有没有指纹更新
        if let data = SHSwiftUsingViewController.currentOriTouchIdData() {
            print("data=\(data)")
            if lastTouchIdData != nil {
                if lastTouchIdData == data {
                    print("指纹没有更新")
                } else {
                    print("指纹有更新")
                }
            }
            
            lastTouchIdData = data
        } else {
            print("没有指纹信息")
        }
        
        
        
        

        self.title = "Swift Demo"
        
        self.actionType = .method
        //MARK: ===========section 1
        let tempTitleArray = [
            "1.字符串使用filter方法的理解",
            "2.字符串使用map方法的理解",
            "3.@convention(swift)、@convention(block)、@convention(c)的区别",
            "4.调用imp_implementationWithBlock时使用@convention(block)、@convention(c)",
            "5.URLComponents的使用",
            "6.测试，用KVO去修改私有属性，该属性只有get方法，会不会引起崩溃 -- 答案：会引起崩溃",
            "7.测试，用KVO去修改dynamic属性，该属性是枚举Int类型，会不会引起崩溃 -- 答案：不会崩溃",
            "8.用KVO监听某个属性，当这个属性对象的属性发生变化时，是否会触发这个KVO监听？-- 会崩溃",
        ]
        let tempClassNameArray = [
            "sec1Demo1",
            "sec1Demo2",
            "sec1Demo3",
            "sec1Demo4",
            "sec1Demo5",
            "sec1Demo6",
            "sec1Demo7",
            "sec1Demo8",
        ]
        self.p_addSectionData(with: tempClassNameArray, titleArray: tempTitleArray, title: "Swift的基本使用")
    }
    
    class func currentOriTouchIdData() -> Data?{
        let context = LAContext()
        var error:NSError? = nil;
        if context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            
            return context.evaluatedPolicyDomainState
        }
        //print("errorMsg:" + self.errorMessageForFails(errorCode:(error?.code)! ))
        return nil
    }
    
    //MARK: 8.用KVO监听某个属性，当这个属性对象的属性发生变化时，是否会触发这个KVO监听？-- 会崩溃
    @objc func sec1Demo8() {
        self.kvoPerson.rx.observe(UIView.self, "customView").subscribe(onNext: { (view) in
            print("customView=\(String(describing: view))")
        }).disposed(by: self.disposeBag)
//        self.kvoPerson.rx.observeWeakly(UIView.self, "view").subscribe(onNext: { (view) in
//            print("view=\(String(describing: view))")
//        }).disposed(by: self.disposeBag)
        self.kvoPerson.customView.frame = CGRect(x: 20, y: 30, width: 200, height: 200)
    }
    
    //MARK: 7.测试，用KVO去修改dynamic属性，该属性是枚举Int类型，会不会引起崩溃 -- 答案：不会崩溃
    @objc func sec1Demo7() {
        let person = SHKVOPrivatePerson()
        person.logType()
        person.setValue(4, forKey: "stockSelectedType")
        person.logType()
    }
    
    //MARK: 6.测试，用KVO去修改私有属性，该属性只有get方法，会不会引起崩溃 -- 答案：会引起崩溃
    @objc func sec1Demo6() {
        let person = SHKVOPrivatePerson()
        person.logSelectIndex()
        person.setValue(4, forKey: "selectedIndex")
        person.logSelectIndex()
    }
    
    //MARK: 5.URLComponents的使用
    @objc func sec1Demo5() {
        
        sec1Demo5_1()
        
        sec1Demo5_2()
    }
    
    private func sec1Demo5_2() {
        let queryParams: [String: String] = [
            "search": "obi wan kenobi",
            "format": "wookie"
        ]

        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "swapi.co"
        urlComponents.path = "/api/people"
        urlComponents.setQueryItems(with: queryParams)
        print(urlComponents.url?.absoluteString ?? "")
        // https://swapi.co/api/people?search=obi%20wan%20kenobi&format=wookie
    }
    
    
    private func sec1Demo5_1() {
        let searchTerm = "obi wan kenobi"
        let format = "wookiee"

        /// 使用 URL
        let urlStr = "https://test.com/api/test/?search=\(searchTerm)&format=\(format)"
        let url = URL(string: urlStr)
        print("url=\(urlStr)")
        
        
        /// 使用URLComponents
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "swapi.co"
        urlComponents.path = "/api/people"
        urlComponents.queryItems = [
           URLQueryItem(name: "search", value: searchTerm),
           URLQueryItem(name: "format", value: format)
        ]

        print(urlComponents.url?.absoluteString ?? "")
        // https://swapi.co/api/people?search=obi%20wan%20kenobi&format=wookie
    }
    
    
    //MARK: 4.调用imp_implementationWithBlock时使用@convention(block)、@convention(c)
    //会崩溃，原因待查明。
    //来自：[swift的@convention](https://www.jianshu.com/p/f4dd6397ae86)
    @objc func sec1Demo4() {
        
        class Person:NSObject {
            //数  数字
            @objc dynamic func countNumber(toValue:Int) {
                for value in 0...toValue {
                    print(value)
                }
            }
        }
        //现在我们要替换数数函数的实现，给他之前和之后加上点广告语。

        //拿到method
        let methond: Method? = class_getInstanceMethod(Person.self, #selector(Person.countNumber(toValue:)))
        
        /* id, SEL, ... */
        // public typealias IMP = OpaquePointer
        //通过method拿到imp， imp实际上就是一个函数指针
        let oldImp: IMP = method_getImplementation(methond!)
        
        //由于IMP是函数指针，所以接收时需要指定@convention(c)
        typealias Imp  = @convention(c) (Person, Selector, NSNumber)->Void
        
        //将函数指针强转为兼容函数指针的闭包
        let oldImpBlock = unsafeBitCast(oldImp, to: Imp.self)

        //imp_implementationWithBlock的参数需要的是一个oc的block，所以需要指定convention(block)
        let newFunc: (@convention(block) (Person, NSNumber) -> Void ) = {
            (sself, toValue) in
            print("数之前， 祝大家新年快乐")
            oldImpBlock(sself, #selector(Person.countNumber(toValue:)), toValue)
            print("数之后， 祝大家新年快乐")
        }


        let newImp: IMP = imp_implementationWithBlock(unsafeBitCast(newFunc, to: AnyObject.self))

        
        //设置methond的IMP为newImp
        method_setImplementation(methond!, newImp)

        let person = Person()
        person.countNumber(toValue: 50)
        /** output:
         数之前， 祝大家新年快乐
         0
         1
         2
         ... ...
         ... ...
         49
         50
         数之后， 祝大家新年快乐
         
        */
    }
    
    //MARK: 3.@convention(swift)、@convention(block)、@convention(c)的区别
    /*
     `@convention`是用来修饰闭包的。它后面需要跟一个参数：
     1. `@convention(swift)`  : 表明这个是一个swift的闭包
     2. `@convention(block)` ：表明这个是一个兼容oc的block的闭包
     3. `@convention(c)`   : 表明这个是兼容c的函数指针的闭包。
     */
    @objc func sec1Demo3() {
        class Person:NSObject {

            func doAction(action: @convention(swift) (String)->Void, arg:String){
                action(arg)
            }
        }

        let saySomething_c : @convention(c) (String)->Void = {
            print("i said: \($0)")
        }

        let saySomething_oc : @convention(block) (String)->Void = {
            print("i said: \($0)")
        }

        let saySomething_swift : @convention(swift) (String)->Void = {
            print("i said: \($0)")
        }

        let person = Person()
        person.doAction(action: saySomething_c, arg: "helloworld")
        person.doAction(action: saySomething_oc, arg: "helloworld")
        person.doAction(action: saySomething_swift, arg: "helloworld")
    }
    
    //MARK: 2.字符串使用map方法的理解
    @objc func sec1Demo2() {
        let value : String = "100"
        
        /// 原代码的写法
        let res1 = value.map{ $0 == "1" }
        print("res1=\(res1)")
        
        //等价于：
        let result: [Bool] = value.map { (char: Character) -> Bool in
            return char == "1"
        }
        print("result=\(result)")
    }
    
    //MARK: 1.字符串使用filter方法的理解
    @objc func sec1Demo1() {
        //测试数据
        let value: String = "123" //"100" //"102"
        
        /// 原代码的写法
        if let c = value.filter({ !["0", "1"].contains($0) }).first {
            // 验证是否只包含0 和 1
            print("invalid character:\(c)")
        }
        
        //等价于：
        let result = value.filter { (char: Character) -> Bool in
            return ["0", "1"].contains(char) == false
        }
        if let c = result.first {
            print("invalid character:\(c)")
        }
        /*即：
         过滤掉value包含的”0“和”1“，得到一个新的字符串result，然后判断result中是否有第一个字符，有就进入if语句。
         例如：
         value = "123"，过滤后得到 result = "23"，
         所以 let c = result.first是一个Optional<Character> 类型的 2 。
         */
    }

}
