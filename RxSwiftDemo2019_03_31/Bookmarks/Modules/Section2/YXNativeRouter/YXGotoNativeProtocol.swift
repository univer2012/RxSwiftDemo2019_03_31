//
//  YXGotoNativeProtocol.swift
//  RxSwiftDemo2019_03_31
//
//  Created by blue on 2020/9/10.
//  Copyright © 2020 远平. All rights reserved.
//

import Foundation

@objc public protocol YXGotoNativeProtocol: AnyObject {
    @objc func gotoNativeViewController(withUrlString urlString : String) -> Bool
}
