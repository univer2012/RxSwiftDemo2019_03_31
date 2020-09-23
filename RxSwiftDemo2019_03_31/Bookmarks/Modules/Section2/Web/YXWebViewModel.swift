//
//  YXWebViewModel.swift
//  RxSwiftDemo2019_03_31
//
//  Created by blue on 2020/9/10.
//  Copyright © 2020 远平. All rights reserved.
//

import RxSwift
import RxCocoa


/// webview url key
let kWebViewModelUrl = "url"

/// webview title key
let kWebViewModelTitle = "webTitle"

/// webview titlebar visible key
let kWebViewModelTitleBarVisible = "webTitleBarVisible"

/// webview cache policy
let kWebViewModelCachePolicy = "webCachePolicy"

//import URLNavigator

class YXWebViewModel: NSObject  {
//    typealias Services = HasYXWebService & HasYXNewsService
    
//    var navigator: NavigatorType!
    
    // hud的信号
//    var hudSubject: PublishSubject<HUDType>! = PublishSubject<HUDType>()
    
//    var services: Services! {
//        didSet {
//            
//        }
//    }
    
    var url: String?
    var webTitle: String?
    var titleBarVisible: Bool = false {
        didSet {
            titleBarVisibleSubject.onNext(titleBarVisible)
        }
    }
    var cachePolicy:URLRequest.CachePolicy = .useProtocolCachePolicy//缓存策略
    
    var titleBarVisibleSubject = PublishSubject<Bool>()

    init(dictionary: Dictionary<String, Any>) {
        if let url = dictionary[kWebViewModelUrl] {
            self.url = url as? String
        }
        
        if let webTitle = dictionary[kWebViewModelTitle] {
            self.webTitle = webTitle as? String
        }
        
        if let titleBarVisible = dictionary[kWebViewModelTitleBarVisible] {
            self.titleBarVisible = titleBarVisible as? Bool ?? true
        } else {
            self.titleBarVisible = true
        }
        
        if let cachePolicy = dictionary[kWebViewModelCachePolicy] {
            self.cachePolicy = cachePolicy as? URLRequest.CachePolicy ?? URLRequest.CachePolicy.useProtocolCachePolicy
        }
    }
    
    weak var sourceVC: UIViewController?
    var loginCallBack: (([String: Any])->Void)?
    convenience init(dictionary: Dictionary<String, Any>, loginCallBack: (([String: Any])->Void)?, sourceVC: UIViewController?) {
        self.init(dictionary: dictionary)
        self.loginCallBack = loginCallBack
        self.sourceVC = sourceVC
    }
}
