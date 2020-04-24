//
//  SHRxswift_18NewViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by Mac on 2020/4/19.
//  Copyright © 2020 远平. All rights reserved.
//
/*
* 来自：[Swift - RxSwift的使用详解18（特征序列2：Driver） ](https://www.hangge.com/blog/cache/detail_1942.html)
*/
import UIKit
import RxSwift
import RxCocoa

class SHRxswift_18NewViewController: SHBaseTableViewController {

    let disposeBag = DisposeBag()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //section 1
        let tempTitleArray = [
            "1.初学者使用 Observable 序列加 bindTo 绑定来实现这个功能的话，可能会这么写",
            "2.把上面几个问题修改后的代码是这样的",
            "3.如果我们使用 Driver 来实现的话就简单了",
        ]
        let tempClassNameArray = [
            "SHRxswift_18New1ViewController",
            "SHRxswift_18New2ViewController",
            "SHRxswift_18New3ViewController",
        ]
        self.p_addSectionData(with: tempClassNameArray, titleArray: tempTitleArray, title: "四、Driver")
    }
    
    
    
    
}

class SHRxswift_18New3ViewController: SHRxswift_18NewBaseViewController {
    
    override func viewDidLoad() {
        self.type = 3
        super.viewDidLoad()
    }
}

class SHRxswift_18New2ViewController: SHRxswift_18NewBaseViewController {
    
    override func viewDidLoad() {
        self.type = 2
        super.viewDidLoad()
    }
}

class SHRxswift_18New1ViewController: SHRxswift_18NewBaseViewController {
    
    override func viewDidLoad() {
        self.type = 1
        super.viewDidLoad()
    }
}


class SHRxswift_18NewBaseViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    var type: Int = 1   //第x个demo
    
    lazy var query: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.placeholder = "搜索"
        view.addSubview(tf)
        return tf
    }()
    
    lazy var resultCount: UILabel = {
        let lab = UILabel()
        lab.textColor = .black
        lab.backgroundColor = .lightGray
        view.addSubview(lab)
        return lab
    }()
    
    lazy var resultsTableView: UITableView = {
        //初始化tableView的数据
        let tableV = UITableView(frame: CGRect.zero, style: .plain)
        tableV.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(tableV)
        return tableV
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.query.snp_makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(88)
        }
        self.resultCount.snp_makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.query.snp_bottom)
            make.height.equalTo(40)
        }
        self.resultsTableView.snp_makeConstraints({ (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(self.resultCount.snp_bottom)
        })
        
        switch self.type {
        case 1:
            self.demo1()
        case 2:
            self.demo2()
            break
        case 3:
            self.demo3()
            break
        default:
            break
        }
        
    }
    
    //MARK: 3.如果我们使用 Driver 来实现的话就简单了
    ///（3）而如果我们使用 Driver 来实现的话就简单了，代码如下：
    @objc func demo3() {
        
        let results = query.rx.text.asDriver()
            .throttle(0.3)
            .flatMapLatest { query in //筛选出空值, 拍平序列
                self.fetchAutoCompleteItems(query)          //向服务器请求一组结果
                    .asDriver(onErrorJustReturn: [])       //仅仅提供发生错误时的备选返回值
            }

        //将返回的结果绑定到用于显示结果数量的label上
        results
            .map { "\($0.count)" }
            .drive(resultCount.rx.text) // 这里使用 drive 而不是 bindTo
            .disposed(by: disposeBag)


        //将返回的结果绑定到tableView上
        results.drive(resultsTableView.rx.items(cellIdentifier: "Cell")) {//  同样使用 drive 而不是 bindTo
            (_, result, cell) in
                cell.textLabel?.text = "\(result.name)"
            }
            .disposed(by: disposeBag)

    }
    
    //MARK: 2.把上面几个问题修改后的代码是这样的
    ///（2）把上面几个问题修改后的代码是这样的：
    @objc func demo2() {
        let results = query.rx.text
            .throttle(0.3, scheduler: MainScheduler.instance) //在主线程中操作，0.3秒内值若多次改变，取最后一次
            .flatMapLatest { query in //筛选出空值, 拍平序列
                self.fetchAutoCompleteItems(query)          //向服务器请求一组结果
                    .observeOn(MainScheduler.instance)      //将返回结果切换到到主线程上
                    .catchErrorJustReturn([])       //错误被处理了，这样至少不会终止整个序列


            }
            .share(replay: 1)    //HTTP 请求是被共享的

        //将返回的结果绑定到用于显示结果数量的label上
        results
            .map { "\($0.count)" }
            .bind(to: resultCount.rx.text)
            .disposed(by: disposeBag)


        //将返回的结果绑定到tableView上
        results
            .bind(to: resultsTableView.rx.items(cellIdentifier: "Cell")) { (_, result, cell) in
                cell.textLabel?.text = "\(result.name)"
            }
            .disposed(by: disposeBag)
    }
    
    //MARK: 四、Driver
    /*
     ## 四、Driver
     ### 1，基本介绍

     （1）Driver 可以说是最复杂的 trait，它的目标是提供一种简便的方式在 UI 层编写响应式代码。
     （2）如果我们的序列满足如下特征，就可以使用它：

    1. 不会产生 error 事件
    2. 一定在主线程监听（MainScheduler）
    3. 共享状态变化（shareReplayLatestWhileConnected）

     ### 2，为什么要使用 Driver?
     （1）Driver 最常使用的场景应该就是需要用序列来驱动应用程序的情况了，比如：

    * 通过 CoreData 模型驱动 UI
    * 使用一个 UI 元素值（绑定）来驱动另一个 UI 元素值

     （2）与普通的操作系统驱动程序一样，如果出现序列错误，应用程序将停止响应用户输入。
     （3）在主线程上观察到这些元素也是极其重要的，因为 UI 元素和应用程序逻辑通常不是线程安全的。
     （4）此外，使用构建 Driver 的可观察的序列，它是共享状态变化。


     ### 3，使用样例
     （1）初学者使用 Observable 序列加 bindTo 绑定来实现这个功能的话，可能会这么写：
     */
    //MARK: 1.初学者使用 Observable 序列加 bindTo 绑定来实现这个功能的话，可能会这么写
    @objc func demo1() {

        let results = query.rx.text
            .throttle(0.3, scheduler: MainScheduler.instance) //在主线程中操作，0.3秒内值若多次改变，取最后一次
            .flatMapLatest { query in //筛选出空值, 拍平序列
                self.fetchAutoCompleteItems(query) //向服务器请求一组结果
        }
         
        //将返回的结果绑定到用于显示结果数量的label上
        results
            .map { "\($0.count)" }
            .bind(to: resultCount.rx.text)
            .disposed(by: disposeBag)
         
        
        //将返回的结果绑定到tableView上
        results
            .bind(to: resultsTableView.rx.items(cellIdentifier: "Cell")) { (_, result, cell) in
                cell.textLabel?.text = "\(result.name)"
            }
            .disposed(by: disposeBag)
        
    }
    
    func fetchAutoCompleteItems(_ query: String?) -> Single<[Repository]> {
        guard let text = query else {
            return  Single<[Repository]>.create { single in
                return Disposables.create { }
            }
        }
        
        return Single<[Repository]>.create { single in
            let url = "https://api.github.com/search/repositories?q=\(text)"
            let task = URLSession.shared.dataTask(with: URL(string: url)!) { data, _, error in
                if let error = error {
                    single(.error(error))
                    return
                }
                 
                guard let data = data,
                    let json = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves),
                    let result = json as? [String: AnyObject] else {
                        single(.error(DataError.cantParseJSON))
                        return
                }
                 guard let items = result["items"] as? [[String: AnyObject]] else {
                    single(.error( DataError.exampleError("Can't find items") ))
                    return
                 }
                
                var repositories = [Repository]()
                for item in items {
                    guard let name = item["name"] as? String,
                        let url = item["url"] as? String else {
                            
                            single(.error( DataError.exampleError("Can't parse repository") ))
                            return
                    }
                    repositories.append(Repository(name: name, url: url))
                }
                
                single(.success(repositories))
            }
             
            task.resume()
            
            return Disposables.create { task.cancel() }
            
        }
    }
    
    //与数据相关的错误类型
    enum DataError:Error {
        case cantParseJSON
        case exampleError(String)
    }
}


//MARK: model - Repository
/**
 Parsed GitHub repository.
*/
struct Repository: CustomDebugStringConvertible {
    var name: String
    var url: String

    init(name: String, url: String) {
        self.name = name
        self.url = url
    }
}

extension Repository {
    var debugDescription: String {
        return "\(name) | \(url)"
    }
}

