//
//  SHImageLoadToolViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by blue on 2020/9/24.
//  Copyright © 2020 远平. All rights reserved.
//
/*
 
  1 缓存
  2 bitmap （提前在子线程把这个操作做完， 系统默认会在主线程上操作）
  3 异常情况 （1 取消任务，执行另外一个任务， 2 去重【两个UIImageView加载同一个图片】）
 
 脉络
 
 */

/*
 1 线程取消  (cancel,自己埋取消节点)
 2 取消条件 （image.url != operation.url）
 
*/

/*
 图片已经在本地了（缓存了）
 图片还没有下载（第一次加载的时候）   去 重复的网络任务
 */

/*
 业务范畴
 
 url没变，图片变了，怎么处理？
 
 */

import UIKit

class SHImageLoadToolViewController: UIViewController {

    let imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.frame = CGRect.init(origin: CGPoint.init(x: 20, y: 80), size: CGSize.init(width: 200, height: 300))
        self.view.addSubview(imageView)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        imageView.loadImageWithURL(url: "http://img.hb.aicdn.com/0f608994c82c2efce030741f233b29b9ba243db81ddac-RSdX35_fw658")
        
    }
}
