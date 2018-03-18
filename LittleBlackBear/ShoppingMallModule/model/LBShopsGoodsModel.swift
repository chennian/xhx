//
//  LBShopsGoodsModel.swift
//  LittleBlackBear
//
//  Created by Apple on 2018/1/17.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit
struct GoodsTypsModel:ResponeData{
    let status:String
    let remark:String
    let createBy:String
    let id:Int
    let updateTime:String
    let orgCode:String
    let typeName:String
    let createTime:String
    

    init(json: LBJSON) {
        status = json["status"].stringValue
        remark = json["remark"].stringValue
        createBy = json["createBy"].stringValue
        id = json["id"].intValue
        updateTime = json["updateTime"].stringValue
        typeName = json["typeName"].stringValue
        createTime = json["createTime"].stringValue
        orgCode = json["orgcode"].stringValue
        
    }
}
struct LBShopsGoodsModel:ResponeData{
    let total:Int
    let pages:Int
    let list:[LBShopsGoodsModelList]
    init(json: LBJSON) {
        total = json["total"].intValue
        pages = json["pages"].intValue
        list  = json["list"].arrayValue.flatMap{LBShopsGoodsModelList(json:$0)}
    }
    
    
    
}
struct LBShopsGoodsModelList:ResponeData {
    let orgCode:String
    let status:String
    let commoName:String
    let id:String
    let commoTypeId:String
    let recommendStatus:String
    let commoPrice:String
    let createTime:String
    let mainImg:LBShopsGoodsModelMainImg
    init(json: LBJSON) {
        orgCode = json["orgcode"].stringValue
        status = json["status"].stringValue
        commoName = json["commoName"].stringValue
        id = json["id"].stringValue
        commoTypeId = json["commoTypeId"].stringValue
        recommendStatus = json["recommendStatus"].stringValue
        commoPrice = json["commoPrice"].stringValue
        createTime = json["createTime"].stringValue
        mainImg = LBShopsGoodsModelMainImg(json:json["mainImg"])
        
    }

}
struct LBShopsGoodsModelMainImg:ResponeData {
    
    let status:String
    let imgUrl:String
    let id:String
    let commoId:String
    let type:String
    let createTime:String
    
    init(json: LBJSON) {
        status = json["status"].stringValue
        imgUrl = json["imgUrl"].stringValue
        id  = json["id"].stringValue
        commoId = json["commoId"].stringValue
        type = json["type"].stringValue
        createTime = json["createTime"].stringValue
    }
    
}

