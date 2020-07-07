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
