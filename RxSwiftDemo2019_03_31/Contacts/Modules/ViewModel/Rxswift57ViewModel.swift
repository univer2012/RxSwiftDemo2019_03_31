//
//  Rxswift57ViewModel.swift
//  RxSwiftDemo2019_03_31
//
//  Created by 远平 on 2019/11/10.
//  Copyright © 2019 远平. All rights reserved.
//


import RxSwift
import RxCocoa


//MARK:上下拉刷新的改进 - 用到是Observable
class Rxswift57ViewModel {
    
    //表格数据序列
    let tableData = BehaviorRelay<[String]>(value: [])
    
    //停止头部刷新状态
    let endHeaderRefreshing: Observable<Bool>
    
    //停止尾部刷新状态
    let endFooterRefreshing: Observable<Bool>
    
    //Rxswift57ViewModel初始化（根据输入实现对应的输出）
    init(input: (
        headerRefresh: Observable<Void>,
        footerRefresh: Observable<Void>
        ),
         dependency: (
        disposeBag:DisposeBag,
        networkService: Network57Service)) {
        
        //下拉结果序列
        let headerRefreshData = input.headerRefresh
            .startWith(()) //初始化是会先自动加载一次数据
            .flatMapLatest{ _ in
                dependency.networkService.getRandomResult()
                .takeUntil(input.footerRefresh)
            }.share(replay: 1)//让HTTP请求是被共享的
        
        
        //上拉结果序列
        let footerRefreshData = input.footerRefresh
            .flatMapLatest{ _ in
                dependency.networkService.getRandomResult()
                .takeUntil(input.headerRefresh)
        }.share(replay: 1)//让HTTP请求是被共享的
        
        //生成停止头部刷新状态序列
        //self.endHeaderRefreshing = headerRefreshData.map{ _ in true }
        self.endHeaderRefreshing = Observable.merge(
            headerRefreshData.map{ _ in true },
            input.footerRefresh.map{ _ in true }
        )
        
        //生成停止尾部加载刷新状态序列
        //self.endFooterRefreshing = footerRefreshData.map{ _ in true }
        self.endFooterRefreshing = Observable.merge(
            footerRefreshData.map{ _ in true },
            input.headerRefresh.map{ _ in true }
        )
        
        //下拉刷新时，直接将查询到的结果替换原数据
        headerRefreshData.subscribe(onNext: { (items) in
            self.tableData.accept(items)
        }).disposed(by: dependency.disposeBag)
        
        //上拉加载时，将查询到的结果拼接到元数据底部
        footerRefreshData.subscribe(onNext: { (items) in
            self.tableData.accept(self.tableData.value + items)
        }).disposed(by: dependency.disposeBag)
    }
}








#if false
//MARK:有上下拉刷新 - 用到是Driver
class Rxswift57ViewModel {
    
    //表格数据序列
    let tableData = BehaviorRelay<[String]>(value: [])
    
    //停止头部刷新状态
    let endHeaderRefreshing: Driver<Bool>
    
    //停止尾部刷新状态
    let endFooterRefreshing: Driver<Bool>
    
    //Rxswift57ViewModel初始化（根据输入实现对应的输出）
    init(input: (
        headerRefresh: Driver<Void>,
        footerRefresh: Driver<Void>
        ),
         dependency: (
        disposeBag:DisposeBag,
        networkService: Network56Service)) {
        
        //下拉结果序列
        let headerRefreshData = input.headerRefresh
        .startWith(()) //初始化是会先自动加载一次数据
            .flatMapLatest{ return dependency.networkService.getRandomResult() }
        
        //上拉结果序列
        let footerRefreshData = input.footerRefresh
            .flatMapLatest{ return dependency.networkService.getRandomResult() }
        
        //生成停止头部刷新状态序列
        self.endHeaderRefreshing = headerRefreshData.map{ _ in true }
        
        //生成停止尾部加载刷新状态序列
        self.endFooterRefreshing = footerRefreshData.map{ _ in true }
        
        //下拉刷新时，直接将查询到的结果替换原数据
        headerRefreshData.drive(onNext: { (items) in
            self.tableData.accept(items)
        }).disposed(by: dependency.disposeBag)
        
        //上拉加载时，将查询到的结果拼接到元数据底部
        footerRefreshData.drive(onNext: { (items) in
            self.tableData.accept(self.tableData.value + items)
        }).disposed(by: dependency.disposeBag)
    }
}
#endif






#if false
//MARK: 只有上拉 - 用到是Driver
class Rxswift57ViewModel {
    
    //表格数据序列
    let tableData = BehaviorRelay<[String]>(value: [])
    
    //停止刷新状态序列
    let endFooterRefreshing: Driver<Bool>
    
    //Rxswift57ViewModel初始化（根据输入实现对应的输出）
    init(footerRefresh: Driver<Void>,
         dependency: (
            disposeBag:DisposeBag,
        networkService: Network56Service)) {
        
        //上拉结果序列
        let footerRefreshData = footerRefresh
            .startWith(())
            .flatMapLatest { return dependency.networkService.getRandomResult() }
        
        //生成停止上拉加载刷新状态序列
        self.endFooterRefreshing = footerRefreshData.map{ _ in true }
        
        //上拉加载时，将查询到的结果拼接到元数据底部
        footerRefreshData.drive(onNext: { (items) in
            self.tableData.accept(self.tableData.value + items)
        }).disposed(by: dependency.disposeBag)
    }
}
#endif
