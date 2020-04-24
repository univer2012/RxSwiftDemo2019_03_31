//
//  GitHubNetworkService.swift
//  RxSwiftDemo2019_03_31
//
//  Created by Mac on 2019/11/7.
//  Copyright © 2019 远平. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa
import ObjectMapper

//MARK: Driver
class GitHubNetworkService {
    
    //搜索资源数据
    func searchRepositories(query: String) -> Driver<GitHubRepositories> {
        
        return GitHubProvider.rx.request(.repositories(query))
            .filterSuccessfulStatusCodes()
            .mapObject(GitHubRepositories.self)
            .asDriver(onErrorDriveWith: Driver.empty())
        
    }
}




#if false
//MARK: Observer
class GitHubNetworkService {
    //搜索资源数据
    func searchRepositories(query: String) -> Observable<GitHubRepositories> {
        return GitHubProvider.rx.request(.repositories(query))
            .filterSuccessfulStatusCodes()
            .mapObject(GitHubRepositories.self)
            .asObservable()
            .catchError { (error) -> Observable<GitHubRepositories> in
                print("发生错误：",error.localizedDescription)
                return Observable<GitHubRepositories>.empty()
        }

    }

}
#endif
