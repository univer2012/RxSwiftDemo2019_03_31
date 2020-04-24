//
//  SHRxswift_58ViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by 远平 on 2019/11/12.
//  Copyright © 2019 远平. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SHRxswift_58ViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    @IBOutlet weak private var button: UIButton!
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //获取地理定位服务
        let geolocationService = GeolocationService.instance
        
        //定位权限绑定到按钮上（是否可见）
        geolocationService.authorized
            .drive(button.rx.isHidden)
            .disposed(by: disposeBag)
        
        //经纬度信息绑定到label上显示
        geolocationService.location
            .drive(label.rx.coordinates)
            .disposed(by: disposeBag)
        
        //按钮点击
        button.rx.tap
            .bind { [weak self](_) -> Void in
                self?.openAppPreferences()
            }
            .disposed(by: disposeBag)
        
        
    }
    
    //跳转到应有偏好的设置页面
    private func openAppPreferences() {
        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
    }
    
}
