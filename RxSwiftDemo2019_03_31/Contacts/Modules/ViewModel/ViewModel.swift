//
//  ViewModel.swift
//  RxSwiftDemo2019_03_31
//
//  Created by Mac on 2019/11/7.
//  Copyright © 2019 远平. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

//MARK: 改进后 Driver -- GitHubNetworkService
class ViewModel {
    
    /****  数据请求服务 *****/
    let networkService = GitHubNetworkService()

    /**** 输入部分 ***/
    //查询行为
    fileprivate let searchAction: Driver<String>
    
    /**** 输出部分 ***/
    //所有的查询结果
    let searchResult: Driver<GitHubRepositories>
    //查询结果里的资源列表
    let repositories: Driver<[GitHubRepository]>
    //清空结果动作
    let cleanResult: Driver<Void>
    //导航栏标题
    let navigationTitle: Driver<String>
    
    
    //ViewModel初始化（根据输入实现对应的输出）
    init(searchAction: Driver<String>) {
        self.searchAction = searchAction
        
        
        //生成查询结果序列
        self.searchResult = searchAction
            //TODO:注意，下方的filter，是【!$0.isEmpty】，不是【$0.isEmpty】,有【!】
            .filter { !$0.isEmpty }   //如果输入为空则不发送请求了
            .flatMapLatest(networkService.searchRepositories)
            
        
        //生成清空结果动作序列
        self.cleanResult = searchAction.filter { $0.isEmpty }.map{ _ in
                Void()
        }
        
        //生成查询结果里的资源列表序列（如果查询到结果则返回结果，如果是清空数据则返回空数组）
        self.repositories = Driver.merge(searchResult.map{$0.items},
                                         cleanResult.map{[]}
        )
        
        //生成导航栏标题序列（如果查询到结果则返回数量，如果是清空数据则返回默认标题）
        self.navigationTitle = Driver.merge(
            searchResult.map{ "共有 \($0.totalCount!) 个结果" },
            cleanResult.map{ "hangge.com" }
        )
        
    }
}







#if false
//MARK: 改进前 Driver -- GitHubProvider
class ViewModel {

    /**** 输入部分 ***/
    //查询行为
    fileprivate let searchAction: Driver<String>
    
    /**** 输出部分 ***/
    //所有的查询结果
    let searchResult: Driver<GitHubRepositories>
    //查询结果里的资源列表
    let repositories: Driver<[GitHubRepository]>
    //清空结果动作
    let cleanResult: Driver<Void>
    //导航栏标题
    let navigationTitle: Driver<String>
    
    
    //ViewModel初始化（根据输入实现对应的输出）
    init(searchAction: Driver<String>) {
        self.searchAction = searchAction
        
        
        //生成查询结果序列
        self.searchResult = searchAction
            //TODO:注意，下方的filter，是【!$0.isEmpty】，不是【$0.isEmpty】,有【!】
            .filter { !$0.isEmpty }   //如果输入为空则不发送请求了
            .flatMapLatest{
                GitHubProvider.rx.request(.repositories($0))
                    .filterSuccessfulStatusCodes()
                    .mapObject(GitHubRepositories.self)
                    .asDriver(onErrorDriveWith: Driver.empty())
        }
            
        
        //生成清空结果动作序列
        self.cleanResult = searchAction.filter { $0.isEmpty }.map{ _ in
                Void()
        }
        
        //生成查询结果里的资源列表序列（如果查询到结果则返回结果，如果是清空数据则返回空数组）
        self.repositories = Driver.merge(searchResult.map{$0.items},
                                         cleanResult.map{[]}
        )
        
        //生成导航栏标题序列（如果查询到结果则返回数量，如果是清空数据则返回默认标题）
        self.navigationTitle = Driver.merge(
            searchResult.map{ "共有 \($0.totalCount!) 个结果" },
            cleanResult.map{ "hangge.com" }
        )
        
    }
}
#endif
