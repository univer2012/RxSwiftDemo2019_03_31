//
//  SHRxswift_17NewViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by Mac on 2020/4/19.
//  Copyright © 2020 远平. All rights reserved.
//
/*
* 来自：[Swift - RxSwift的使用详解17（特征序列1：Single、Completable、Maybe）](https://www.hangge.com/blog/cache/detail_1939.html)
*/
import UIKit
import RxSwift
import RxCocoa

class SHRxswift_17NewViewController: SHBaseTableViewController {

    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.actionType = .method
        //section 1
        var tempTitleArray = [
            "2.使用如下方式使用这个 Single",
            "3.也可以使用 subscribe(onSuccess:onError:) 这种方式",
            "5.asSingle()",
        ]
        var tempClassNameArray = [
            "demo1",
            "demo2",
            "demo5",
            "demo6",
        ]
        self.p_addSectionData(with: tempClassNameArray, titleArray: tempTitleArray, title: "一、Single ")
        
        //section 2
        tempTitleArray = [
            "2.使用如下方式使用这个 Completable",
            "3.也可以使用 subscribe(onCompleted:onError:)",
        ]
        tempClassNameArray = [
            "sec2demo2",
            "sec2demo3",
        ]
        self.p_addSectionData(with: tempClassNameArray, titleArray: tempTitleArray, title: "二、Completable")
        
        //section 3
        tempTitleArray = [
            "2.可以使用如下方式使用这个 Maybe",
            "3.也可以使用 subscribe(onSuccess:onCompleted:onError:)",
            "5.asMaybe() \n可以通过调用 Observable 序列的 .asMaybe() 方法，将它转换为 Maybe。",
        ]
        tempClassNameArray = [
            "sec3demo2",
            "sec3demo3",
            "sec3demo5",
        ]
        self.p_addSectionData(with: tempClassNameArray, titleArray: tempTitleArray, title: "三、Maybe")
    }
    
    //MARK: 5.asMaybe()
    //### 5，asMaybe()
    ///我们可以通过调用 Observable 序列的 .asMaybe() 方法，将它转换为 Maybe。
    @objc func sec3demo5() {
        Observable.of("1")
            .asMaybe()
            .subscribe({ print($0) })
            .disposed(by: disposeBag)
    }
    
    //MARK: 3.也可以使用 subscribe(onSuccess:onCompleted:onError:)
    //（3）也可以使用 subscribe(onSuccess:onCompleted:onError:) 这种方式：
    @objc func sec3demo3() {
        generateString()
            .subscribe(onSuccess: { (element) in
                print("执行完毕，并获得元素：\(element)")
            }, onError: { (error) in
                print("执行失败： \(error.localizedDescription)")
            }, onCompleted: {
                print("执行完毕，且没有任何元素")
            })
            .disposed(by: disposeBag)
    }
    
    //MARK: 2.可以使用如下方式使用这个 Maybe
    //（2）接着我们可以使用如下方式使用这个 Maybe：
    @objc func sec3demo2() {
        generateString()
            .subscribe { (maybe) in
                switch maybe {
                case .success(let element):
                    print("执行完毕，并获得元素：\(element)")
                case .completed:
                    print("执行完毕，且没有任何元素")
                case .error(let error):
                    print("执行失败： \(error.localizedDescription)")
                }
            }.disposed(by: disposeBag)
    }
    
    //MARK:三、Maybe
    /*
     # 三、Maybe
     ### 1，基本介绍
     Maybe 同样是 Observable 的另外一个版本。它介于 Single 和 Completable 之间，它要么只能发出一个元素，要么产生一个 completed 事件，要么产生一个 error 事件。
     
     1. 发出一个元素、或者一个 completed 事件、或者一个 error 事件
     2. 不会共享状态变化
     
     ### 2，应用场景
     Maybe 适合那种可能需要发出一个元素，又可能不需要发出的情况。
     
     ### 3，MaybeEvent
     为方便使用，RxSwift 为 Maybe 订阅提供了一个枚举（MaybeEvent）：

     1. .success：里包含该 Maybe 的一个元素值
     2. .completed：用于产生完成事件
     3. .error：用于产生一个错误

     ### 4，使用样例
     （1）创建 Maybe 和创建 Observable 同样非常相似：
     */
    func generateString() -> Maybe<String> {
        return Maybe<String>.create { maybe in
            //成功并发出一个元素
            maybe(.success("hangge.com"))
            
            //成功但不发出任何元素
            maybe(.completed)
            
            //失败
            //maybe(.error(StringError.failedGenerate))
            
            return Disposables.create { }
        }
    }
    
    //与缓存相关的错误类型
    enum StringError: Error {
        case failedGenerate
    }
    
    
    ///（3）也可以使用 subscribe(onCompleted:onError:) 这种方式：
    //MARK: 3.也可以使用 subscribe(onCompleted:onError:)
    @objc func sec2demo3() {
        cacheLocally()
            .subscribe(onCompleted: {
                print("保存成功！")
            }, onError: {error in
                print("保存失败： \(error.localizedDescription)")
            })
            .disposed(by: disposeBag)
    }
    
    ///（2）接着我们可以使用如下方式使用这个 Completable：
    //MARK: 2.使用如下方式使用这个 Completable
    @objc func sec2demo2() {
        cacheLocally().subscribe { (completable) in
            switch completable {
            case .completed:
                print("保存成功！")
            case .error(let error):
                print("保存失败： \(error.localizedDescription)")
            }
        }
        .disposed(by: disposeBag)
    }
    
    //MARK:二、Completable
    /// adj. [数] 可完备化的
    /*
     * ### 1，基本介绍
     * Completable 是 Observable 的另外一个版本。不像 Observable 可以发出多个元素，它要么只能产生一个 completed 事件，要么产生一个 error 事件。
     * 1. 不会发出任何元素
     * 2. 只会发出一个 completed 事件或者一个 error 事件
     * 3. 不会共享状态变化
     *
     * ### 2，应用场景
     * Completable 和 Observable<Void> 有点类似。适用于那些只关心任务是否完成，而不需要在意任务返回值的情况。比如：在程序退出时将一些数据缓存到本地文件，供下次启动时加载。像这种情况我们只关心缓存是否成功。
     *
     * ### 3，CompletableEvent
     *
     *
     * ### 4，使用样例
     */
    
    //将数据缓存到本地
    func cacheLocally() -> Completable {
        return Completable.create { completable in
            //将数据缓存到本地（这里掠过具体的业务代码，随机成功或失败）
            let success = (arc4random() % 2 == 0)
            
            guard success else {
                completable(.error(CacheError.failedCaching))
                return Disposables.create { }
            }
            
            completable(.completed)
            return Disposables.create { }
        }
    }
    
    //与缓存相关的错误类型
    enum CacheError: Error {
        case failedCaching
    }
    
    
    /// ### 5，asSingle()
    //MARK: 5.asSingle()
    ///我们可以通过调用 Observable 序列的 .asSingle() 方法，将它转换为 Single。
    @objc func demo5() {
        Observable.of("1")
            .asSingle()
            .subscribe({ print($0) })
            .disposed(by: disposeBag)
    }
    
    //MARK: 3.也可以使用 subscribe(onSuccess:onError:) 这种方式
    ///（3）也可以使用 subscribe(onSuccess:onError:) 这种方式：
    @objc func demo2() {
        //获取第0个频道的歌曲信息
        getPlaylist("0").subscribe(onSuccess: { (json) in
            print("JSON结果：",json)
        }, onError: { error in
            print("发生错误：",error)
        })
        .disposed(by: disposeBag)
    }
    
    //MARK: 2.使用如下方式使用这个 Single
    ///（2）接着我们可以使用如下方式使用这个 Single：
    @objc func demo1() {
        //获取第0个频道的歌曲信息
        getPlaylist("0").subscribe { (event) in
            switch event {
            case .success(let json):
                print("JSON结果：",json)
            case .error(let error):
                print("发生错误：",error)
            }
        }
        .disposed(by: disposeBag)
    }
    
    //MARK: 一、Single
    /*
     * ### 1，基本介绍
     * Single 是 Observable 的另外一个版本。但它不像 Observable 可以发出多个元素，它要么只能发出一个元素，要么产生一个 error 事件。
     * 1. 发出一个元素，或一个 error 事件
     * 2. 不会共享状态变化
     
     * ### 2，应用场景
     * Single 比较常见的例子就是执行 HTTP 请求，然后返回一个应答或错误。不过我们也可以用 Single 来描述任何只有一个元素的序列。
     *
     
     * 3，SingleEvent
     * ...
     *
     * ### 4，使用样例
     * single  adj. 单一的；单身的；单程的
     */
    ///创建 Single 和创建 Observable 非常相似。下面代码我们定义一个用于生成网络请求 Single 的函数：
    
    //获取豆瓣某频道下的歌曲信息
    func getPlaylist(_ channel: String) -> Single<[String: Any]> {
        return Single<[String: Any]>.create { single in
            let url = "https://douban.fm/j/mine/playlist?"
                + "type=n&channel=\(channel)&from=mainsite"
            let task = URLSession.shared.dataTask(with: URL(string: url)!) { data, _, error in
                if let error = error {
                    single(.error(error))
                    return
                }
                 
                guard let data = data,
                    let json = try? JSONSerialization.jsonObject(with: data,
                                                                 options: .mutableLeaves),
                    let result = json as? [String: Any] else {
                        single(.error(DataError.cantParseJSON))
                        return
                }
                 
                single(.success(result))
            }
             
            task.resume()
             
            return Disposables.create { task.cancel() }
        }
    }
    
    //与数据相关的错误类型
    enum DataError:Error {
        case cantParseJSON
    }

}
