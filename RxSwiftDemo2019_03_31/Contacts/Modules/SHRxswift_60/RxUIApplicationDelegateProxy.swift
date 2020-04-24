//
//  RxUIApplicationDelegateProxy.swift
//  RxSwiftDemo2019_03_31
//
//  Created by 远平 on 2019/11/24.
//  Copyright © 2019 远平. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

public class RxUIApplicationDelegateProxy:
    DelegateProxy<UIApplication, UIApplicationDelegate>,
    UIApplicationDelegate, DelegateProxyType {
    
    public weak private(set) var application: UIApplication?
    
    init(application: ParentObject) {
        
        self.application = application
        super.init(parentObject: application, delegateProxy: RxUIApplicationDelegateProxy.self)
    }
    
    public static func registerKnownImplementations() {
        self.register{ RxUIApplicationDelegateProxy(application: $0) }
    }
    
    public static func currentDelegate(for object: UIApplication) -> UIApplicationDelegate? {
        return object.delegate
    }
    
    public static func setCurrentDelegate(_ delegate: UIApplicationDelegate?, to object: UIApplication) {
        
        object.delegate = delegate
    }
    
    public override func setForwardToDelegate(_ delegate: UIApplicationDelegate?, retainDelegate: Bool) {
        
        super.setForwardToDelegate(delegate, retainDelegate: true)
    }
    
}


