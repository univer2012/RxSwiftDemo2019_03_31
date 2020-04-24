//
//  UIapplication+Rx.swift
//  RxSwiftDemo2019_03_31
//
//  Created by 远平 on 2019/11/24.
//  Copyright © 2019 远平. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

public enum AppState {
    case active
    case inactive
    case background
    case terminated
}

//扩展
extension UIApplication.State {
    func toAppState() -> AppState {
        switch self {
        case .active:
            return .active
        case .inactive:
            return .inactive
        case .background:
            return .background
        default:
            return .terminated
        }
    }
}

extension Reactive where Base: UIApplication {
    
    //代理委托
    var delegate: DelegateProxy<UIApplication, UIApplicationDelegate> {
        return RxUIApplicationDelegateProxy.proxy(for: base)
    }
    
    //应用重新回到活动状态
    var didBecomActive: Observable<AppState> {
        return delegate.methodInvoked(#selector(UIApplicationDelegate.applicationDidBecomeActive(_:)))
            .map{ _ in return .active}
    }
    
    //应用从活动状态进入非活动状态
    var willResignActive: Observable<AppState> {
        return delegate.methodInvoked(#selector(UIApplicationDelegate.applicationWillResignActive(_:)))
            .map{ _ in return .inactive}
    }
    
    //应用从后台恢复至前台（还不是活动状态）
    var willEnterForeground: Observable<AppState> {
        return delegate.methodInvoked(#selector(UIApplicationDelegate.applicationWillEnterForeground(_:)))
            .map{ _ in return .inactive }
    }
    
    //应用进入到后台
    var didEnterBackground: Observable<AppState> {
        return delegate.methodInvoked(#selector(UIApplicationDelegate.applicationDidEnterBackground(_:)))
            .map{ _ in return .background }
    }
    
    //应用终止
    var willTerminate: Observable<AppState> {
        return delegate.methodInvoked(#selector(UIApplicationDelegate.applicationWillTerminate(_:)))
            .map{ _ in return .terminated }
    }
    
    var state: Observable<AppState> {
        return Observable.of(
            didBecomActive,
            willResignActive,
            willEnterForeground,
            didEnterBackground,
            willTerminate
        )
        .merge()
            .startWith(base.applicationState.toAppState())  //为了让开始订阅是就能获取到当前状态
    }
}
