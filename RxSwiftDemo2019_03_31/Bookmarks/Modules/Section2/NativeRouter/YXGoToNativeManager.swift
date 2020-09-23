//
//  YXGoToNativeManager.swift
//  RxSwiftDemo2019_03_31
//
//  Created by blue on 2020/9/10.
//  Copyright © 2020 远平. All rights reserved.
//

import UIKit
import Foundation

class YXGoToNativeManager: NSObject, YXGotoNativeProtocol {
    
    @objc static let shared = YXGoToNativeManager()
    
    private override init() {
        
    }
    
    override func copy() -> Any {
        return self
    }
    
    override func mutableCopy() -> Any {
        return self
    }
    
    // Optional
    func reset() -> Void {
        // Reset all properties to default value
    }
    
    /// 依据内部协议，跳转到指定页面
    /// 内部协议参考网站：http://szwiki.youxin.com/pages/viewpage.action?pageId=1116777
    /// - Parameter urlString: urlString: 需要跳转的Url String
    /// - Returns: 是否成功跳转
    @discardableResult
    @objc func gotoNativeViewController(withUrlString urlString : String) -> Bool {
        if urlString.isEmpty {
            return false
        }
        
        let parser = YXNativeUrlParser(urlString)
        
        if let root = UIApplication.shared.delegate as? AppDelegate {
//            guard let navigator = root.navigator else { return false }
            
            switch parser.baseUrl {
            case GOTO_STOCK_QUOTE:
                //FIXME: 测试代码
                if let market = parser.getParam(withKey: "market"),
                    let code = parser.getParam(withKey: "code") {
                    
                    print("跳转到个股行情页面: \n market =\(market)\n code = \(code)")
                }
                
                break
//                if let market = parser.getParam(withKey: "market"),
//                    let code = parser.getParam(withKey: "code") {
//
//                    let name = parser.getParam(withKey: "name")
//                    let context = YXNavigatable(viewModel: YXStockDetailViewModel(market: market, symbol: code, name: name, type1: nil, type2: nil, type3: nil))
//                    navigator.push(YXModulePaths.stockDetail.url, context: context)
//                } else {
//                    log(.warning, tag: kOther, content: "个股详情页error -> market or code is empty")
//                }
//            case GOTO_DEPOSIT:
//                let dic: [String: Any] = [
//                    kWebViewModelUrl : YX_DEPOSIT_URL(market: parser.getParam(withKey: "market"))
//                ]
//                let context = YXNavigatable(viewModel: YXWebViewModel(dictionary: dic))
//                navigator.push(YXModulePaths.webView.url, context: context)
//            case GOTO_WITHDRAWAL:
//                let dic: [String: Any] = [
//                    kWebViewModelUrl: YX_WITHDRAWAL_URL(market: parser.getParam(withKey: "market"))
//                ]
//                let context = YXNavigatable(viewModel: YXWebViewModel(dictionary: dic))
//                navigator.push(YXModulePaths.webView.url, context: context)
//            case GOTO_USER_LOGIN:
//                let context = YXNavigatable(viewModel: YXLoginViewModel(callBack: nil, vc: nil))
//                navigator.push(YXModulePaths.defaultLogin.url, context: context)
//            case GOTO_TRADE_LOGIN:
//                log(.info, tag: kOther, content: "交易登录")
//            case GOTO_MAIN_OPTSTOCKS:
//                NotificationCenter.default.post(name: NSNotification.Name(rawValue: YXUserManager.notiUpdateResetRootView), object: nil, userInfo: ["index" : YXTabIndex.optional])
//            case GOTO_MAIN_HKMARKET://自选--市场--港股
//                let userInfo: [String : Any] = [
//                    "index" : YXTabIndex.optional,
//                    "moduleTag" : 1,
//                    "subModuleTag": 0
//                ]
//                NotificationCenter.default.post(name: NSNotification.Name(rawValue: YXUserManager.notiUpdateResetRootView), object: nil, userInfo: userInfo)
//            case GOTO_MAIN_USMARKET://自选--市场--美股
//                let userInfo: [String : Any] = [
//                    "index" : YXTabIndex.optional,
//                    "moduleTag" : 1,
//                    "subModuleTag": 1
//                ]
//                NotificationCenter.default.post(name: NSNotification.Name(rawValue: YXUserManager.notiUpdateResetRootView), object: nil, userInfo: userInfo)
//            case GOTO_MAIN_HSMARKET://自选--市场--A股
//                let userInfo: [String : Any] = [
//                    "index" : YXTabIndex.optional,
//                    "moduleTag" : 1,
//                    "subModuleTag": 2
//                ]
//                NotificationCenter.default.post(name: NSNotification.Name(rawValue: YXUserManager.notiUpdateResetRootView), object: nil, userInfo: userInfo)
//            case GOTO_MAIN_INFO: //自选--资讯
//                var subModuleTag: Int = 0
//                if let tag = parser.getParam(withKey: "subModuleTag") {
//                    subModuleTag = Int(tag) ?? 0
//                }
//                let userInfo: [String : Any] = [
//                    "index" : YXTabIndex.optional, //自选
//                    "moduleTag" : 2,  //下标2--> 资讯
//                    "subModuleTag": subModuleTag  //资讯里的下标
//                ]
//                NotificationCenter.default.post(name: NSNotification.Name(rawValue: YXUserManager.notiUpdateResetRootView), object: nil, userInfo: userInfo)
//
//            case GOTO_MAIN_INFO_MY_COURSE://行情--资讯--课程--我的课程
//                let userInfo: [String : Any] = [
//                    "index" : YXTabIndex.optional,  //自选
//                    "moduleTag" : 2,                //下标2--> 资讯
//                    "subModuleTag": 4,              //课程
//                    "subSubModuleTag":1,            //我的课程
//                ]
//                NotificationCenter.default.post(name: NSNotification.Name(rawValue: YXUserManager.notiUpdateResetRootView), object: nil, userInfo: userInfo)
//
//
//            case GOTO_MAIN_TRADE:
//                let market = parser.getParam(withKey: "market") ?? YXMarketType.HK.rawValue
//                var userInfo: [String : Any] = [
//                    "index" : YXTabIndex.holding
//                ]
//                if market.caseInsensitiveCompare(YXMarketType.US.rawValue) == .orderedSame {
//                    userInfo["moduleTag"] = 1
//                } else if [YXMarketType.ChinaSH.rawValue, YXMarketType.ChinaSZ.rawValue, YXMarketType.ChinaHS.rawValue]
//                    .contains(where: {$0.caseInsensitiveCompare(market) == .orderedSame})  {
//                    userInfo["moduleTag"] = 2
//                } else {
//                    userInfo["moduleTag"] = 0
//                }
//                NotificationCenter.default.post(name: NSNotification.Name(rawValue: YXUserManager.notiUpdateResetRootView), object: nil, userInfo: userInfo)
//            case GOTO_MAIN_PERSONAL:
//                NotificationCenter.default.post(name: NSNotification.Name(rawValue: YXUserManager.notiUpdateResetRootView), object: nil, userInfo: ["index" : YXTabIndex.userCenter])
//            case GOTO_MAIN_FUND:
//                NotificationCenter.default.post(name: NSNotification.Name(rawValue: YXUserManager.notiUpdateResetRootView), object: nil, userInfo: ["index" : YXTabIndex.fund])
//            case GOTO_OPEN_ACCOUNT:
//                let context = YXNavigatable(viewModel: YXOpenAccountWebViewModel(dictionary: [:]))
//                navigator.push(YXModulePaths.openAccount.url, context: context)
//                YXSensorAnalyticsTrack.track(withEvent: .ViewClick, properties: [YXSensorAnalyticsPropsConstant.PROP_VIEW_PAGE : "h5_detail",
//                                                                                 YXSensorAnalyticsPropsConstant.PROP_VIEW_NAME : "开户"])
//            case GOTO_MESSAGE_CENTER:
//                if YXUserManager.isLogin() {
//                    let dic: [String: Any] = [kWebViewModelUrl : YX_MSG_CENTER_URL()]
//                    let context = YXNavigatable(viewModel: YXWebViewModel(dictionary: dic))
//                    navigator.push(YXModulePaths.webView.url, context: context)
//                } else {
//                    let callback: (([String: Any])->Void)? = { _ in
//                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
//                            let dic: [String: Any] = [kWebViewModelUrl : YX_MSG_CENTER_URL()]
//                            let context = YXNavigatable(viewModel: YXWebViewModel(dictionary: dic))
//                            navigator.push(YXModulePaths.webView.url, context: context)
//                        })
//                    }
//
//                    let context = YXNavigatable(viewModel: YXLoginViewModel(callBack: callback, vc: nil))
//                    navigator.push(YXModulePaths.defaultLogin.url, context: context)
//                }
//            case GOTO_MESSAGE_DETAIL:
//                log(.info, tag: kOther, content: "消息中心- 消息详情")
//            case GOTO_STOCK_TRADE:
//                // 对应大陆版文件：YXGoToNativeManager.swift  搜索GOTO_STOCK_TRADE
//                // 跳转交易下单页面
//                let market = parser.getParam(withKey: "market")
//                let code = parser.getParam(withKey: "code")
//
//
//                // 允许market 和 code 为空“
//                let model = YXTradeOrderModel()
//                if let market = market {
//                    model.market = market
//                }
//
//                if let code = code {
//                    model.symbol = code
//                }
//
//                YXTradeOrderViewModel.getOrderType(withMarket: model.market) { (type) in
//
//                    if let viewModel = YXTradeOrderViewModel(services:nil, params:["tradeModel":model, "tradeType":YXTradeType.normal.rawValue,
//                        "defaultOrderType"  : NSNumber(integerLiteral: type)]) {
//                        YXNavigatorMapExtension.shared.pushToTradeOrderViewController(viewModel: viewModel)
//                    }
//
//                }
//
//
//            case GOTO_WEBVIEW:
//                if let url = parser.getParam(withKey: "url") {
//                    var titleBarVisible: Bool
//
//                    if let visible = parser.getParam(withKey:"titleBarVisible") {
//                        if visible.lowercased() == "false" {
//                            titleBarVisible = false
//                        } else {
//                            titleBarVisible = true
//                        }
//                    } else {
//                        titleBarVisible = true
//                    }
//
//                    var dic: [String: Any] = [
//                        kWebViewModelUrl : url,
//                        kWebViewModelTitleBarVisible : titleBarVisible
//                    ]
//
//                    if let title = parser.getParam(withKey: "title") {
//                        dic[kWebViewModelTitle] = title
//                    }
//
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                        let context = YXNavigatable(viewModel: YXWebViewModel(dictionary: dic))
//                        navigator.push(YXModulePaths.webView.url, context: context)
//                    }
//                } else {
//                    log(.warning, tag: kOther, content: "Native Webview页面 error -> url is empty")
//                }
//            case GOTO_INFO_DETAIL:
//                if let type = parser.getParam(withKey: "type"),
//                    let newsId = parser.getParam(withKey: "newsid") {
//                    if Int(type) == YXInfomationType.Normal.rawValue || Int(type) == YXInfomationType.Recommend.rawValue {
//                        var dictionary: Dictionary<String, Any> = [
//                            "newsId" : newsId,
//                        ]
//
//                        if Int(type) == YXInfomationType.Normal.rawValue {
//                            dictionary["type"] = YXInfomationType.Normal
//                        } else if Int(type) == YXInfomationType.Recommend.rawValue {
//                            dictionary["type"] = YXInfomationType.Recommend
//                        }
//
//                        if let title = parser.getParam(withKey: "title") {
//                            dictionary["title"] = title
//                            dictionary["newsTitle"] = title
//                        }
//
//                        let context = YXNavigatable(viewModel: YXInfoDetailViewModel(dictionary: dictionary))
//
//                        navigator.push(YXModulePaths.infoDetail.url, context: context)
//                    }
//                } else {
//                    log(.warning, tag: kOther, content: "资讯详情页面 error -> type or newsid is empty")
//                }
//            case GOTO_FUND_HISTORY_RECORD:
//                log(.info, tag: kOther, content: "历史记录")
//                var bizType: YXHistoryBizType = .All
//                if let type = parser.getParam(withKey: "type") {
//                    if Int(type) == 1 {
//                        bizType = .Deposit
//                    } else if Int(type) == 2 {
//                        bizType = .Withdraw
//                    } else if Int(type) == 3 {
//                        bizType = .Exchange
//                    } else {
//                        bizType = .All
//                    }
//                }
//                let context = YXNavigatable(viewModel: YXHistoryViewModel(bizType: bizType))
//                navigator.push(YXModulePaths.history.url, context: context)
//            case GOTO_FEEDBACK:
//                navigator.push(YXModulePaths.userCenterFeedback.url)
//            case GOTO_TEL:
//                if let phoneNumber = parser.getParam(withKey: "phoneNumber"),
//                    let url = URL(string: "tel:" + phoneNumber) {
//                    UIApplication.shared.openURL(url)
//                }
//            case GOTO_CUSTOMER_SERVICE:
//                let context = YXNavigatable(viewModel: YXOnlineServiceViewModel(dictionary: [:]))
//                navigator.push(YXModulePaths.onlineService.url, context: context)
//            case GOTO_SMART_MONITOR:
//                let vc = UIViewController.current()
//                if vc.isKind(of: YXSmartViewController.self) {
//                    return false
//                }
//
//                if let type = parser.getParam(withKey: "type"), let intType = Int(type), let smartType = YXSmartType(rawValue: intType) {
//
//                    if YXUserManager.isLogin() {
//                        navigator.push(YXModulePaths.smartWatch.url, context: smartType)
//                    } else {
//                        let callback: (([String: Any])->Void)? = { _ in
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6, execute: {
//                                navigator.push(YXModulePaths.smartWatch.url, context: smartType)
//                            })
//                        }
//
//                        let context = YXNavigatable(viewModel: YXLoginViewModel(callBack: callback, vc: vc))
//                        navigator.push(YXModulePaths.defaultLogin.url, context: context)
//                    }
//                }
//            case GOTO_ORDER_RECORD:
//                var exchangeType: YXExchangeType = .hk
//
//                if let market = parser.getParam(withKey: "market") {
//                    let marketType = YXMarketType.init(rawValue: market.lowercased())
//                    exchangeType = YXToolUtility.getExchangeType(with: marketType ?? YXMarketType.HK)
//                }
//                if YXUserManager.isGray(with: .bond) {
//                    let context = YXNavigatable(viewModel: YXMixOrderListViewModel(securityType: .bond))
//                    navigator.push(YXModulePaths.mixOrderList.url, context: context)
//                }else {
//                    let context = YXNavigatable(viewModel: YXOrderListViewModel(exchangeType: exchangeType))
//                    navigator.push(YXModulePaths.orderList.url, context: context)
//                }
//
//            case GOTO_IPO_CENTER:
//
//                let type = Int(parser.getParam(withKey: "type") ?? "0") ?? 0
//                var market = YXMarketType.HK.rawValue
//                if type == 2 {
//                    market = YXMarketType.US.rawValue
//                }
//                let context: [String : Any] = [
//                    "market" : market
//                ]
//                // 新股中心
//                navigator.push(YXModulePaths.newStockCenter.url, context: context)
//            case GOTO_IPO_DETAIL:
//                // 新股详情页
//                if let market = parser.getParam(withKey: "market"),
//                    let code = parser.getParam(withKey: "code") {
//                    let ipoId: Int64? = Int64(parser.getParam(withKey: "ipoId") ?? "0")
//
//                    let marketType = YXMarketType.init(rawValue: market.lowercased())
//                    let exchangeType = YXToolUtility.getExchangeType(with: marketType ?? YXMarketType.HK).rawValue
//
//                    //                let context: [String : Any] = [
//                    //                    "exchangeType" : exchangeType,
//                    //                    "ipoId" : ipoId ?? 0,
//                    //                    "stockCode" : code
//                    //                ]
//                    //                navigator.push(YXModulePaths.newStockDetail.url, context: context)
//
//                    let dic: [String: Any] = [
//                        kWebViewModelUrl : YX_NEWSTOCK_DETAIL_URL(exchangeType: exchangeType, ipoId: ipoId ?? 0, stockCode: code)
//                    ]
//                    navigator.push(YXModulePaths.webView.url, context: YXNavigatable(viewModel: YXWebViewModel(dictionary: dic)))
//                } else {
//                    log(.warning, tag: kOther, content: "新股详情页error -> market or code is empty")
//                }
//
//            case GOTO_IPO_PURCHASE_ORDER:
//                // 新股iPO认购页
//                if parser.getParam(withKey: "ipoId") != nil ||
//                    (parser.getParam(withKey: "exchangeType") != nil && parser.getParam(withKey: "stockCode") != nil) {
//
//
//                    let exchangeType = Int(parser.getParam(withKey: "exchangeType") ?? "0") ?? 0
//                    let ipoId = parser.getParam(withKey: "ipoId") ?? "0"
//                    let stockCode = parser.getParam(withKey: "stockCode") ?? ""
//                    let modify = Int(parser.getParam(withKey: "reconfirm") ?? "0") ?? 0
//                    //未认购 ---> 立即认购（剩余X天）
//                    let source = YXPurchaseDetailParams.init(exchangeType: exchangeType, ipoId: ipoId, stockCode: stockCode, isModify: modify, moneyType: YXExchangeType.currentType(exchangeType).moneyType)
//                    if exchangeType == YXExchangeType.hk.rawValue {
//                        navigator.push(YXModulePaths.newStockIPOPurchase.url, context: source)
//                    } else {
//                        navigator.push(YXModulePaths.newStockUSConfirm.url, context: source)
//                    }
//
//                } else {
//                    log(.warning, tag: kOther, content: "新股详情下单页error -> ipoId or stockCode is empty")
//                }
//            case GOTO_MAIN_STOCKKING:
//                NotificationCenter.default.post(name: NSNotification.Name(rawValue: YXUserManager.notiUpdateResetRootView), object: nil, userInfo: ["index" : YXTabIndex.stockST])
//            case GOTO_IPO_PURCHASE_LIST:
//                let type = Int(parser.getParam(withKey: "type") ?? "0") ?? 0
//                var exchangeType: YXExchangeType = .hk
//                if type == 2 {
//                    exchangeType = .us
//                }
//                navigator.push(YXModulePaths.newStockPurcahseList.url, context: exchangeType)
//            case GOTO_HOLD_POSITION:
//                let market = parser.getParam(withKey: "market") ?? YXMarketType.HK.rawValue
//
//                let marketType = YXMarketType.init(rawValue: market.lowercased())
//                let exchangeType = YXToolUtility.getExchangeType(with: marketType ?? YXMarketType.HK)
//
//                if YXUserManager.isGray(with: .fund) {
//                    //灰度为true 显示 基金
//                    let context = YXNavigatable(viewModel: YXMixHoldListViewModel(exchangeType: exchangeType))
//                    navigator.push(YXModulePaths.mixHoldList.url, context: context)
//                } else {
//                    let context = YXNavigatable(viewModel: YXHoldListViewModel(exchangeType: exchangeType))
//                    navigator.push(YXModulePaths.holdList.url, context: context)
//                }
//            case GOTO_CONVERSION_RECORD:
//                var exchangeType: YXExchangeType = .hk
//
//                if let market = parser.getParam(withKey: "market") {
//                    let marketType = YXMarketType.init(rawValue: market.lowercased())
//                    exchangeType = YXToolUtility.getExchangeType(with: marketType ?? YXMarketType.HK)
//                }
//
//                let context = YXNavigatable(viewModel: YXShiftInStockHistoryViewModel(dictionary: [
//                    "exchangeType" : exchangeType
//                ]))
//                navigator.push(YXModulePaths.shiftInHistory.url, context: context)
//            case GOTO_TEL:
//                if let phoneNumber = parser.getParam(withKey: "phoneNumber") {
//                    let str = "tel:\(phoneNumber)"
//                    let application = UIApplication.shared
//                    let URL = NSURL(string: str)
//
//                    if #available(iOS 10.0, *) {
//                        if let URL = URL {
//                            application.open(URL as URL, options: [:], completionHandler: { success in
//                            })
//                        }
//                    } else {
//                        let str = "telprompt://\(phoneNumber)"
//                        if let url = NSURL(string: str) {
//                            UIApplication.shared.openURL(url as URL)
//                        }
//                    }
//                } else {
//                    log(.warning, tag: kOther, content: "拨打电话error -> phoneNumber is empty")
//                }
//            case GOTO_CURRENCY_EXCHANGE:
//                var exchangeType: YXExchangeType = .hk
//
//                if let market = parser.getParam(withKey: "market") {
//                    let marketType = YXMarketType.init(rawValue: market.lowercased())
//                    exchangeType = YXToolUtility.getExchangeType(with: marketType ?? YXMarketType.HK)
//                }
//
//                let context = YXNavigatable(viewModel: YXCurrencyExchangeViewModel(market: exchangeType.market))
//                navigator.push(YXModulePaths.exchange.url, context: context)
//            case GOTO_NEWSTOCK_PURCHASE_DETAIL:
//                // 新股认购明细页
//                if parser.getParam(withKey: "applyId") != nil {
//
//                    let applyId = parser.getParam(withKey: "applyId") ?? "0"
//                    let context: [String : Any] = [
//                        "applyID" : applyId,
//                        "exchangeType" : YXExchangeType.us,
//                        "applyType" : YXNewStockSubsType.internalSubs
//                    ]
//                    navigator.push(YXModulePaths.newStockECMListDetail.url, context: context)
//
//                } else {
//                    log(.warning, tag: kOther, content: "新股认购明细页error -> applyId is empty")
//                }
            default:
//                log(.error, tag: kOther, content: "no one base url matched")
                return false
            }
        }
        
        return true
    }
}
