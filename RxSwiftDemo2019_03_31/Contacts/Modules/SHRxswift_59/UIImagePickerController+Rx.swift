//
//  UIImagePickerController+Rx.swift
//  RxSwiftDemo2019_03_31
//
//  Created by 远平 on 2019/11/14.
//  Copyright © 2019 远平. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa




//图片选择控制器（UIImagePcikerController）的Rx扩展
extension Reactive where Base: UIImagePickerController {
    
    //代理委托
    public var pickerDelegate: DelegateProxy<UIImagePickerController, UIImagePickerControllerDelegate & UINavigationControllerDelegate> {
        return RxImagePickerDelegateProxy.proxy(for: base)
    }
    
    //图片选择完毕代理方法的封装
    public var didFinishPickingMediaWithInfo: Observable<[UIImagePickerController.InfoKey: Any]> {
        return pickerDelegate.methodInvoked(#selector(UIImagePickerControllerDelegate
            .imagePickerController(_:didFinishPickingMediaWithInfo:)))
            .map{ a in //[UIImagePickerController.InfoKey : Any]
                return try castOrThrow(Dictionary<UIImagePickerController.InfoKey, Any>.self, a[1])
        }
    }
    
    //图片取消选择代理方法的封装
    public var didCancel: Observable<()> {
        return pickerDelegate
            .methodInvoked(#selector(UIImagePickerControllerDelegate
                .imagePickerControllerDidCancel(_:)))
            .map{ _ in () }
    }
}

//转类型的函数（转换失败后，会发出Error）
fileprivate func castOrThrow<T>(_ resultType: T.Type, _  object: Any) throws -> T {
    guard let returnValue = object as? T else {
        throw RxCocoaError.castingError(object: object, targetType: resultType)
    }
    return returnValue
}



