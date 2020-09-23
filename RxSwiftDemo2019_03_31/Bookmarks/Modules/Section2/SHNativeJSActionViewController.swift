//
//  SHNativeJSActionViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by blue on 2020/9/10.
//  Copyright © 2020 远平. All rights reserved.
//

import UIKit

class SHNativeJSActionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let webViewBtn: UIButton = {
            let btn = UIButton()
            btn.setTitle("点击进入网页", for: .normal)
            btn.setTitleColor(UIColor.blue, for: .normal)
            btn.addTarget(self, action: #selector(pushToWebView), for: .touchUpInside)
            return btn
        }()
        
        view.addSubview(webViewBtn)
        webViewBtn.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(200)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc func pushToWebView() {
        let dic: [String: Any] = [:]
//        let dic: [String: Any] = [
//            kWebViewModelUrl: "http://m1-uat.yxzq.com/wealth/fund/index.html#/home?market=hk",
//        ]
        let viewModel = YXWebViewModel(dictionary: dic)
        let vc = YXWebViewController()
        vc.viewModel = viewModel
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

}
