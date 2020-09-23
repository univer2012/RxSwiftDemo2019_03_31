//
//  YXWebViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by blue on 2020/9/10.
//  Copyright © 2020 远平. All rights reserved.
//

import UIKit
import Reusable
import RxSwift
import RxCocoa
import QMUIKit
import WebKit
import SwiftyJSON

import MobileCoreServices
import MessageUI
import AVFoundation //相机权限
import Photos //照片 权限

import SnapKit


class YXWebViewController: QMUICommonViewController {
    
    let disposeBag = DisposeBag()
    
    var viewModel: YXWebViewModel!
    
    var webView: YXWKWebView?
    
    var progressView: UIProgressView?
    
    var bridge: (YXJSActionBridge & WKScriptMessageHandler)?
    
    var imagePicker: UIImagePickerController?

    var chooseImageOrFileSuccessCallback: String?

    var chooseImageOrFileErrorCallback: String?
    
    var IAPSuccessCallback: String?

    var IAPErrorCallback: String?
    
    var fileMode: Bool?
    
    var positionOneItem: UIBarButtonItem?
    
    var positionTwoItem: UIBarButtonItem?
        
    var backItem, closeItem: UIBarButtonItem?
        
    var publishTime: String?
    
    var refreshHeader: YXRefreshHeader?
        
    var startedNavigation: Bool = false
    
    var megLiveSuccessCallback: String?, megLiveErrorCallback: String?
    
    lazy var noDataView : UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: YXConstant.screenWidth, height: YXConstant.screenHeight-YXConstant.navBarHeight()))
        view.backgroundColor = UIColor.white
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 130, height: 120))
        imageView.image = UIImage(named: "white_wuwangluo");
        imageView.center = CGPoint(x: view.center.x, y: view.center.y - YXConstant.screenHeight*0.2)
        view.addSubview(imageView)
        
        let tipLab = UILabel(frame: CGRect(x: 0, y: 0, width: YXConstant.screenWidth, height: 30))
        tipLab.textAlignment = .center
        tipLab.textColor = UIColor.qmui_color(withHexString: "#393939")//QMUICMI().themeTintColor()
        tipLab.text = "加载失败"//YXLanguageUtility.kLang(key: "common_loadFailed")
        tipLab.font = UIFont.systemFont(ofSize: 14)
        tipLab.center = CGPoint(x: view.center.x, y: imageView.center.y+imageView.frame.height/2+40);
        view.addSubview(tipLab)
        
        let btn = UIButton(type: .custom)
        //YXLanguageUtility.kLang(key: "common_click_refresh")
        btn.setTitle("点击更新", for: .normal)
        btn.setTitleColor(UIColor.qmui_color(withHexString: "#0091FF"), for: .normal) //QMUICMI().themeTextColor()
        btn.bounds = CGRect(x: 0, y: 0, width: 100, height: 30);
        btn.center = CGPoint(x: view.center.x, y: tipLab.center.y+40);
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.qmui_color(withHexString: "#0091FF")?.cgColor//QMUICMI().themeTextColor().cgColor
        btn.layer.cornerRadius = 15
        btn.addTarget(self, action: #selector(noDataBtnAction), for: .touchUpInside)
        view.addSubview(btn)
        
        return view
    }()
    
    @objc func noDataBtnAction() {
        self.noDataView.isUserInteractionEnabled = false
        self.refreshWebview()
    }
    
    deinit {
        self.unregisterJavaScriptInterface()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initUI()
    }
    
    func initUI() {
        self.setupNavigationBar()
        
        self.changeWKWebViewUserAgent()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.bridge?.onActivityStatusChange(isVisible: false)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.bridge?.onActivityStatusChange(isVisible: true)
        
        if viewModel.titleBarVisible {
            self.navigationController?.setNavigationBarHidden(false, animated: false)
        } else {
            self.navigationController?.setNavigationBarHidden(true, animated: false)
        }
    }
    
    fileprivate func registerJavaScriptInterface() {
        if let webView = self.webView {
            self.bridge = YXJSActionBridge(webView: webView, gotoNativeManager: YXGoToNativeManager.shared)
            if let bridge = self.bridge {
                webView.configuration.userContentController.add(bridge, name: "JSActionBridge")
            }
        }
    }

    fileprivate func unregisterJavaScriptInterface() {
        if let webView = self.webView {
            webView.configuration.userContentController.removeScriptMessageHandler(forName: "JSActionBridge")
        }
        self.bridge = nil
    }
    
    func setupNavigationBar() {
        let backItem = UIBarButtonItem.qmui_item(with: UIImage(named: "nav_back"), target: self, action: nil)
        backItem.rx.tap.bind { [weak self] in
            if let webView = self?.webView {
                YXJSActionUtil.invokeJSFunc(withWebview: webView, paramsJsonData: [
                    "canGoBack": NSNumber(value: webView.canGoBack)
                    ], callback: "javascript:window.h5HistoryBack", completionCallback: { (result, error) in
                        let resultBool: Bool = (result as? NSNumber)?.boolValue ?? false
                        if result != nil && resultBool {
                            print("verbose: window.h5HistoryBack running")
                            //log(.verbose, tag: kModuleViewController, content: "window.h5HistoryBack running")
                        } else {
                            if webView.canGoBack {
                                webView.goBack()
                            } else {
                                self?.finish()
                            }
                        }
                        
                })
            }
            }.disposed(by: disposeBag)
        
        let closeItem = UIBarButtonItem.qmui_item(with: UIImage(named: "nav_close"), target: self, action: nil)
        closeItem.rx.tap.bind { [weak self] in
            if let webView = self?.webView {
                YXJSActionUtil.invokeJSFunc(withWebview: webView, paramsJsonData: [:], callback: "javascript:window.h5ClosePage", completionCallback: { result, error in
                    let resultBool: Bool = (result as? NSNumber)?.boolValue ?? false
                    if result != nil && resultBool {
                        print("verbose: window.h5HistoryBack running")
                        //log(.verbose, tag: kModuleViewController, content: "window.h5ClosePage running")
                    } else {
                        self?.finish()
                    }
                })
            } else {
                self?.finish()
            }
            }.disposed(by: disposeBag)
        
        backItem.imageInsets = UIEdgeInsets(top: 0, left: -3.0, bottom: 0, right: 3.0)
        closeItem.imageInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 20)
        self.navigationItem.leftBarButtonItems = [backItem, closeItem]
        
        self.backItem = backItem
        self.closeItem = closeItem
        
        // titleView的最大宽度为减去左右两边预留的按钮宽度；
        self.titleView?.maximumWidth = YXConstant.screenWidth - ((44 + 8) * 2 * 2)
    }
    
    fileprivate func finish() {
        let top: UIViewController? = navigationController?.viewControllers.last
        if top == self && self.qmui_isViewLoadedAndVisible() {
            // 该ViewController是navigationController的根视图，并且该navigationController是由某个ViewController present出来的
            // 那么，就将该navigationController进行dismiss的操作
            // 出现该场景的地方：衍生品风险提示
            if navigationController?.viewControllers.count == 1 && navigationController?.presentingViewController != nil {
                navigationController?.dismiss(animated: true, completion: nil)
            } else {
                navigationController?.popViewController(animated: true)
            }
        } else {
            var array = navigationController?.viewControllers
            var i = (array?.count ?? 0) - 1
            while i >= 0 {
                if array?[i] == self {
                    array?.remove(at: i)
                    if let array = array {
                        navigationController?.viewControllers = array
                    }
                    break
                }
                i -= 1
            }
        }
    }
    
    func addRealWebView() {
        setupWebView()

        if viewModel.titleBarVisible {
            self.progressView = UIProgressView(frame: CGRect(x: 0, y: YXConstant.navBarHeight(), width: YXConstant.screenWidth, height: 2))
        } else {
            self.progressView = UIProgressView(frame: CGRect(x: 0, y: YXConstant.statusBarHeight(), width: YXConstant.screenWidth, height: 2))
        }
        
        if let progressView = self.progressView  {
            progressView.progressTintColor = UIColor.red    //QMUICMI().progressTintColor()
            progressView.progress = 0.05
            self.view.addSubview(progressView)
            progressView.trackTintColor = UIColor.blue      //QMUICMI().trackTintColor()
        }

        self.webView?.rx.observe(Double.self, "estimatedProgress").subscribe(onNext: { [weak self] (estimatedProgress) in
            guard let strongSelf = self else { return }
            
            if let progressView = strongSelf.progressView {
                let animated: Bool = (strongSelf.webView?.estimatedProgress ?? 0.0) > Double(progressView.progress)
                progressView.setProgress(Float(strongSelf.webView?.estimatedProgress ?? 0.0), animated: animated)
                
                // Once complete, fade out UIProgressView
                if (strongSelf.webView?.estimatedProgress ?? 0.0) >= 1.0 {
                    UIView.animate(withDuration: 0.3, delay: 0.8, options: .curveEaseOut, animations: {
                        progressView.alpha = 0.0
                    }) { finished in
                        progressView.setProgress(0.0, animated: false)
                    }
                }
            }
        }).disposed(by: disposeBag)
        //监听 title ，并设置
        self.webView?.rx.observe(String.self, "title").subscribe(onNext: { [weak self] (title) in
            guard let strongSelf = self else { return }
            //标题颜色
            if !(strongSelf.viewModel.webTitle?.isEmpty ?? true) {
                strongSelf.titleView?.title = strongSelf.viewModel.webTitle
            } else {
                strongSelf.titleView?.title = (!(strongSelf.webView?.title?.isEmpty ?? true)) ? strongSelf.webView?.title : ""
            }
        }).disposed(by: disposeBag)

    }
    
    func setupWebView() {
        let config = WKWebViewConfiguration()
        config.preferences = WKPreferences()
        config.preferences.javaScriptEnabled = true
        config.preferences.javaScriptCanOpenWindowsAutomatically = false
        config.allowsInlineMediaPlayback = true

        self.viewModel.titleBarVisibleSubject.asObservable().subscribe(onNext: { [weak self] (value) in
            guard let strongSelf = self else { return }
            
            var frame: CGRect = strongSelf.webView?.frame ?? CGRect.zero
            
            if value {
                strongSelf.navigationController?.setNavigationBarHidden(false, animated: false)
                frame.origin.y = YXConstant.navBarHeight()
                frame.size.height = YXConstant.screenHeight - YXConstant.navBarHeight()
            } else {
                strongSelf.navigationController?.setNavigationBarHidden(true, animated: false)
                frame.origin.y = YXConstant.statusBarHeight()
                frame.size.height = YXConstant.screenHeight - YXConstant.statusBarHeight()
            }
            strongSelf.webView?.frame = frame
        }).disposed(by: disposeBag)
        
        

        if viewModel.titleBarVisible {
            self.webView = YXWKWebView(frame: CGRect(x: 0, y: YXConstant.navBarHeight(), width: YXConstant.screenWidth, height: YXConstant.screenHeight - YXConstant.navBarHeight()), configuration: config)
            if let webView = self.webView {
                view.addSubview(webView)
            }
        } else {
            self.webView = YXWKWebView(frame: CGRect(x: 0, y: YXConstant.statusBarHeight(), width: YXConstant.screenWidth, height: YXConstant.screenHeight - YXConstant.statusBarHeight()), configuration: config)
            if let webView = self.webView {
                view.addSubview(webView)
            }
        }

        //FIXME: 测试代码
        if let urlStr = Bundle.main.path(forResource: "index.html", ofType: nil) {
            let fileURL = URL.init(fileURLWithPath: urlStr)
            if #available(iOS 9.0, *) {
                self.webView?.loadFileURL(fileURL, allowingReadAccessTo: fileURL)
            } else {
                // Fallback on earlier versions
            }
        }
        
        self.webView?.backgroundColor = UIColor.white
        self.webView?.allowsBackForwardNavigationGestures = false

        self.webView?.navigationDelegate = self
        self.webView?.uiDelegate = self
        self.webView?.jsDelegate = self

        if #available(iOS 11.0, *) {
            self.webView?.scrollView.contentInsetAdjustmentBehavior = .never
            self.webView?.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            if let contentInset = self.webView?.scrollView.contentInset {
                self.webView?.scrollView.scrollIndicatorInsets = contentInset
            }
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        
        self.refreshHeader = YXRefreshHeader.init(refreshingBlock: { [weak self] in
            self?.refreshWebview()
        })
        
        self.webView?.scrollView.mj_header = self.refreshHeader
    }
    
    /**
     修改WKWebView的UserAgent
     先通过一个临时的YXWKWebView执行JS脚本，得到当前的userAgent
     然后设置userAgent后，再加载最终的YXWKWebView
     */
    fileprivate func changeWKWebViewUserAgent() {
        self.webView = YXWKWebView(frame: CGRect.zero)
        
        self.webView?.evaluateJavaScript("navigator.userAgent", completionHandler: { [weak self] result, error in
            guard let strongSelf = self else { return }
            
            var userAgent = result as? String
            if userAgent?.contains(" appVersion") ?? false {
                // 如果包含这个字符串，则认为已经添加过，则擦除后面的再重新设置一次
                let array = userAgent?.components(separatedBy: " appVersion")
                if (array?.count ?? 0) > 0 {
                    userAgent = array?[0]
                }
            }
            let infoStr = strongSelf.getDeviceInfoStr()
            let newUserAgent = "\(userAgent ?? "")\(infoStr)"
            let dictionary = [
                "UserAgent" : newUserAgent
            ]

            UserDefaults.standard.register(defaults: dictionary)

            DispatchQueue.main.async(execute: { [weak self] in
                guard let strongSelf = self else { return }
                
                // 重新初始化WKWebView
                strongSelf.webViewWillLoadRequest()
                // 1.重新注册JS Interface
                strongSelf.unregisterJavaScriptInterface()
                strongSelf.addRealWebView()
                // 2.重新注册JS Interface
                strongSelf.registerJavaScriptInterface()
                strongSelf.webViewLoadRequest()
                strongSelf.webViewDidLoadRequest()
            })
        })
    }
    
    /**
     获取设备信息

     @return 设备信息
     */
    fileprivate func getDeviceInfoStr() -> String {
        let appVersion = " appVersion/\(YXConstant.appVersion ?? "")"
        let softwareVersion = "softwareVersion/\(YXConstant.appBuild ?? "")"
        let platform = "platform/\("yxzq-iOS")"
        let model = "model/\(YXConstant.deviceModel)"
        let uuid = "uuid/\(YXConstant.deviceUUID)"
        let appId = "appId/\(YXConstant.bundleId ?? "")"
        let nt = "nt/n1"
        let systemVersion = "systemVersion/\(YXConstant.systemVersion)"
        let sp = "sp/CMCC"
        let tn = "tn/13243766902"
        let env = "environment/\(YXConstant.targetModeName() ?? "")"
        let langType = "langType/\(1)"
        let appType = "appType/\(2)"
        let stockColorType = "stockColorType/\(1)"
        let launchChannel = "inviteChannelId/\(YXConstant.launchChannel ?? "")"

        return "\(appVersion) \(softwareVersion) \(platform) \(model) \(uuid) \(appId) \(nt) \(systemVersion) \(sp) \(tn) \(env) \(langType) \(appType) \(stockColorType) \(launchChannel)"
    }
    
    func handleLoadRequest(url: URL?, reload: Bool = false) {
        
        if self.webView?.isLoading ?? false {
            self.webView?.stopLoading()
        }
        
        if #available(iOS 13.0, *) {
            var windinUrl = url
            if windinUrl == nil {
                windinUrl = self.originalUrl()
            }
//            if let windinUrl = windinUrl, self.isWindinPDFUrl(url: windinUrl) {
//                if let data = try? Data(contentsOf: windinUrl) {
//                    self.webView?.load(data, mimeType: "application/pdf", characterEncodingName: "", baseURL: windinUrl)
//                } else {
//                    self.addNoDataViewAndEnable()
//                }
//                return
//            }
        }
        
        if reload && url != nil {
            self.webView?.reload()
        } else {
            var requestUrl = url
            if requestUrl == nil {
                requestUrl = self.originalUrl()
            }
            if let requestUrl = requestUrl {
                if self.viewModel.cachePolicy == .useProtocolCachePolicy {
                    self.webView?.load(URLRequest(url: requestUrl))
                } else {
                    self.webView?.load(URLRequest(url: requestUrl, cachePolicy: self.viewModel.cachePolicy))
                }
            } else {
                // 兼容子类处理自己的加载逻辑
                self.webViewLoadRequest()
            }
        }
    }
    
    func addNoDataViewAndEnable() {
        if self.noDataView.superview != nil {
            self.noDataView.removeFromSuperview()
        }
        self.webView?.addSubview(self.noDataView)
        self.noDataView.isUserInteractionEnabled = true
    }
    
    func removeNoDataViewAndDisable() {
        if self.noDataView.superview != nil {
            self.noDataView.isUserInteractionEnabled = false
            self.noDataView.removeFromSuperview()
        }
    }
    
    func originalUrl() -> URL? {
        if let urlString = self.viewModel.url, let url = URL(string: urlString) {
            return url
        }
        return nil
    }
    
    func webViewLoadRequest() {
        print("verbose: WebViewLoadRequest")
        //log(.verbose, tag: kModuleViewController, content: "WebViewLoadRequest")
        if let url = self.originalUrl() {
            self.handleLoadRequest(url: url)
        }
    }

    func webViewWillLoadRequest() {
        print("verbose: WebViewWillLoadRequest")
        //log(.verbose, tag: kModuleViewController, content: "WebViewWillLoadRequest")
    }

    func webViewDidLoadRequest() {
        print("verbose: WebViewDidLoadRequest")
        //log(.verbose, tag: kModuleViewController, content: "WebViewDidLoadRequest")
    }
    
    func refreshWebview() {
        let url = self.webView?.url
        if self.startedNavigation {
            return
        }
        self.handleLoadRequest(url: url, reload: true)
    }
}

extension YXWebViewController: WKUIDelegate {
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: "温馨提示", message: message, preferredStyle: .alert) //YXLanguageUtility.kLang(key: "common_tips")
        //YXLanguageUtility.kLang(key: "common_confirm")
        alert.addAction(UIAlertAction(title: "确认", style: .default, handler: { action in
            completionHandler()
        }))
        self.present(alert, animated: true)
    }
}

extension YXWebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.startedNavigation = true
        if !(self.viewModel.webTitle?.isEmpty ?? true) {
            self.titleView?.title = self.viewModel.webTitle
        } else {
            self.titleView?.title = "正在加载中"//YXLanguageUtility.kLang(key: "common_loading")
        }
        
        self.progressView?.alpha = 1.0
        
        self.removeNoDataViewAndDisable()
        print("verbose: YXWebViewController didStartProvisionalNavigation")
        //log(.verbose, tag: kModuleViewController, content: "YXWebViewController didStartProvisionalNavigation")
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
//        if SensorsAnalyticsSDK.sharedInstance()?.showUpWebView(webView, with: navigationAction.request, enableVerify: true) ?? false {
//            decisionHandler(.cancel)
//            return
//        } else
        if navigationAction.request.url?.scheme == "sms" || navigationAction.request.url?.scheme == "tel" || navigationAction.request.url?.scheme == "mailto" {
            //url中是否含有拨打电话和邮件
            let app = UIApplication.shared
            if let url = navigationAction.request.url {
                if app.canOpenURL(url) {
                    //是被是否可以打开
                    if #available(iOS 10.0, *) {
                        app.open(url, options: [:], completionHandler: { success in
                        })
                    } else {
                        app.openURL(url)
                    }
                }
            }
            decisionHandler(.cancel)
            return
        }
        
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        if let urlString = webView.url?.absoluteString,
            urlString.hasPrefix(YXZQ_SCHEME),
            YXGoToNativeManager.shared.gotoNativeViewController(withUrlString: urlString) {
            decisionHandler(.cancel)
            return
        }
        
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("verbose: YXWebViewController didFinishNavigation")
        //log(.verbose, tag: kModuleViewController, content: "YXWebViewController didFinishNavigation")
        self.startedNavigation = false
        self.removeNoDataViewAndDisable()
        if !(self.viewModel.webTitle?.isEmpty ?? true) {//self.viewModel.webTitle?.count ?? 0 > 0
            self.titleView?.title = self.viewModel.webTitle
        } else if self.titleView?.title == "加载中" {//YXLanguageUtility.kLang(key: "common_loading") {
            self.titleView?.title = ""
        }
        
        if let mj_header = self.webView?.scrollView.mj_header {
            mj_header.endRefreshing()
        }
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        self.titleView?.title = "详情"//YXLanguageUtility.kLang(key: "webview_detailTitle")
        
        self.startedNavigation = false
        if let mj_header = self.webView?.scrollView.mj_header {
            mj_header.endRefreshing()
        }
        
        if (((error as NSError).code <= NSURLErrorBadURL && (error as NSError).code >= NSURLErrorNoPermissionsToReadFile)) || ((error as NSError).code <= NSURLErrorSecureConnectionFailed && (error as NSError).code >= NSURLErrorCannotLoadFromNetwork) || ((error as NSError).code <= NSURLErrorCannotCreateFile && (error as NSError).code >= NSURLErrorDownloadDecodingFailedToComplete) {
            self.addNoDataViewAndEnable()
        }
    }
}

extension YXWebViewController: YXWKWebViewDelegate {
    //MARK: - onGet
    
    func onGetLocationInfo(withParamsJsonValue paramsJsonValue: Dictionary<String, Any>?, successCallback: String?, errorCallback: String?) {
        if let name = paramsJsonValue?["name"] as? String {
            let locationInfo : [String: Any] = [
                "name": name,
                "location": "广东省深圳市南山区学府路XXXX号",
            ]
            if let jsonData = try? JSONSerialization.data(withJSONObject: locationInfo, options: .prettyPrinted),
                let jsonString = String(data: jsonData, encoding: String.Encoding.utf8), let webView = self.webView, let successCallback = successCallback {
                YXJSActionUtil.invokeJSCallbackForSuccess(withWebview: webView, data: jsonString, callback: successCallback)
            }
        }
    }
    
    
    //MARK: - onCommand
    //MARK: 执行分享
    func onCommandShare(withParamsJsonValue paramsJsonValue: Dictionary<String, Any>?, successCallback: String?, errorCallback: String?) {
        
        let title = (paramsJsonValue?["title"] as? String) ?? ""
        let content = paramsJsonValue?["content"] as? String
        let pageUrl = paramsJsonValue?["url"] as? String
        
        print("调用分享命令：\n title = \(title)\n content = \(content)\n pageUrl = \(pageUrl)")
        
        // 分享结束后的回调
        let shareResultBlock: ((Bool) -> Void) = { [weak self] (result) in
            guard let `self` = self else { return }

            if result {
                if  let webView = self.webView,
                    let successCallback = successCallback,
                    successCallback.count > 0 {
                    YXJSActionUtil.invokeJSCallbackForSuccess(withWebview: webView, data: "success", callback: successCallback)
                }
            } else {
                if let errorCallback = errorCallback,
                    errorCallback.count > 0,
                    let webView = self.webView {
                    YXJSActionUtil.invokeJSCallbackForError(withWebview: webView, errorDesc: "share failed", callback: errorCallback)
                }
            }
        }
        
        shareResultBlock(true)
    }
    
}

