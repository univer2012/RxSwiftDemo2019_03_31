//
//  LoadImageOperation.swift
//  RxSwiftDemo2019_03_31
//
//  Created by blue on 2020/9/23.
//  Copyright © 2020 远平. All rights reserved.
//
/*
 
 1 imageview去加载A图片的时候，网速很慢，那么还没加载完，然后imageview切换任务，去加载B图片， 最终imageview要展示的是B图片
 当imageview切换任务的时候，取消上一个任务 ， 添加取消节点
 
 
 2 去重，当两个imageview 去加载同一个url图片， 如果不做处理，会同时开启两个同样的网络操作
 
 */
import UIKit

class LoadImageOperation: Operation {
    
    weak var imageview: UIImageView?
    var urlStr:String?
    let syCache = SYImageCache()
    
    var __reTaskInfo = [String: [UIImageView]]()
    
    
    override func main() {
        print("开始执行了任务")
        
        // 1 去缓存查找 是否有图片
        if let cacheImage = syCache.searchImage(imageKey: urlStr) {
            
            // 1.1 如果图片已经存在，那么就直接加载出来
            loadImageInMain(bitmap: cacheImage)
            return
        }
        
        // 1.2 判断是否已经开启了同一个网络任务
        if var array = self.__reTaskInfo[self.urlStr ?? ""] {
            array.append(self.imageview!)
            return
        } else {
            var array = Array<UIImageView>()
            array.append(self.imageview!)
            self.__reTaskInfo[self.urlStr ?? ""] = array
        }
        
        // 2 网络下载图片（同步）
        if let imageData = synLoadImageNet() {
            
            // 3 bitmap处理
            if let bitmap = createBimmapImage(image: UIImage.init(data: imageData)){
                
                // 4 把图片存入缓存
                bitmap.saveImageToSYCache(fileName: urlStr)
                
                // 5 加载图片（主线程上加载）
                loadImageInMain(bitmap: bitmap)
                
                // 6 去重
                reloadSameTask(bitmap: bitmap)
        
            }
        }
        
    }
    
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
    
    // 3  bitmap
    
    func createBimmapImage(image:UIImage?) -> UIImage? {
        
        
        if image == nil {
            
            return nil
        }
        
        let imageRef = (image!.cgImage)!
        
        var colorSpace = imageRef.colorSpace
        if colorSpace == nil {
            colorSpace = CGColorSpaceCreateDeviceRGB()
        }
        
        // 1 准备好一个上下文。 创建了一个bitmapContext， Creates a bitmap graphics context
        let context: CGContext? =  CGContext.init(data: nil, width: imageRef.width, height: imageRef.height, bitsPerComponent: imageRef.bitsPerComponent, bytesPerRow: imageRef.bytesPerRow, space: colorSpace!, bitmapInfo: imageRef.bitmapInfo.rawValue)
        
        
        // 2 图片绘制到上下文中
        context?.draw(imageRef, in: CGRect.init(x: 0, y: 0, width: imageRef.width, height: imageRef.height))
        
        // 3 生成bitmap
        if let cgBitmapImage: CGImage = context?.makeImage() {
            
            let bitmapImage = UIImage.init(cgImage: cgBitmapImage)
            
            return bitmapImage
        }
        
        return nil
    }
    
    func loadImageInMain(bitmap: UIImage) {
        DispatchQueue.main.async {
            if self.imageview?.urlStr != self.urlStr {
                return
            }
            
            self.imageview?.image = bitmap
        }
    }
    
    func reloadSameTask(bitmap: UIImage) {
        if let arr = self.__reTaskInfo[self.urlStr ?? ""] {
            for imageView in arr {
                if imageView == self.imageview {
                    continue
                }
                
                if imageView.urlStr == self.urlStr { //当前的imageView是否切换任务了
                    DispatchQueue.main.async {
                        imageView.image = bitmap
                    }
                }
            }
            
            self.__reTaskInfo[self.urlStr!] = nil       //移除任务
        }
    }
    
}
