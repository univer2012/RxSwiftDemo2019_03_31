
//
//  SHRxswift_14ViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by rrd on 2019/7/8.
//  Copyright © 2019 远平. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift
import RxDataSources

#if false //原来的
class SHRxswift_14ViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //定义布局方式以及单元格大小
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 100, height: 70)
        flowLayout.headerReferenceSize = CGSize(width: self.view.frame.width, height: 40)
        
        //创建集合视图
        self.collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: flowLayout)
        self.collectionView.backgroundColor = .white
        self.collectionView.register(SHMyCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        self.collectionView.register(MySectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Section")
        view.addSubview(self.collectionView)
        
        //初始化数据
        let items = Observable.just([
            MySection(header:"脚本语言", items: [
                "Python",
                "javascript",
                "PHP",
                ]),
            MySection(header:"高级语言", items: [
                "Swift",
                "C++",
                "Java",
                "C#"])
            ])
        //创建数据源
        let dataSource = RxCollectionViewSectionedReloadDataSource<MySection>(configureCell: { (dataSource, collectionView, indexPath, element) -> UICollectionViewCell in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! SHMyCollectionViewCell
            cell.label.text = "\(element)"
            return cell
        }, configureSupplementaryView: { (ds, cv, kind, indexPath) in
            let section = cv.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Section", for: indexPath) as! MySectionHeader
            section.label.text = "\(ds[indexPath.section].header)"
            return section
        })
        
        //绑定单元格数据
        items.bind(to: collectionView.rx.items(dataSource: dataSource))
        .disposed(by: disposeBag)
    }
}
#else

class SHRxswift_14ViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //定义布局方式以及单元格大小
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 100, height: 70)
        flowLayout.headerReferenceSize = CGSize(width: self.view.frame.width, height: 40)
        
        //创建集合视图
        self.collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: flowLayout)
        self.collectionView.backgroundColor = .white
        self.collectionView.register(SHMyCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        view.addSubview(self.collectionView)
        
        //初始化数据
        let items = Observable.just([
            SectionModel(model: "", items: [
                "Swift",
                "PHP",
                "Python",
                "Java",
                "C++",
                "C#",
                ])
            ])
        //创建数据源
        let dataSource = RxCollectionViewSectionedReloadDataSource<SectionModel<String, String>>(configureCell: { (dataSource, collectionView, indexPath, element) -> UICollectionViewCell in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! SHMyCollectionViewCell
            cell.label.text = "\(element)"
            return cell
        })
        
        //绑定单元格数据
        items.bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        //设置代理
        collectionView.rx.setDelegate(self as UIScrollViewDelegate)
        .disposed(by: disposeBag)
    }
}
//collectionView代理实现
extension SHRxswift_14ViewController: UICollectionViewDelegateFlowLayout {
    //设置单元格尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let cellWidth = (width - 30) / 4
        return CGSize(width: cellWidth, height: cellWidth * 1.5)
    }
}

#endif

fileprivate struct MySection {
    var header: String
    var items: [Item]
}
extension MySection: AnimatableSectionModelType {
    typealias Item = String
    var identity: String {
        return header
    }
    
    init(original: MySection, items: [Item]) {
        self = original
        self.items = items
    }
}


class MySectionHeader: UICollectionReusableView {
    var label: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .black
        
        label = UILabel(frame: frame)
        label.textColor = .white
        label.textAlignment = .center
        self.addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SHMyCollectionViewCell: UICollectionViewCell {
    var label: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.orange
        
        label = UILabel(frame: frame)
        label.textColor = .white
        label.textAlignment = .center
        self.contentView.addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
