//
//  YXNativeRouterConstant.swift
//  RxSwiftDemo2019_03_31
//
//  Created by blue on 2020/9/10.
//  Copyright © 2020 远平. All rights reserved.
//

import Foundation

// 伪Scheme
// 并未遵循苹果官方Scheme规范，因为直接使用UIApplication直接无法打开这个伪Scheme的Url
public let YXZQ_SCHEME = "yxzq_goto://"


/*
 个股详情页
 带参数market和code；market和code参数必须的，没有不会跳转
 例如：yxzq_goto://stock_quote?market=sh&code=600837
 */
public let GOTO_STOCK_QUOTE = YXZQ_SCHEME + "stock_quote"

/*
 入金
 例如：yxzq_goto://deposit
 */
public let GOTO_DEPOSIT = YXZQ_SCHEME + "deposit"

/*
 出金
 例如：yxzq_goto://withdrawal
 */
public let GOTO_WITHDRAWAL = YXZQ_SCHEME + "withdrawal"

/*
 用户登录
 例如：yxzq_goto://user_login
 */
public let GOTO_USER_LOGIN = YXZQ_SCHEME + "user_login"

/*
 交易登录
 例如：yxzq_goto://trade_login
 */
public let GOTO_TRADE_LOGIN = YXZQ_SCHEME + "trade_login"

/*
 自选股行情页
 例如：yxzq_goto://main_optstocks
 */
public let GOTO_MAIN_OPTSTOCKS = YXZQ_SCHEME + "main_optstocks"

/*
 港股市场行情页
 例如：yxzq_goto://main_hkmarket
 */
public let GOTO_MAIN_HKMARKET = YXZQ_SCHEME + "main_hkmarket"

/*
 美股市场行情页
 例如：yxzq_goto://main_usmarket
 */
public let GOTO_MAIN_USMARKET = YXZQ_SCHEME + "main_usmarket"

/*
 沪深市场行情页
 例如：yxzq_goto://main_hsmarket
 */
public let GOTO_MAIN_HSMARKET = YXZQ_SCHEME + "main_hsmarket"

/*
 资讯主页
 例如：yxzq_goto://main_info
 */
public let GOTO_MAIN_INFO = YXZQ_SCHEME + "main_info"

/*
 交易菜单页
 例如：yxzq_goto://main_trade
 */
public let GOTO_MAIN_TRADE = YXZQ_SCHEME + "main_trade"

/*
 课程主页
 例如：yxzq_goto://main_info
 */
public let GOTO_MAIN_INFO_COURSE = YXZQ_SCHEME + "main_info_course"

/*
 打开资讯-课程-我的课程
 例如：yxzq_goto://main_info_my_course
 */
public let GOTO_MAIN_INFO_MY_COURSE = YXZQ_SCHEME + "main_info_my_course"

/*
 “我的”菜单页
 例如：yxzq_goto://main_personal
 */
public let GOTO_MAIN_PERSONAL = YXZQ_SCHEME + "main_personal"

/*
 开户
 例如：yxzq_goto://open_account
 */
public let GOTO_OPEN_ACCOUNT = YXZQ_SCHEME + "open_account"

/*
 消息中心
 例如：yxzq_goto://message_center
 */
public let GOTO_MESSAGE_CENTER = YXZQ_SCHEME + "message_center"

/*
 消息中心-消息详情
 例如：yxzq_goto://message_detail
 */
public let GOTO_MESSAGE_DETAIL = YXZQ_SCHEME + "message_detail"

/*
 交易股票
 可带参数market和code，也可不带
 例如：yxzq_goto://stock_trade?market=sh&code=600837
 */
public let GOTO_STOCK_TRADE = YXZQ_SCHEME + "stock_trade"

/*
 Native Webview页面
 可带参数title和url
 例如：yxzq_goto://webview?title=xxx&url=xxx
 */
public let GOTO_WEBVIEW = YXZQ_SCHEME + "webview"

/*
 资讯详情页面
 可带参数title、type和newsid
 例如：yxzq_goto://info_detail?type=x&title=xxx&newsid=xxxxx
 */
public let GOTO_INFO_DETAIL = YXZQ_SCHEME + "info_detail"

/*
 历史记录页面
 可带参数type
 0: 全部类型
 1：入金
 2：出金
 3：货币兑换
 例如：yxzq_goto://fund_history_record?type=0
 */
public let GOTO_FUND_HISTORY_RECORD = YXZQ_SCHEME + "fund_history_record"

/*
 跳转意见反馈页面
 */
public let GOTO_FEEDBACK = YXZQ_SCHEME + "feedback"

/*
 电话
 带参数phoneNumber
 例如：yxzq_goto://tel?phoneNumber=4008880808
 */
public let GOTO_TEL = YXZQ_SCHEME + "tel"

/*
 在线客服
 例如：yxzq_goto://customer_service
 */
public let GOTO_CUSTOMER_SERVICE = YXZQ_SCHEME + "customer_service"


/*
 智能盯盘
 例如：yxzq_goto://smart_monitor
 */
public let GOTO_SMART_MONITOR = YXZQ_SCHEME + "smart_monitor"

/*
 交易订单
 例如：yxzq_goto://smart_monitor
 */
public let GOTO_ORDER_RECORD = YXZQ_SCHEME + "order_record"

/*
 IPO首页
 例如：yxzq_goto://ipo_center
 */
public let GOTO_IPO_CENTER = YXZQ_SCHEME + "ipo_center"

/*
 IPO详情页
 例如：yxzq_goto://ipo_detail
 */
public let GOTO_IPO_DETAIL = YXZQ_SCHEME + "ipo_detail"

/*
 IPO认购下单页
 例如：yxzq_goto://ipo_purchase_order
 */
public let GOTO_IPO_PURCHASE_ORDER = YXZQ_SCHEME + "ipo_purchase_order"

/*
 IPO购买记录
 例如：yxzq_goto://ipo_purchase_list
 */
public let GOTO_IPO_PURCHASE_LIST = YXZQ_SCHEME + "ipo_purchase_list"

/*
 首页股王页面
 例如：yxzq_goto://main_stockking
 */
public let GOTO_MAIN_STOCKKING = YXZQ_SCHEME + "main_stockking"

/*
 首页动态页面
 例如：yxzq_goto://main_moments
 */
public let GOTO_MAIN_MOMENTS = YXZQ_SCHEME + "main_moments"

/*
 持仓列表页
 例如：yxzq_goto://hold_position
 */
public let GOTO_HOLD_POSITION = YXZQ_SCHEME + "hold_position"

/*
 转股列表
 例如：yxzq_goto://conversion_record
 */
public let GOTO_CONVERSION_RECORD = YXZQ_SCHEME + "conversion_record"

/*
 换汇页
 例如：yxzq_goto://currency_exchange
 */
public let GOTO_CURRENCY_EXCHANGE = YXZQ_SCHEME + "currency_exchange"

/*
 交易tab今日订单
 例如：yxzq_goto://today_order
 */
public let GOTO_TRADE_TODAYORDER = YXZQ_SCHEME + "today_order"

/*
 基金tab
 例如：yxzq_goto://main_fund
 */
public let GOTO_MAIN_FUND = YXZQ_SCHEME + "main_fund"

/*
 新股认购记录详情页
 例如：yxzq_goto://purchase_record_detail
 */
public let GOTO_NEWSTOCK_PURCHASE_DETAIL = YXZQ_SCHEME + "purchase_record_detail"

