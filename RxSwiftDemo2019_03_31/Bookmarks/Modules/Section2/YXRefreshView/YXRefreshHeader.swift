//
//  YXRefreshHeader.swift
//  RxSwiftDemo2019_03_31
//
//  Created by blue on 2020/9/10.
//  Copyright © 2020 远平. All rights reserved.
//

import UIKit
//import ReactiveSwift
//import ReactiveCocoa
import Result

class YXRefreshHeader: MJRefreshHeader {
    
//    @objc var xNoNavStyle = false
//    
//    lazy var pullingView: LOTAnimationView = {
//        let pullingView = LOTAnimationView.init(name: pullingAnimation())
//        return pullingView
//    }()
//    
//    lazy var refreshingView: LOTAnimationView = {
//        let refreshingView = LOTAnimationView.init(name: refreshAnimation())
//        refreshingView.loopAnimation = true
//        return refreshingView
//    }()
//    
//    lazy var tiplab: UILabel = {
//        let label = UILabel()
//        label.textColor = tipLabelColor()
//        label.font = UIFont.systemFont(ofSize: 12)
//        label.textAlignment = .center
//        return label
//    }()
//    
//    func pullingAnimation() -> String {
//        return "refresh_pulling"
//    }
//    
//    func refreshAnimation() -> String {
//        return "refresh_refreshing"
//    }
//    
//    func tipLabelColor() -> UIColor {
//        return QMUICMI().commonTextColor(withAlpha: 0.6)
//    }
//
//    override var state: MJRefreshState {
//        didSet {
//            switch state {
//            case .idle:
//                self.refreshingView.isHidden = true
//                self.pullingView.isHidden = false
//                self.tiplab.text = YXLanguageUtility.kLang(key: "common_drop_refresh")
//                self.pullingView.stop()
//                self.refreshingView.stop()
//            case .pulling:
//                self.refreshingView.isHidden = false
//                self.pullingView.isHidden = true
//                self.tiplab.text = YXLanguageUtility.kLang(key: "common_release_refresh")
//                self.pullingView.pause()
//            case .refreshing:
//                self.refreshingView.isHidden = false
//                self.pullingView.isHidden = true
//                self.tiplab.text = YXLanguageUtility.kLang(key: "common_refreshing")
//                self.refreshingView.play()
//            case .noMoreData:
//                log(.debug, tag: kOther, content: "no more data")
//            case .willRefresh:
//                log(.debug, tag: kOther, content: "will refresh")
//            }
//        }
//    }
//    
//    override var pullingPercent: CGFloat {
//        didSet {
//            if state != .idle {
//                return
//            }
//            let p = (pullingPercent - 0.55)*1.6
//            self.pullingView.animationProgress = p>1 ? 1 : p;
//        }
//    }
//    
//    override func prepare() {
//        super.prepare()
//        
//        self.mj_h = 85
//        self.addSubview(self.pullingView)
//        self.addSubview(self.refreshingView)
//        self.addSubview(self.tiplab)
//    }
//    
//    override func placeSubviews() {
//        super.placeSubviews()
//        
//        var y = self.mj_h-55
//        if xNoNavStyle {
//            y = self.mj_h-75
//        }
//        self.pullingView.bounds = CGRect.init(x: 0, y: 0, width: 40, height: 40)
//        self.pullingView.center = CGPoint.init(x: self.mj_w/2, y: y)
//        self.refreshingView.bounds = CGRect.init(x: 0, y: 0, width: 40, height: 40)
//        self.refreshingView.center = CGPoint.init(x: self.mj_w/2, y: y)
//        self.tiplab.bounds = CGRect.init(x: 0, y: 0, width: YXConstant.screenWidth, height: 25)
//        self.tiplab.center = CGPoint(x: self.mj_w/2, y: self.pullingView.frame.minY+self.pullingView.frame.height+10)
//    }
}
