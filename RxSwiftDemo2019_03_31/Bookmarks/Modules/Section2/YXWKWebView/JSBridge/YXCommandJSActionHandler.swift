//
//  YXCommandJSActionHandler.swift
//  YouXinZhengQuan
//
//  Created by 胡华翔 on 2018/11/20.
//  Copyright © 2018 RenRenDai. All rights reserved.
//

import UIKit
import WebKit

class YXCommandJSActionHandler: YXBaseJSActionHandler {
    override func handlerAction(withWebview webview:WKWebView, actionEvent: String, paramsJsonValue: Dictionary<String, Any>?, successCallback: String?, errorCallback: String?) {
        super.handlerAction(withWebview: webview, actionEvent: actionEvent, paramsJsonValue: paramsJsonValue, successCallback: successCallback, errorCallback: errorCallback)
        switch actionEvent {
        case COMMAND_SHARE:
            if let webview = webview as? YXWKWebView {
                webview.jsDelegate?.onCommandShare?(withParamsJsonValue: paramsJsonValue, successCallback: successCallback, errorCallback: errorCallback)
            }
        case COMMAND_CHECK_CLIENT_INSTALL_STATUS:
            if let webview = webview as? YXWKWebView {
                webview.jsDelegate?.onCommandCheckClientInstallStatus?(withParamsJsonValue: paramsJsonValue, successCallback: successCallback, errorCallback: errorCallback)
            }
        case COMMAND_LOGOUT_USER_ACCOUNT:
            print("COMMAND_LOGOUT_USER_ACCOUNT")
            //log(.info, tag: kOther, content: "COMMAND_LOGOUT_USER_ACCOUNT")
        case COMMAND_LOGOUT_TRADE_ACCOUNT:
            print("COMMAND_LOGOUT_TRADE_ACCOUNT")
            //log(.info, tag: kOther, content: "COMMAND_LOGOUT_TRADE_ACCOUNT")
        case COMMAND_CLOSE_WEBVIEW:
            if let webview = webview as? YXWKWebView {
                webview.jsDelegate?.onCommandCloseWebView?(withParamsJsonValue: paramsJsonValue, successCallback: successCallback, errorCallback: errorCallback)
            }
        case COMMAND_GO_BACK:
            if let webview = webview as? YXWKWebView {
                webview.jsDelegate?.onCommandGoBack?(withParamsJsonValue: paramsJsonValue, successCallback: successCallback, errorCallback: errorCallback)
            }
        case COMMAND_HIDE_TITLEBAR:
            print("COMMAND_HIDE_TITLEBAR")
            //log(.info, tag: kOther, content: "COMMAND_HIDE_TITLEBAR")
        case COMMAND_SET_TITLE:
            print("COMMAND_SET_TITLE")
            //log(.info, tag: kOther, content: "COMMAND_SET_TITLE")
        case COMMAND_WATCH_NETWORK:
            print("COMMAND_WATCH_NETWORK")
            //log(.info, tag: kOther, content: "COMMAND_WATCH_NETWORK")
        case COMMAND_WATCH_ACTVITY_STATUS:
            print("COMMAND_WATCH_ACTVITY_STATUS")
            //log(.info, tag: kOther, content: "COMMAND_WATCH_ACTVITY_STATUS")
        case COMMAND_ADD_OPTIONAL_STOCK:
            if let webview = webview as? YXWKWebView {
                webview.jsDelegate?.onCommandAddOptionalStockEvent?(withParamsJsonValue: paramsJsonValue, successCallback: successCallback, errorCallback: errorCallback)
            }
            print("info: COMMAND_ADD_OPTIONAL_STOCK")
            //log(.info, tag: kOther, content: "COMMAND_ADD_OPTIONAL_STOCK")
        case COMMAND_DELETE_OPTIONAL_STOCK:
            print("info: COMMAND_DELETE_OPTIONAL_STOCK")
            //log(.info, tag: kOther, content: "COMMAND_DELETE_OPTIONAL_STOCK")
        case COMMAND_COPY_TO_PASTEBOARD:
            if let webview = webview as? YXWKWebView {
                webview.jsDelegate?.onCommandCopyToPasteboard?(withParamsJsonValue: paramsJsonValue, successCallback: successCallback, errorCallback: errorCallback)
            }
        case COMMAND_USER_LOGIN:
            if let webview = webview as? YXWKWebView {
                webview.jsDelegate?.onCommandUserLogin?(withParamsJsonValue: paramsJsonValue, successCallback: successCallback, errorCallback: errorCallback)
            }
        case COMMAND_BIND_MOBILE_PHONE:
            if let webview = webview as? YXWKWebView {
                webview.jsDelegate?.onCommandBindMobilePhone?(withParamsJsonValue: paramsJsonValue, successCallback: successCallback, errorCallback: errorCallback)
            }
        case COMMAND_OPEN_NOTIFICATION:
            if let webview = webview as? YXWKWebView {
                webview.jsDelegate?.onCommandOpenNotification?(withParamsJsonValue: paramsJsonValue, successCallback: successCallback, errorCallback: errorCallback)
            }
        case COMMAND_TRADE_LOGIN:
            if let webview = webview as? YXWKWebView {
                webview.jsDelegate?.onCommandTradeLogin?(withParamsJsonValue: paramsJsonValue, successCallback: successCallback, errorCallback: errorCallback)
            }
        case COMMAND_SET_TITLEBAR_BUTTON:
            if let webview = webview as? YXWKWebView {
                webview.jsDelegate?.onCommandSetTitlebarButton?(withParamsJsonValue: paramsJsonValue, successCallback: successCallback, errorCallback: errorCallback)
            }
        case COMMAND_SCREENSHOT_SHARE_SAVE:
            if let webview = webview as? YXWKWebView {
                webview.jsDelegate?.onCommandScreenshotShareSave?(withParamsJsonValue: paramsJsonValue, successCallback: successCallback, errorCallback: errorCallback)
            }
            
        case COMMAND_CONTACT_SERVICE:
            if let webview = webview as? YXWKWebView {
                webview.jsDelegate?.onCommandContactService?(withParamsJsonValue: paramsJsonValue, successCallback: successCallback, errorCallback: errorCallback)
            }
        case COMMAND_SAVE_PICTURE:
            if let webview = webview as? YXWKWebView {
                webview.jsDelegate?.onCommandSavePicture?(withParamsJsonValue: paramsJsonValue, successCallback: successCallback, errorCallback: errorCallback)
            }
        case COMMAND_ALL_MSG_READ:
            if let webview = webview as? YXWKWebView {
                webview.jsDelegate?.onCommandAllMsgRead?(withParamsJsonValue: paramsJsonValue, successCallback: successCallback, errorCallback: errorCallback)
            }
        case COMMAND_CONFIRM_US_QUOTE_STATEMENT:
            if let webview = webview as? YXWKWebView {
                webview.jsDelegate?.onCommandConfirmUSQuoteStatement?(withParamsJsonValue: paramsJsonValue, successCallback: successCallback, errorCallback: errorCallback)
            }
        case COMMAND_TOKEN_FAILURE:
            if let webview = webview as? YXWKWebView {
                webview.jsDelegate?.onCommandTokenFailure?(withParamsJsonValue: paramsJsonValue, successCallback: successCallback, errorCallback: errorCallback)
            }
        case COMMAND_UPLOAD_ELK_LOG:
            if let webview = webview as? YXWKWebView {
                webview.jsDelegate?.onCommandUploadElkLog?(withParamsJsonValue: paramsJsonValue, successCallback: successCallback, errorCallback: errorCallback)
            }
        case COMMAND_ENABLE_PULL_REFRESH:
            if let webview = webview as? YXWKWebView {
                webview.jsDelegate?.onCommandEnablePullRefresh?(withParamsJsonValue: paramsJsonValue, successCallback: successCallback, errorCallback: errorCallback)
            }
        case COMMAND_REFRESH_USER_INFO:
            if let webview = webview as? YXWKWebView {
                webview.jsDelegate?.onCommandRefreshUserInfo?(withParamsJsonValue: paramsJsonValue, successCallback: successCallback, errorCallback: errorCallback)
            }
        case COMMAND_NFC_RECOGNIZE_PASSPORT:
            if let webview = webview as? YXWKWebView {
                webview.jsDelegate?.onCommandNFCRecognizePassport?(withParamsJsonValue: paramsJsonValue, successCallback: successCallback, errorCallback: errorCallback)
            }
        case COMMAND_UPLOAD_APPSFLYER_EVENT:
            if let webview = webview as? YXWKWebView {
                webview.jsDelegate?.onCommandUploadAppsflyerEvent?(withParamsJsonValue: paramsJsonValue, successCallback: successCallback, errorCallback: errorCallback)
            }
        case COMMAND_BUY_IN_APP_PRODUCT:
            if let webview = webview as? YXWKWebView {
                webview.jsDelegate?.onCommandBuyInAppProductEvent?(withParamsJsonValue: paramsJsonValue, successCallback: successCallback, errorCallback: errorCallback)
            }
        case COMMAND_PRODUCT_CONSUME_RESULT:
            if let webview = webview as? YXWKWebView {
                webview.jsDelegate?.onCommandProductConsumeResult?(withParamsJsonValue: paramsJsonValue, successCallback: successCallback, errorCallback: errorCallback)
            }

        default:
            print("no matched command action")
            //log(.error, tag: kOther, content: "no matched command action")
        }
    }
}
