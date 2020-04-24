//
//  SHRxswift_13ViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by rrd on 2019/7/8.
//  Copyright © 2019 远平. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa
import RxDataSources

class SHRxswift_13ViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    var tableView: UITableView!
    
    var dataSourece: RxTableViewSectionedAnimatedDataSource<My1Section>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView = UITableView(frame: self.view.frame, style: .plain)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(self.tableView)
        //初始化数据
        let sections = Observable.just([
            My1Section(header: "基本控件", items: [
                "UILabel的用法",
                "UIText的用法",
                "UIButton的用法",
                ]),
            My1Section(header: "高级控件", items: [
                "UITableView的用法",
                "UICollectionView的用法",
                ]),
            ])
        //创建数据源
        let dataSource = RxTableViewSectionedAnimatedDataSource<My1Section>(
            //设置单元格
            configureCell: { (ds, tv, ip, item) -> UITableViewCell in
            let cell = tv.dequeueReusableCell(withIdentifier: "Cell") ?? UITableViewCell(style: .default, reuseIdentifier: "Cell")
            cell.textLabel?.text = "\(ip.row): \(item)"
            return cell
        },
        //设置分区尾部标题
         titleForFooterInSection:{ds,index in
                return "共有\(ds.sectionModels[index].items.count)个控件"
        })
        
        self.dataSourece = dataSource
        //绑定单元格数据
        sections.bind(to: tableView.rx.items(dataSource: dataSource))
        .disposed(by: disposeBag)
        //设置代理
        tableView.rx.setDelegate(self as UIScrollViewDelegate).disposed(by: disposeBag)
    }
}
//tableView代理实现
extension SHRxswift_13ViewController : UITableViewDelegate {
    //返回分区头部视图
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .black
        let titleLabel = UILabel()
        titleLabel.text = self.dataSourece?[section].header
        titleLabel.textColor = .white
        titleLabel.sizeToFit()
        titleLabel.center = CGPoint(x: self.view.frame.width / 2, y: 20)
        headerView.addSubview(titleLabel)
        return headerView
    }
    //返回分区头部高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}

struct My1Section {
    var header: String
    var items:[Item]
}
extension My1Section : AnimatableSectionModelType {
    typealias Item = String
    
    var identity: String {
        return header
    }
    init(original: My1Section, items: [Item]) {
        self = original
        self.items = items
    }
}

