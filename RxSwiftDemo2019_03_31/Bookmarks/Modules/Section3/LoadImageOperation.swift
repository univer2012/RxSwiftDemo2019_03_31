//
//  LoadImageOperation.swift
//  RxSwiftDemo2019_03_31
//
//  Created by blue on 2020/9/23.
//  Copyright © 2020 远平. All rights reserved.
//

import UIKit

class LoadImageOperation: Operation {
    
    weak var imageview: UIImageView?
    var urlStr:String?
//    let syCache = SYImageCache()
    
    // 2 下载图片数据 同步操作
    func synLoadImageNet() -> Data? {
    
        let  url = URL.init(string: urlStr ?? "")
        
        let urlSession = URLSession.init(configuration: URLSessionConfiguration.ephemeral)
        
        let sem = DispatchSemaphore.init(value: 0)
        
        var imageData:Data?
        let netTask = urlSession.dataTask(with: url!) { (data, response, error) in
            
            
            let httpResponse = response as? HTTPURLResponse
            if httpResponse?.statusCode == 404 || error != nil {
                
                print("图片下载失败")
                
            }else{

                imageData = data
            }
            sem.signal()
        }
        
        netTask.resume()
        
        sem.wait()
        
        return imageData
    }
}
