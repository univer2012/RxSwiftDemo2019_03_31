//
//  DoubanObject.swift
//  RxSwiftDemo2019_03_31
//
//  Created by 远平 on 2019/7/17.
//  Copyright © 2019 远平. All rights reserved.
//

import Foundation

import ObjectMapper

#if false
//MARK: RxAlamofire --> Douban 模型
///文章位置：46（结合RxAlamofire使用2：结果处理、模型转换）
///豆瓣接口模型
class Douban: Mappable {
    var channels: [Channel]?
    init() {
    }
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        channels <- map["channels"]
    }
}
//频道模型
class Channel: Mappable {
    var name: String?
    var nameEn: String?
    var channelId: String?
    var seqId: Int?
    var abbrEn: String?
    init() { }
    required init(map:Map) {}
    
    //Mappable
    func mapping(map: Map) {
        name <- map["name"]
        nameEn <- map["name_en"]
        channelId <- map["channel_id"]
        seqId <- map["seq_id"]
        abbrEn <- map["abbr_en"]
    }
}
//歌曲列表模型
struct Playlist: Mappable {
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        r <- map["r"]
        isShowQuickStart <- map["is_show_quick_start"]
        song <- map["song"]
    }
    
    var r: Int!
    var isShowQuickStart: Int!
    var song:[Song]!
}
//歌曲模型
struct Song: Mappable {
    var title: String!
    var singers: [Singers]!
    init?(map: Map) { }
    
    // Mappable
    mutating func mapping(map: Map) {
        title <- map["title"]
        singers <- map["singers"]
    }
}
//歌手模型
struct Singers {
    var style: Array<String>!
    var name: String!
    var region: Array<String>!
    var name_usual: String!
    var genre: Array<String>!
    var avatar: String!
    var related_site_id: Int!
    var is_site_artist: Bool!
    var id: String!
    
    init?(map: Map) { }
    
    // Mappable
    mutating func mapping(map: Map) {
        style <- map["style"]
        name <- map["name"]
        region <- map["region"]
        name_usual <- map["name_usual"]
        genre <- map["genre"]
        avatar <- map["avatar"]
        related_site_id <- map["related_site_id"]
        is_site_artist <- map["is_site_artist"]
        id <- map["id"]
    }
}

#endif
