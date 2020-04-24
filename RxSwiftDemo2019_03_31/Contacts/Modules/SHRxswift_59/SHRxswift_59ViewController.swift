//
//  SHRxswift_59ViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by 远平 on 2019/11/14.
//  Copyright © 2019 远平. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SHRxswift_59ViewController: UIViewController {
    let disposeBag = DisposeBag()
    //拍照按钮
    @IBOutlet weak var cameraButton: UIButton!
    
    //选择照片按钮
    @IBOutlet weak var galleryButton: UIButton!
    
    //选择照片并裁减按钮
    @IBOutlet weak var cropButton: UIButton!
    
    //显示照片的imageView
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //判断并决定“拍照”按钮是否可用
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
        //"拍照"按钮点击
        cameraButton.rx.tap.flatMapLatest { [weak self] (_) in
            return UIImagePickerController.rx.createWithParent(self) { (picker: UIImagePickerController) in
                picker.sourceType = .camera
                picker.allowsEditing = false
            }.flatMap{ $0.rx.didFinishPickingMediaWithInfo }
        }.map { (info) in
            return info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        }.bind(to: imageView.rx.image)
        .disposed(by: disposeBag)
        
        
        //"选择"按钮点击
        galleryButton.rx.tap.flatMapLatest { [weak self] (_) in
            return UIImagePickerController.rx.createWithParent(self) { (picker: UIImagePickerController) in
                picker.sourceType = .photoLibrary
                picker.allowsEditing = false
            }.flatMap{ $0.rx.didFinishPickingMediaWithInfo }
        }.map { (info) in
            return info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        }.bind(to: imageView.rx.image)
        .disposed(by: disposeBag)
        
        
        //“选择照片并裁剪”按钮点击
        cropButton.rx.tap.flatMapLatest { [weak self] (_) in
            return UIImagePickerController.rx.createWithParent(self) { (picker: UIImagePickerController) in
                picker.sourceType = .photoLibrary
                picker.allowsEditing = true
            }.flatMap{ $0.rx.didFinishPickingMediaWithInfo }
        }.map { (info) in
            return info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        }.bind(to: imageView.rx.image)
        .disposed(by: disposeBag)
    }
    
    
    
    
    
    
    
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        //初始化图片控制器
//        let imagePicker = UIImagePickerController()
//
//        //判断并决定“z拍照”按钮是否可用
//        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
//
//        //“拍照”按钮点击
//        cameraButton.rx.tap.bind { [weak self] (_) -> Void in
//            imagePicker.sourceType = .camera    //来源为相机
//            imagePicker.allowsEditing = false   //不可编辑
//            //弹出控制器，显示界面
//            self?.present(imagePicker, animated: true)
//        }.disposed(by: disposeBag)
//
//        //“选择照片”按钮点击
//        galleryButton.rx.tap.bind { [weak self] (_) -> Void in
//            imagePicker.sourceType = .photoLibrary  //来源为相册
//            imagePicker.allowsEditing = false       //不可编辑
//            //弹出控制器，显示界面
//            self?.present(imagePicker, animated: true)
//        }.disposed(by: disposeBag)
//
//        //“选择照片并裁剪”按钮点击
//        cropButton.rx.tap.bind { [weak self] (_) -> Void in
//            imagePicker.sourceType = .photoLibrary  //来源为相册
//            imagePicker.allowsEditing = true        //不可编辑
//            //弹出控制器，显示界面
//            self?.present(imagePicker, animated: true)
//        }.disposed(by: disposeBag)
//
//        //图片选择完毕后，将其绑定到imageView上显示
//        imagePicker.rx.didFinishPickingMediaWithInfo
//            .map { info in
//                if imagePicker.allowsEditing {
//                    return info[UIImagePickerController.InfoKey.editedImage] as! UIImage
//
//                } else {
//                    return info[UIImagePickerController.InfoKey.originalImage] as! UIImage
//                }
//        }.bind(to: imageView.rx.image)
//        .disposed(by: disposeBag)
//
//
//        //图片选择完毕后，退出图片控制器
//        imagePicker.rx.didFinishPickingMediaWithInfo
//            .subscribe(onNext: { (_) in
//                imagePicker.dismiss(animated: true)
//            })
//            .disposed(by: disposeBag)
//
//    }
    
}
