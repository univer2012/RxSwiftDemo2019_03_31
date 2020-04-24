//
//  SHRxswift_15ViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by rrd on 2019/7/9.
//  Copyright © 2019 远平. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift
import RxDataSources

class SHRxswift_15ViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 100, height: 70)
        
        self.collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: flowLayout)
        self.collectionView.backgroundColor = .white
        self.collectionView.register(SHMyCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        view.addSubview(self.collectionView)
        
        //随机的表格数据
        let randomResult = refreshButton.rx.tap.asObservable()
            .startWith(())  //加这个为了让一开始就能自动请求一次数据
            .flatMapLatest {
                self.getRandomResult().takeUntil(self.cancelButton.rx.tap)
            }
            .share(replay: 1)
        //创建数据源
        let dataSource = RxCollectionViewSectionedReloadDataSource<SectionModel<String, Int>>(configureCell: { (dataSource, collectionView, indexPath, element) -> UICollectionViewCell in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! SHMyCollectionViewCell
            cell.label.text = "\(element)"
            return cell
        })
        //绑定单元格数据
        randomResult.bind(to: collectionView.rx.items(dataSource: dataSource))
        .disposed(by: disposeBag)
    }
    //获取随机数据
    func getRandomResult() -> Observable<[SectionModel<String, Int>]> {
        print("正在请求数据......")
        let items = (0 ..< 5).map { _ in
            Int(arc4random_uniform(100000))
        }
        let observable = Observable.just([SectionModel(model: "S", items: items)])
        return observable.delay(2, scheduler: MainScheduler.instance)
    }
}
