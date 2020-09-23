//
//  SHKVOPrivatePerson.swift
//  RxSwiftDemo2019_03_31
//
//  Created by blue on 2020/6/17.
//  Copyright © 2020 远平. All rights reserved.
//

import UIKit

@objc enum StockCenterViewControllerType: Int {
    case FOLLOWED = 0
    case HK
    case US
    case IPO
    case ETF
    case Fund
}

class SHKVOPrivatePerson: NSObject {
    
    var customView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))

    @objc dynamic var stockSelectedType: StockCenterViewControllerType = .FOLLOWED {
        didSet {
            print("set stockSelectedType=\(stockSelectedType)")
        }
    }
    
    fileprivate lazy var topTabBarselIndex: Int = 3
    
    fileprivate var selectedIndex: Int {
        return topTabBarselIndex
    }
    
    func logType() {
        print("stockSelectedType=",stockSelectedType)
    }
    
    func logSelectIndex() {
        print("selectedIndex=\(selectedIndex)")
    }
}
