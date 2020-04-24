//
//  UIImagePickerController+RxCreate.swift
//  RxSwiftDemo2019_03_31
//
//  Created by Mac on 2019/11/19.
//  Copyright © 2019 远平. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

//取消置顶视图控制器函数
func dismissViewController(_ viewController: UIViewController,animated: Bool) {
    if viewController.isBeingDismissed || viewController.isBeingPresented {
        DispatchQueue.main.async {
            dismissViewController(viewController, animated: animated)
        }
        return
    }
    
    if viewController.presentingViewController != nil {
        viewController.dismiss(animated: animated, completion: nil)
    }
}


//对UIImagePickerController进行Rx扩展
extension Reactive where Base: UIImagePickerController {
    static func createWithParent(_ parent: UIViewController?, animated: Bool = true, configureImagePicker: @escaping (UIImagePickerController) throws -> () = {x in}) -> Observable<UIImagePickerController> {
        
        //返回可观察序列
        return Observable.create { [weak parent] (observer) -> Disposable in
            
            //初始化一个图片选择控制器
            let imagePicker = UIImagePickerController()
            
            //不管图片选择完毕还是取消选择，都会发出.complete事件
            let dismissDisposable = Observable.merge(
                imagePicker.rx.didFinishPickingMediaWithInfo.map{_ in ()},
                imagePicker.rx.didCancel
            ).subscribe(onNext: { (_) in
                observer.on(.completed)
            })
            
            //设置图片选择控制器初始参数参数不准确则发出.error事件
            do {
                try configureImagePicker(imagePicker)
            } catch let error {
                observer.on(.error(error))
                return Disposables.create()
            }
            
            //判断parent是否存在，不存在则发出.completed事件
            guard let parent = parent else {
                observer.on(.completed)
                return Disposables.create()
            }
            
            //弹出控制器，显示界面
            parent.present(imagePicker, animated: animated, completion: nil)
            //发出.next事件（携带的是控制器对象）
            observer.on(.next(imagePicker))
            
            //销毁时自动退出图片控制器
            return Disposables.create(dismissDisposable, Disposables.create {
                dismissViewController(imagePicker, animated: animated)
            })
        }
    }
}

