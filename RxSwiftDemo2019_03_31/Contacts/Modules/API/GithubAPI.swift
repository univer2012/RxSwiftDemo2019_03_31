//
//  GithubAPI.swift
//  RxSwiftDemo2019_03_31
//
//  Created by Mac on 2019/7/23.
//  Copyright © 2019 远平. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import RxCocoa

//初始化GitHub请求的provider
let GitHubProvider = MoyaProvider<GitHubAPI>()

/** 下面定义GitHub请求的endpoints（供provider使用）**/
//请求分类
public enum GitHubAPI {
    case repositories(String)  //查询资源库
}
//请求配置
extension GitHubAPI: TargetType {
    //服务器地址
    public var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
    //各个请求的具体路径
    public var path: String {
        switch self {
        case .repositories:
            return "/search/repositories"
        }
    }
    //请求类型
    public var method: Moya.Method {
        return .get
    }
    //请求任务事件（这里附带上参数）
    public var task: Task {
        print("发起请求")
        switch self {
        case .repositories(let query):
            var params: [String: Any] = [:]
            //FIXME:注意：这里写死了
            params["q"] = query //"al"
            params["sort"] = "stars"
            params["order"] = "desc"
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        default:
            return .requestPlain
        }
    }
    //是否执行Alamofire验证
    public var validate: Bool {
        return false
    }
    //这个就是做单元测试模拟的数据，只会在单元测试文件中有作用
    public var sampleData: Data {
        return "{}".data(using: .utf8)!
    }
    //请求头
    public var headers: [String : String]? {
        return nil
    }
    
}
