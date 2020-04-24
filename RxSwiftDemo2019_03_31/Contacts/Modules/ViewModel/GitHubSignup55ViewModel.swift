//
//  GitHubSignup55ViewModel.swift
//  RxSwiftDemo2019_03_31
//
//  Created by 远平 on 2019/11/8.
//  Copyright © 2019 远平. All rights reserved.
//

import RxSwift
import RxCocoa

class GitHubSignup55ViewModel {
    
    //用户名验证结果
    let validatedUsername: Driver<ValidationResult>
    
    //密码验证结果
    let validatedPassword: Driver<ValidationResult>
    
    //再次输入密码验证结果
    let validatedPasswordRepeated: Driver<ValidationResult>
    
    //注册按钮是否可用
    let signupEnabled: Driver<Bool>
    /*MARK: 添加
     start*/
    //正在注册中
    let signingIn: Driver<Bool>
    /*end*/
    
    //注册结果
    let signupResult: Driver<Bool>
    
    //
    init(
        input: (
        username: Driver<String>,
        password: Driver<String>,
        repeatedPassword: Driver<String>,
        loginTaps: Signal<Void>
        ),
        dependency: (
        networkService: GitHubNetwork54Service,
        signupService: GitHubSignupService
        )) {
        
        //用户名验证
        validatedUsername = input.username
            .flatMapLatest{username in
                return dependency.signupService.validateUsername(username)
                    .asDriver(onErrorJustReturn: .failed(message: "服务器发生错误！"))
        }
        
        //用户名密码验证
        validatedPassword = input.password.map{password in
            return dependency.signupService.validatePassword(password)
        }
        
        //重复输入密码验证
        validatedPasswordRepeated = Driver.combineLatest(input.password, input.repeatedPassword, resultSelector: dependency.signupService.validRepeatedPassword)
        
        //注册按钮是否可用
        signupEnabled = Driver.combineLatest(
            validatedUsername,
            validatedPassword,
            validatedPasswordRepeated
        ) { username, password, repeatPassword in
            username.isValid && password.isValid && repeatPassword.isValid
            
            }.distinctUntilChanged()
        
        //获取最新的用户名和密码
        let usernameAndPassword = Driver.combineLatest(input.username, input.password) { (username: $0, password: $1) }
        /*MARK: 添加
         start*/
        let activityIndicator = ActivityIndicator()
        self.signingIn = activityIndicator.asDriver()
        /*end*/
        //注册按钮点击结果
        signupResult = input.loginTaps.withLatestFrom(usernameAndPassword)
            .flatMapLatest({ (pair) in
                return dependency.networkService
                    .signup(pair.username, password: pair.password)
                    /*MARK: 添加 -- start*/
                    .trackActivity(activityIndicator)   //把当前序列放入signing序列中进行检测
                    /*end*/
                    .asDriver(onErrorJustReturn: false)
            })
    }
}
