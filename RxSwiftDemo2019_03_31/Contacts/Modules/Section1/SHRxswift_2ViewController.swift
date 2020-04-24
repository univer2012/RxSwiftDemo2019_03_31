//
//  SHRxswift_2ViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by rrd on 2019/6/17.
//  Copyright © 2019 远平. All rights reserved.
//
/*
 * 来自：[Swift - RxSwift的使用详解2（响应式编程与传统式编程的比较样例）](https://www.hangge.com/blog/cache/detail_1918.html)
 
 * Convertible [kənˈvɜːtəbl] adj. 可改变的；同意义的；可交换的
 */
import UIKit



class SHRxswift_2ViewController: SHBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //section 1
        let tempTitleArray = [
            "1.传统式编程",
            "2.响应式编程",
        ]
        let tempClassNameArray = [
        "SHRxswift_2d1ViewController",
        "SHRxswift_2d2ViewController",
        ]
        
        self.p_addSectionData(with: tempClassNameArray, titleArray: tempTitleArray, title: "第1部分")
    }
}




//MARK: ============================= demo
//歌曲结构体
struct Music {
    let name: String        //歌名
    let singer: String      //演唱者
    init(name: String, singer: String) {
        self.name = name
        self.singer = singer
    }
}

//实现 CustomStringConvertible 协议，方便输出调试
extension Music: CustomStringConvertible {
    var description: String {
        return "name: \(name) singer: \(singer)"
    }
}


//3，过去我们会这么做（传统式编程）
//MARK: 1.传统式编程
struct MusicListViewModel {
    let data = [
    Music(name: "无条件", singer: "陈奕迅"),
    Music(name: "你曾是少年", singer: "S.H.E."),
    Music(name: "从前的我", singer: "陈洁仪"),
    Music(name: "在木星", singer: "朴树"),]
}


class SHRxswift_2d1ViewController: UIViewController {
    //tableView对象
    var tableView: UITableView!
    
    //歌曲列表数据源
    let musicListViewModel = MusicListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //初始化tableView的数据
        self.tableView = UITableView(frame: self.view.frame, style: .plain)
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "musicCell")
        self.view.addSubview(self.tableView!)
        
        tableView.dataSource = self
        tableView.delegate = self

    }
}
extension SHRxswift_2d1ViewController: UITableViewDataSource {
    //返回单元格数量
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicListViewModel.data.count
    }
    
    //返回对应的单元格
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "musicCell")!
        let music = musicListViewModel.data[indexPath.row]
        cell.textLabel?.text = music.name
        cell.detailTextLabel?.text = music.singer
        return cell
    }
}

extension SHRxswift_2d1ViewController: UITableViewDelegate {
    //单元格点击
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("你选中的歌曲信息【\(musicListViewModel.data[indexPath.row])】")
    }
}



//MARK: 2.响应式编程
//4，现在使用 RxSwift 进行改造（响应式编程）
import RxSwift
import RxCocoa

struct MusicListViewModel2 {
    let data =  Observable.just([
        Music(name: "无条件", singer: "陈奕迅"),
        Music(name: "你曾是少年", singer: "S.H.E."),
        Music(name: "从前的我", singer: "陈洁仪"),
        Music(name: "在木星", singer: "朴树"),
        ])
}

class SHRxswift_2d2ViewController: UIViewController {
    //tableView对象
    var tableView: UITableView!
    
    //歌曲列表数据源
    let musicListViewModel = MusicListViewModel2()
    
    //负责对象销毁
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //初始化tableView的数据
        self.tableView = UITableView(frame: self.view.frame, style: .plain)
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "musicCell")
        self.view.addSubview(self.tableView!)
        
        //将数据源数据绑定到tableView上
        musicListViewModel.data.bind(to: tableView.rx.items(cellIdentifier:"musicCell")) {_, music,cell in
            cell.textLabel?.text = music.name
            cell.detailTextLabel?.text = music.singer
        }.disposed(by: disposeBag)
        
        //tableView点击响应
        tableView.rx.modelSelected(Music.self).subscribe(onNext:{music in
            print("你选中的歌曲信息【\(music)】")
        }).disposed(by: disposeBag)
    }
}




