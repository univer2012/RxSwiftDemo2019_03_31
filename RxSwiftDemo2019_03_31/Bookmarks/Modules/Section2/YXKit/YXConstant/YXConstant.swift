//
//  YXConstant.swift
//  RxSwiftDemo2019_03_31
//
//  Created by blue on 2020/9/10.
//  Copyright © 2020 远平. All rights reserved.
//

import UIKit

@objc public enum YXTargetMode : Int {
    case dev    // 开发环境
    case sit    // 系统内部集成测试环境
    case uat    // 用户验收测试环境
    case mock   // 测试Mock环境
    case prd    // 生产环境
    case prd_hk // 生产环境（HK）
}
// 网络环境配置Key值
#if YXZQ_ENV_MODE_SET
let ENV_MODE_MMKV_KEY = "yx_env_mode"
#endif

// 自动填充短信验证码
#if YXZQ_AUTOFILL_CAPTCHA
let AUTOFILL_CAPTCHA_MMKV_KEY = "yx_autofill_captcha"
#endif

public class YXConstant: NSObject {
    @objc public static let sharedAppDelegate = UIApplication.shared.delegate
    
    /// App类型
    @objc public enum YXAppType: Int {
        case CN = 1        // 大陆版
        case HK = 2        // 香港版
    }
    
    /**
     获取当前应用的BundleIdentifier

     @return BundleIdentifier
     */
    @objc public static let bundleId = Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String

    /**
     获取当前应用的名称

     @return 应用的名称
     */
    @objc public static let appName = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String

    /**
     获取当前应用的Build number

     @return Build number
     */
    @objc public static let appBuild = Bundle.main.infoDictionary?["CFBundleVersion"] as? String

    /**
     获取当前应用版本号

     @return 获应用版本号
     */
    @objc public static let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String

    /**
     当前应用的appStore Url

     @return appStore Url
     */
    @objc public static let appStoreUrl = "https://itunes.apple.com/cn/app/id\(YXConstant.appId)?mt=8"

    /**
     当前应用的Review Url

     @return Review Url
     */
    @objc public static let appStoreReviewUrl = "itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=\(YXConstant.appId)&onlyLatestVersion=true&pageNumber=0&sortOrdering=1&type=Purple+Software"
    
    /**
     启动渠道
     e.g. @"友信渠道", @"1313"

     @return 启动渠道
     */
    @objc public static var launchChannel: String?
    
    /**
     来源于AAStock的哪个页面
     e.g. @"00001", @"00002"

     @return AAStock的来源页
     */
    @objc public static var AAStockPageName: String?
    
    
    /**
     来源于AAStock，是否完成过下单交易
      默认为true。如果从AAStock跳转过来，则会设置为false。

     @return 是否完成过下单交易
     */
    @objc public static var finishTradeAAStock: Bool = true
    
    /// 是否是由AAStock启动
    @objc public class func isLaunchedByAAStock() -> Bool {
        return YXConstant.launchChannel == "1313"
    }
    
    /// App版本号 64位
    @objc public static var appVersionValue: UInt64 {
        get {
            guard let array = YXConstant.appVersion?.components(separatedBy: ".") else { return 0 }
            assert(array.count <= 3, "version字符串格式不对")
            var valueString = ""
            (array as NSArray).enumerateObjects({ obj, idx, stop in
                if let str = obj as? String {
                    if str.count < 3 {
                        valueString += String(format: "%03d", Int(str) ?? 0)
                    } else {
                        valueString += str
                    }
                }

            })
            
            return UInt64(valueString) ?? 0

        }
    }
    
    /**
     获取当前appId

     @return appId
     */
    @objc public static var appId: String {
        if YXConstant.appTypeValue == .CN {
            return "1450893002"
        } else {
            return "1329603560"
        }
    }
    
    /// 获取当前AppType, String类型
    @objc public static var appType: String {
        if YXConstant.bundleId?.starts(with: "com.yxzq") ?? true {
            return "\(YXAppType.CN.rawValue)"
        } else {
            return "\(YXAppType.HK.rawValue)"
        }
    }
    
    /// 获取当前AppType, YXAppType类型
    @objc public static var appTypeValue: YXAppType {
        if YXConstant.bundleId?.starts(with: "com.yxzq") ?? true {
            return YXAppType.CN
        } else {
            return YXAppType.HK
        }
    }
    
    @objc public static var logPubKey: String {
        if YXConstant.appTypeValue == .CN {
            return "e56a7bcb1ddcd59d08c6b20c732277150b609df3eaa14f9c7aa6fbc8515a1d57fadc55f379714b1d54c36029b5115ff44b2797a1f450599ba552c772f9f8f64d"
        } else {
            return "546fbb483422c123246593d99df9aa653c3035c53e78de29dcf26c1271f0abf55d6fc46f06b9032b1c639534cf8986a3c36329b74d0a3ae827c3cbd6ae9be1ea"
        }
    }
    
    @objc public static let logPath = "/uSMART_Logs"
}



