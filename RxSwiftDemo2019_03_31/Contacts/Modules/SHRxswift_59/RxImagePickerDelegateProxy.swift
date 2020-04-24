//
//  RxImagePickerDelegateProxy.swift
//  RxSwiftDemo2019_03_31
//
//  Created by 远平 on 2019/11/14.
//  Copyright © 2019 远平. All rights reserved.
//

import RxSwift
import RxCocoa
import UIKit

public class RxImagePickerDelegateProxy:
    DelegateProxy<UIImagePickerController,UIImagePickerControllerDelegate & UINavigationControllerDelegate>,
    DelegateProxyType,
    UIImagePickerControllerDelegate,
    UINavigationControllerDelegate {
    
    public init(imagePicker: UIImagePickerController) {
        super.init(parentObject: imagePicker, delegateProxy: RxImagePickerDelegateProxy.self)
    }
    
    public static func registerKnownImplementations() {
        self.register{ RxImagePickerDelegateProxy(imagePicker: $0)}
    }
    
    public static func currentDelegate(for object: UIImagePickerController) -> (UIImagePickerControllerDelegate & UINavigationControllerDelegate)? {
        return object.delegate
    }
    
    public static func setCurrentDelegate(_ delegate: (UIImagePickerControllerDelegate & UINavigationControllerDelegate)?, to object: UIImagePickerController) {
        object.delegate = delegate
    }
}

