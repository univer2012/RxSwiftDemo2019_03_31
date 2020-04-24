//
//  GitHubViewModel.swift
//  RxSwiftDemo2019_03_31
//
//  Created by Mac on 2019/7/23.
//  Copyright © 2019 远平. All rights reserved.
//

import Foundation

import RxSwift
import Result


#if true
//MARK: 改进后 GitHubNetworkService
class GitHubViewModel {
    
    /****  数据请求服务 *****/
    let networkService = GitHubNetworkService()
    
    /**** 输入部分 ***/
    //查询行为
    fileprivate let searchAction: Observable<String>
    
    /**** 输出部分 ***/
    //所有的查询结果
    let searchResult: Observable<GitHubRepositories>
    //查询结果里的资源列表
    let repositories: Observable<[GitHubRepository]>
    //清空结果动作
    let cleanResult: Observable<Void>
    //导航栏标题
    let navigationTitle: Observable<String>
    
    
    //ViewModel初始化（根据输入实现对应的输出）
    init(searchAction: Observable<String>) {
        self.searchAction = searchAction
        
        
        //生成查询结果序列
        self.searchResult = searchAction
            //TODO:注意，下方的filter，是【!$0.isEmpty】，不是【$0.isEmpty】,有【!】
            .filter { !$0.isEmpty }   //如果输入为空则不发送请求了
            .flatMapLatest(networkService.searchRepositories)
            .share(replay: 1)//让HTTP请求是被共享的
        
        //生成清空结果动作序列
        self.cleanResult = searchAction.filter { $0.isEmpty }
            .map{ _ in
                Void()
        }
        
        //生成查询结果里的资源列表序列（如果查询到结果则返回结果，如果是清空数据则返回空数组）
        ///Observable.of(<#T##elements: _...##_#>)
        self.repositories = Observable.of(searchResult.map{$0.items!},
                                          cleanResult.map{ [] }
                                         ).merge()
        
        //生成导航栏标题序列（如果查询到结果则返回数量，如果是清空数据则返回默认标题）
        self.navigationTitle = Observable.of(
            searchResult.map{ "共有 \($0.totalCount!) 个结果" },
            cleanResult.map{ "hangge.com" })
            .merge()
        
    }
}
#endif



//MARK:改进前 GitHubProvider
#if false
class GitHubViewModel {
    
    /**** 输入部分 ***/
    //查询行为
    fileprivate let searchAction: Observable<String>
    
    /**** 输出部分 ***/
    //所有的查询结果
    let searchResult: Observable<GitHubRepositories>
    //查询结果里的资源列表
    let repositories: Observable<[GitHubRepository]>
    //清空结果动作
    let cleanResult: Observable<Void>
    //导航栏标题
    let navigationTitle: Observable<String>
    
    
    //ViewModel初始化（根据输入实现对应的输出）
    init(searchAction: Observable<String>) {
        self.searchAction = searchAction
        
        
        //生成查询结果序列
        self.searchResult = searchAction
            //TODO:注意，下方的filter，是【!$0.isEmpty】，不是【$0.isEmpty】,有【!】
            .filter { !$0.isEmpty }   //如果输入为空则不发送请求了
            .flatMapLatest {
                
                GitHubProvider.rx.request(.repositories($0))
                .filterSuccessfulStatusCodes()
                .mapObject(GitHubRepositories.self)
                .asObservable()
                .catchError({ (error) in
                    print("发生错误：",error.localizedDescription)
                    return Observable<GitHubRepositories>.empty()
                })
                
            }.share(replay: 1)//让HTTP请求是被共享的
        
        //生成清空结果动作序列
        self.cleanResult = searchAction.filter { $0.isEmpty }
            .map{ _ in
                Void()
        }
        
        //生成查询结果里的资源列表序列（如果查询到结果则返回结果，如果是清空数据则返回空数组）
        ///Observable.of(<#T##elements: _...##_#>)
        self.repositories = Observable.of(searchResult.map{$0.items!},
                                          cleanResult.map{ [] }
                                         ).merge()
        
        //生成导航栏标题序列（如果查询到结果则返回数量，如果是清空数据则返回默认标题）
        self.navigationTitle = Observable.of(
            searchResult.map{ "共有 \($0.totalCount!) 个结果" },
            cleanResult.map{ "hangge.com" })
            .merge()
        
    }
}
#endif
