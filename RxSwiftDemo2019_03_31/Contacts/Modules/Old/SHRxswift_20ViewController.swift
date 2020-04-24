//
//  SHRxswift_20ViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by Mac on 2019/7/22.
//  Copyright © 2019 远平. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

import Moya

class SHRxswift_20ViewController: UIViewController {
    let disposeBag = DisposeBag()
    var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //创建表视图
        self.tableView = UITableView(frame: self.view.frame, style: .plain)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(tableView)
        
        //获取列表数据
        #if false
        let data = DouBanProvider.rx.request(.channels)
            .mapObject(Douban.self)
            .map { $0.channels ?? [] }
            .asObservable()
        #else
        //豆瓣网络请求服务
        let service = DouBanNetworkService()
        //获取列表数据
        let data = service.loadChannels()
        #endif
        //将数据绑定到表格
        data.bind(to: tableView.rx.items) {(tableView, row, element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
            cell.textLabel?.text = "\(element.name!)"
            cell.accessoryType = .disclosureIndicator
            return cell
        }.disposed(by: disposeBag)

        //单元格点击
        //接口需要在vpn翻墙才能访问，接口数据也变了。
        #if false
        tableView.rx.modelSelected(Channel.self)
            .map{ $0.channelId! }
            .flatMap { DouBanProvider.rx.request(.playlist($0)) }
            .mapObject(Playlist.self)
            .subscribe(onNext: { [weak self] (playlist) in
                //解析数据，获取歌曲信息
                if playlist.song.count > 0 {
                    let artist = playlist.song[0].singers[0].name!
                    let title = playlist.song[0].title!
                    let message = "歌手：\(artist)\n歌曲：\(title)"
                    //将歌曲信息弹出显示
                    self?.showAlert(title: "歌曲信息", message: message)
                }
            }).disposed(by: disposeBag)
        #else
        tableView.rx.modelSelected(Channel.self)
            .map { $0.channelId! }
            .flatMap(service.loadFirstSong)
            .subscribe(onNext: {[weak self] song in
                let message = "歌手：\(song.singers[0].name!)\n歌曲：\(song.title!)"
                //将歌曲信息弹出显示
                self?.showAlert(title: "歌曲信息", message: message)
            })
            .disposed(by: disposeBag)

        #endif
    }
    
    func showAlert(title:String, message:String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
