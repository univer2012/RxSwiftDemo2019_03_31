//
//  SHRxswift_12ViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by rrd on 2019/7/8.
//  Copyright © 2019 远平. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa
import RxDataSources

class SHRxswift_12ViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //初始化数据
        let sections = Observable.just([
            MySection(header: "我是第一个分区", items: [
                .TitleImageSectionItem(title: "图片数据1", image: UIImage(named: "error")!),
                .TitleImageSectionItem(title: "图片数据2", image: UIImage(named: "success")!),
                .TitleSwitchSectionItem(title: "开关数据1", enabled: true)
                ]),
            MySection(header: "我是第二个分区", items: [
                .TitleSwitchSectionItem(title: "开关数据2", enabled: false),
                .TitleSwitchSectionItem(title: "开关数据3", enabled: false),
                .TitleImageSectionItem(title: "图片数据3", image: UIImage(named: "success")!)
                ]),
            ])
        
        //创建数据源
        let dataSource = RxTableViewSectionedReloadDataSource<MySection>(configureCell: { (dataSource, tableView, indexPath, item) -> UITableViewCell in
            switch dataSource[indexPath] {
            case .TitleImageSectionItem(let title, let image):
                let cell = tableView.dequeueReusableCell(withIdentifier: "titleImageCell", for: indexPath)
                (cell.viewWithTag(1) as! UILabel).text = title
                (cell.viewWithTag(2) as! UIImageView).image = image
                return cell
            case .TitleSwitchSectionItem(let title, let enabled):
                let cell = tableView.dequeueReusableCell(withIdentifier: "titleSwitchCell", for: indexPath)
                (cell.viewWithTag(1) as! UILabel).text = title
                (cell.viewWithTag(2) as! UISwitch).isOn = enabled
                return cell
            }
        },
        //设置分区头标题
        titleForHeaderInSection: { (ds, index) -> String? in
            return ds.sectionModels[index].header
        })
        
        //绑定单元格数据
        sections.bind(to: tableView.rx.items(dataSource: dataSource))
        .disposed(by: disposeBag)
        
        
    }
}

enum SectionItem {
    case TitleImageSectionItem(title: String, image: UIImage)
    case TitleSwitchSectionItem(title: String, enabled: Bool)
}

fileprivate struct MySection {
    var header: String
    var items:[SectionItem]
}
extension MySection : SectionModelType {
    typealias Item = SectionItem
    
    init(original: MySection, items: [MySection.Item]) {
        self = original
        self.items = items
    }
}
