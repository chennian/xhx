//
//  LBMapModel.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/12/21.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

// 商家位置model
struct LBMapModel<mapDetailModel>:ResponseModel where mapDetailModel:ResponeData {
    typealias T = mapDetailModel
    let code: String
    let message: String
    let detail: T
    init(json: LBJSON) {
        code = json["RSPCOD"].stringValue
        message = json["RSPMSG"].stringValue
        detail = mapDetailModel(json:json["detail"])
    }
    
}
struct mapDetailModel:ResponeData {
    let pageNum:String
    let pageSize:String
    let size:String
    let startRow:String
    let endRow:String
    let total:String
    let pages:String
    let list:[LBJSON]
    init(json: LBJSON) {
        pageNum  = json["pageNum"].stringValue
        pageSize = json["pageSize"].stringValue
        size = json["size"].stringValue
        startRow = json["startRow"].stringValue
        endRow = json["endRow"].stringValue
        total = json["total"].stringValue
        pages = json["pages"].stringValue
        list = json["list"].arrayValue
    }
}
struct mapDetailListModel<mapLocation>:ResponeData where mapLocation: ResponeData {
    typealias T = mapLocation
    
    let status:String
    let uid:Int
    let geotabelId:String
    
    let address:String
    let province:String
    let city:String
    let district:String
    
    let coord_type:Int
    let tags:String
    let distance:String
    let weight:String
    let mainImgUrl:String
    let headImgUrl:String
    let orgcode:String
    let companyName:String
    
    let location:T
    
    init(json: LBJSON) {
        
        status  = json["status"].stringValue
        uid  = json["uid"].intValue
        geotabelId  = json["geotabelId"].stringValue
        
        address  = json["address"].stringValue
        province = json["province"].stringValue
        city  = json["city"].stringValue
        district   = json["district"].stringValue
        
        coord_type = json["coord_type"].intValue
        tags = json["tags"].stringValue
        distance   = json["distance"].stringValue
        weight   = json["weight"].stringValue
        orgcode  = json["orgcode"].stringValue
        mainImgUrl = json["mainImgUrl"].stringValue
        headImgUrl = json["headImgUrl"].stringValue

        companyName  = json["companyName"].stringValue
        location = mapLocation(json: json["location"])
    }
    
}
struct mapLocation:ResponeData {
    
    let longidute:String
    let latitude:String
    init(json: LBJSON) {
        longidute = (json.arrayValue.first?.stringValue)!
        latitude = (json.arrayValue.last?.stringValue)!
        
    }
}

// 红包model
struct redPacketModel:ResponeData{
    
    
    let code: String
    let message: String
    let lbsCloudSers:[redPacketLBSCloudServerModel<redPacketLocation>]
    let redPackets:[redPacketInfoModel]
    
    init(json: LBJSON) {
        code = json["RSPCOD"].stringValue
        message = json["RSPMSG"].stringValue
        lbsCloudSers = json["detail"].arrayValue.map{redPacketLBSCloudServerModel<redPacketLocation>(json: $0["lbsCloudSer"])}
        redPackets = json["detail"].arrayValue.map{redPacketInfoModel(json:$0["redPacket"])}
    }
}
struct redPacketLBSCloudServerModel<redPacketLocation>:ResponeData where redPacketLocation:ResponeData{
    
    typealias T = redPacketLocation
    let location: T
    let uid:String
    let province:String
    let tags:String
    let weight:String
    let geotable_id:String
    let title:String
    let orgcode:String
    let address:String
    let city:String
    let companyName:String
    let district:String
    let distance:String
    let status:String
    let coord_type:String
    init(json: LBJSON) {
        location = redPacketLocation(json: json["location"])
        uid = json["uid"].stringValue
        province = json["province"].stringValue
        tags = json["tags"].stringValue
        weight = json["weight"].stringValue
        geotable_id = json["geotable_id"].stringValue
        title = json["title"].stringValue
        orgcode = json["orgcode"].stringValue
        address = json["address"].stringValue
        city = json["city"].stringValue
        companyName = json["companyName"].stringValue
        district = json["district"].stringValue
        distance = json["distance"].stringValue
        status = json["status"].stringValue
        coord_type = json["coord_type"].stringValue
        
    }
}
struct redPacketInfoModel:ResponeData{
    
    let mercId:String
    let redAmount:String
    let status:String
    let id:Int// 红包id
    let openTime:String
    let updateTime:String
    let orgcode:String
    let merShareRecordId:String
    let type:String
    let requestId:String
    let createTime:String
    let mainImgUrl:String
    init(json: LBJSON) {
        mercId = json["mercId"].stringValue
        redAmount = json["redAmount"].stringValue
        status = json["status"].stringValue
        id = json["id"].intValue
        openTime = json["openTime"].stringValue
        updateTime = json["updateTime"].stringValue
        orgcode = json["orgcode"].stringValue
        merShareRecordId = json["merShareRecordId"].stringValue
        type = json["type"].stringValue
        requestId = json["requestId"].stringValue
        createTime = json["createTime"].stringValue
        
        mainImgUrl = json["mainImgUrl"].stringValue

    }
}
struct redPacketLocation:ResponeData {
    
    let longidute:String
    let latitude:String
    init(json: LBJSON) {
        
        longidute = json.arrayValue.first?.stringValue ?? ""
        latitude  = json.arrayValue.last?.stringValue ?? ""
        
    }
}

