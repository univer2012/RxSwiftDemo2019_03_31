//
//  SHRxswift_50ViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by Mac on 2019/11/6.
//  Copyright © 2019 远平. All rights reserved.
//
/**
 * 来自：[Swift - RxSwift的使用详解50（结合Moya使用2：结果处理、模型转换）](https://www.jianshu.com/p/173915b943af)
 */
import UIKit
import RxSwift
import RxCocoa



class SHRxswift_50ViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    //显示频道列表的tableView
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //创建表视图
        self.tableView = UITableView(frame: self.view.frame, style: .plain)
        //创建一个重用的单元格
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(self.tableView)

        //豆瓣网络请求服务
        let networkService = DouBanNetworkService()
        
        //获取列表数据
        let data = networkService.loadChannels()

        //将数据绑定到表格
        data.bind(to: tableView.rx.items){ (tableView, row, element) in

            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
            cell.textLabel?.text = "\(element.name!)"
            cell.accessoryType = .disclosureIndicator
            return cell

        }.disposed(by: disposeBag)

        //单元格点击
        //接口需要在vpn翻墙才能访问
        tableView.rx.modelSelected(Channel.self)
            .map{ $0.channelId! }
            .flatMap( networkService.loadFirstSong )
            .subscribe(onNext: {[weak self] (song:Song) in
                //将歌曲信息弹出显示
                let message = "歌手：\(song.artist!)\n歌曲：\(song.title!)"
                self?.showAlert(title: "歌曲信息", message: message)
            
            },onError: {error in
                print("报错，原因是：",error.localizedDescription)
            }).disposed(by: disposeBag)
        
    }
    
    //显示消息
    func showAlert(title:String, message:String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }

}





//MARK: 使用Model
#if false
class SHRxswift_50ViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    //显示频道列表的tableView
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //创建表视图
        self.tableView = UITableView(frame: self.view.frame, style: .plain)
        //创建一个重用的单元格
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(self.tableView)

        //获取列表数据
        let data = DouBanProvider.rx.request(.channels)
            .mapObject(Douban.self)
            .map{ $0.channels ?? [] }
            .asObservable()

        //将数据绑定到表格
        data.bind(to: tableView.rx.items){ (tableView, row, element) in

            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
            cell.textLabel?.text = "\(element.name!)"
            cell.accessoryType = .disclosureIndicator
            return cell

        }.disposed(by: disposeBag)

        //单元格点击
        //接口需要在vpn翻墙才能访问
        tableView.rx.modelSelected(Channel.self)
            .map{ $0.channelId! }
            .flatMap{ DouBanProvider.rx.request(.playlist($0)) }
            .mapObject(type: Playlist.self)
            .subscribe(onNext: {[weak self] (playlist) in
                //解析数据，获取歌曲信息
                if playlist.song.count > 0 {
                    let artist = playlist.song[0].artist!
                    let title = playlist.song[0].title!
                    let message = "歌手：\(artist)\n歌曲：\(title)"
                    //将歌曲信息弹出显示
                    self?.showAlert(title: "歌曲信息", message: message)
                }
            },onError: {error in
                print("报错，原因是：",error.localizedDescription)
            }).disposed(by: disposeBag)
        
    }
    
    //显示消息
    func showAlert(title:String, message:String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }

}
#endif


////获取数据
//DouBanProvider.rx.request(.channels)
//    .mapObject(Douban.self)
//    .subscribe(onSuccess: { (douban) in
//
//        if let channels = douban.channels {
//            print("--- 共\(channels.count)个频道 ---")
//            for channel in channels {
//                if let name = channel.name, let channelId = channel.channelId {
//                    print("\(name) (id:\(channelId))")
//                }
//            }
//        }
//}) { (error) in
//    print("数据请求失败！错误原因：",error)
//}.disposed(by: disposeBag)










//MARK: 处理字典的例子
#if false
class SHRxswift_50ViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    //显示频道列表的tableView
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //创建表视图
        self.tableView = UITableView(frame: self.view.frame, style: .plain)
        //创建一个重用的单元格
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(self.tableView)
        
        //获取列表数据
        let data = DouBanProvider.rx.request(.channels).mapJSON().map { (data) -> [[String: Any]] in
            if let json = data as? [String: Any], let channels = json["channels"] as? [[String: Any]] {
                return channels
            } else {
                return []
            }
        }.asObservable()
        
        //将数据绑定到表格
        data.bind(to: tableView.rx.items){ (tableView, row, element) in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
            cell.textLabel?.text = "\(element["name"]!)"
            cell.accessoryType = .disclosureIndicator
            return cell
            
        }.disposed(by: disposeBag)
        
        //单元格点击
        //接口需要在vpn翻墙才能访问
        tableView.rx.modelSelected([String: Any].self)
            .map{ $0["channel_id"] as! String }
            .flatMap{ DouBanProvider.rx.request(.playlist($0)) }
            .mapJSON()
            .subscribe(onNext: {[weak self] (data) in
                //解析数据，获取歌曲信息
                if let json = data as? [String: Any],
                    let musics = json["song"] as? [[String: Any]] {
                    
                    let artist = musics[0]["artist"]!
                    let title = musics[0]["title"]!
                    let message = "歌手：\(artist)\n歌曲：\(title)"
                    //将歌曲信息弹出显示
                    self?.showAlert(title: "歌曲信息", message: message)
                }
            }).disposed(by: disposeBag)
        
    }
    
    //显示消息
    func showAlert(title:String, message:String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }

}
#endif


////获取数据
//DouBanProvider.rx.request(.channels).mapJSON().subscribe(onSuccess: { (data) in
//    //数据处理
//    let json = data as! [String: Any]
//    print("--- 请求成功！返回的如下数据 ---")
//    print(json)
//}) { (error) in
//    print("数据请求失败！错误原因：",error)
//}.disposed(by: disposeBag)



////获取数据
//DouBanProvider.rx.request(.channels).subscribe(onSuccess: { (response) in
//    //数据处理
//    let json = try? response.mapJSON() as! [String: Any]
//    print("--- 请求成功！返回的如下数据 ---")
//    print(json!)
//}) { (error) in
//    print("数据请求失败！错误原因：",error)
//}.disposed(by: disposeBag)
