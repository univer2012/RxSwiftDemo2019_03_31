//
//  SYImageCache.swift
//  RxSwiftDemo2019_03_31
//
//  Created by blue on 2020/9/24.
//  Copyright © 2020 远平. All rights reserved.
//

import UIKit

class SYImageCache {
    
    
    let cacheDocPath:String
    
    static var imageMemoryCache = {
        
        return NSCache<NSString, UIImage>()
        
    }()
    
    
    fileprivate static let __syimageCache:SYImageCache = {
        
       return SYImageCache.init()
    }()
    
    
    static func shareInstance() -> SYImageCache {
        
        return __syimageCache
    }
    
    init() {
        
        let docPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first! as NSString
        
        cacheDocPath = docPath.appendingPathComponent("SYImageCache")
        if (FileManager.default.fileExists(atPath: cacheDocPath, isDirectory: nil) == false) {
            
            do {
           try FileManager.default.createDirectory(atPath: cacheDocPath, withIntermediateDirectories: false, attributes: nil)
                
            }catch{
                
                print("缓存文件夹创建失败:", error)
            }
        }
        
    }
    
    // 1 查找
    func searchImage(imageKey:String?) -> UIImage? {
        
        if let imageName = imageKey {
            
            // 1.1 从NSCache查找
            if let cacheImage = SYImageCache.imageMemoryCache.object(forKey: imageName.syImageFileName() as NSString){
                
                return cacheImage
            }
            
            // 1.2 本地SYImageCache文件夹下找 , http://
            
            let imagefilePath = cacheDocPath.appending("/\(imageName.syImageFileName())")
            return UIImage.init(contentsOfFile: imagefilePath)
            
            
        }
        
        return nil
    }
    
    
    
}


extension UIImage {
    
    // 2 保存
    func saveImageToSYCache(fileName:String?) {
        
        if let imageData = self.pngData(), let filename = fileName {
            
            // 2.1 存 cache
            SYImageCache.imageMemoryCache.setObject(self, forKey: filename.syImageFileName() as NSString)
            
            // 2.2 存本地文件
            var filePath = SYImageCache.shareInstance().cacheDocPath as NSString
            filePath = filePath.appendingPathComponent(filename.syImageFileName()) as NSString
            let url = URL.init(fileURLWithPath: filePath as String)
            
            do{
                
             try  imageData.write(to: url, options: .atomicWrite)
                
            }catch{
                
                print("写入失败")
            }
        }
    }
    
}

extension String {
    
    // url 转化成文件明
    func syImageFileName() -> String {
        
        if let tmpStr = self as NSString? {
            
            return tmpStr.replacingOccurrences(of: "/", with: "")
            
        }else{
            
            return ""
        }
        
    }
    
    
    func syImageMD5Key() -> String? {
        //
        return nil
    }
    
}
