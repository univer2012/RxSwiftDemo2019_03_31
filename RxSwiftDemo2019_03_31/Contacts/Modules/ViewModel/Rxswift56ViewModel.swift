//
//  Rxswift56ViewModel.swift
//  RxSwiftDemo2019_03_31
//
//  Created by Mac on 2019/11/8.
//  Copyright © 2019 远平. All rights reserved.
//

import RxSwift
import RxCocoa

class Rxswift56ViewModel {
    
    //表格数据序列
    let tableData: Driver<[String]>
    
    //停止刷新状态序列
    let endHeaderRefreshing: Driver<Bool>
    
    //Rxswift56ViewModel初始化（根据输入实现对应的输出）
    init(headerRefresh: Driver<Void>) {
        
        //网络请求服务
        let networkService = Network56Service()
        
        //生成查询结果l序列
        self.tableData = headerRefresh
        .startWith(())
        .flatMapLatest{_ in networkService.getRandomResult() }
        
        //生成停止刷新状态序列
        self.endHeaderRefreshing = self.tableData.map{ _ in true}
    }
}
