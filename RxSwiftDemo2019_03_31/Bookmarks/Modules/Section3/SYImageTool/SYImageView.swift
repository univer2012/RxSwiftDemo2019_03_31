//
//  SYImageView.swift
//  RxSwiftDemo2019_03_31
//
//  Created by blue on 2020/9/23.
//  Copyright © 2020 远平. All rights reserved.
//

import UIKit

fileprivate let _syOperationQueue:OperationQueue = {
    
    let opQueue = OperationQueue.init()
    opQueue.maxConcurrentOperationCount = 5
    return opQueue
    
}()


fileprivate var __urlStr:String = "urlStr"

extension UIImageView {
    
    
    var urlStr: String? {
        
        
        get {
            
            return objc_getAssociatedObject(self, &__urlStr) as? String
            
        }set {
            
            objc_setAssociatedObject(self, &__urlStr, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    
    func loadImageWithURL(url:String)  {
        
        //  负责执行图片加载任务
        //  缓存，bitmap在子线程上操作的；  主线程加载图片
        
        self.urlStr = url
        
        let loadOperation = LoadImageOperation()
        loadOperation.imageview = self
        loadOperation.urlStr = url
        _syOperationQueue.addOperation(loadOperation)
        
        
    }
    
    //非缓存的方式（自己完成）
    func loadImageWithURLNoCache(url:String) {
        
    }
    
}
