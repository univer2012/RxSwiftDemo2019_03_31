//
//  UILabelExtension.swift
//  RxSwiftDemo2019_03_31
//
//  Created by Mac on 2019/11/7.
//  Copyright © 2019 远平. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

import CoreLocation

extension Reactive where Base: UILabel {
    //让验证结果（ValidationResult类型）可以绑定到label上
    var validateionResult: Binder<ValidationResult> {
        return Binder(base) {label, result in
            label.textColor = result.textColor
            label.text = result.description
        }
    }
}

//UILabel的Rx扩展

extension Reactive where Base: UILabel {
    var coordinates: Binder<CLLocationCoordinate2D> {
        return Binder(base) {label, location in
            label.text = "经度: \(location.longitude)\n纬度: \(location.latitude)"
        }
    }
}
