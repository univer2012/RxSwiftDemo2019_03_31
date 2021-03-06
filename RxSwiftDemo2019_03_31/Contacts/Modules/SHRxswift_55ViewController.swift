//
//  SHRxswift_55ViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by 远平 on 2019/11/8.
//  Copyright © 2019 远平. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SHRxswift_55ViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    //用户名输入框、以及验证结果显示标签
    @IBOutlet weak var usernameOutlet: UITextField!
    @IBOutlet weak var usernameValidationOutlet: UILabel!
    
    //密码输入框、以及验证结果显示标签
    @IBOutlet weak var passwordOutlet: UITextField!
    @IBOutlet weak var passwordValidationOutlet: UILabel!
    
    //重复密码输入框、以及验证结果显示标签
    @IBOutlet weak var repeatedPasswordOutlet: UITextField!
    @IBOutlet weak var repeatedPasswordValidationOutlet: UILabel!
    
    //注册按钮
    @IBOutlet weak var signupOutlet: UIButton!
    
    //注册时的活动指示器
    @IBOutlet weak var signInActivityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //初始化ViewModel
        let viewModel = GitHubSignup55ViewModel(
            input: (username: usernameOutlet.rx.text.orEmpty.asDriver(),
                    password: passwordOutlet.rx.text.orEmpty.asDriver(),
                    repeatedPassword: repeatedPasswordOutlet.rx.text.orEmpty.asDriver(),
                    loginTaps: signupOutlet.rx.tap.asSignal()
            ), dependency: (
                networkService: GitHubNetwork54Service(),
                signupService: GitHubSignupService()
            )
        )
        
        //用户名验证结果绑定
        viewModel.validatedUsername
            .drive(usernameValidationOutlet.rx.validateionResult)
            .disposed(by: disposeBag)
        
        //密码验证结果绑定
        viewModel.validatedPassword
            .drive(passwordValidationOutlet.rx.validateionResult)
            .disposed(by: disposeBag)
        
        //再次输入密码验证结果绑定
        viewModel.validatedPasswordRepeated
            .drive(repeatedPasswordValidationOutlet.rx.validateionResult)
            .disposed(by: disposeBag)
        
        //注册按钮是否可用
        viewModel.signupEnabled
            .drive(onNext: {[weak self] (valid) in
                self?.signupOutlet.isEnabled = valid
                self?.signupOutlet.alpha = valid ? 1.0 : 0.3
            }).disposed(by: disposeBag)
        
        /*MARK: 添加 - start*/
        //创建一个指示器
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        
        //当前是否正在注册，觉得指示器是否显示
        viewModel.signingIn
            .map{ !$0 }
            .drive(hud.rx.isHidden)
            .disposed(by: disposeBag)
        /*end*/
        
        //注册结果绑定
        viewModel.signupResult
            .drive(onNext: { (result) in
                self.showMessage("注册" + (result ? "成功" : "失败") + "!")
            })
            .disposed(by: disposeBag)
        
        
    }
    
//    func showMessage(_ message: String) {
//        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
//        let okAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
//        alertController.addAction(okAction)
//        self.present(alertController, animated: true, completion: nil)
//    }
}


///*MARK: 添加 - start*/
////当前是否正在注册
//viewModel.signingIn
//    .drive(signInActivityIndicator.rx.isAnimating)
//    .disposed(by: disposeBag)
///*end*/





///*MARK: 添加 - start*/
////当前是否正在注册
//viewModel.signingIn
//    .drive(UIApplication.shared.rx.isNetworkActivityIndicatorVisible)
//    .disposed(by: disposeBag)
///*end*/


