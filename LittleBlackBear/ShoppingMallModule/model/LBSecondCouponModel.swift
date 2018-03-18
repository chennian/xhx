//
//  LBSecondCouponModel.swift
//  LittleBlackBear
//
//  Created by Apple on 2018/1/11.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit
struct LBSecondCouponDetailModel:ResponeData {
    
    let id:String
    let createBy:String
    let state:String
    let valiDate:String
    let unusedCount:String
    let dueCount:String
    let mainImgUrl:String
    let headImgUrl:String
    let orgcode:String
    let markId:String
    let cardNum:String
    let commList:[LBSecondCouponDetailCommListModel]
    let markInfo:LBSecondCouponDetailMarkInfoModel
    
    
    init(json: LBJSON) {
        
        id = json["id"].stringValue
        createBy = json["createBy"].stringValue
        
        state = json["state"].stringValue
        valiDate = json["valiDate"].stringValue
        unusedCount = json["unusedCount"].stringValue
        
        dueCount = json["dueCount"].stringValue
        mainImgUrl = json["mainImgUrl"].stringValue
        headImgUrl = json["headImgUrl"].stringValue
        
        orgcode = json["orgcode"].stringValue
        markId = json["markId"].stringValue
        cardNum = json["cardNum"].stringValue
        
        markInfo = LBSecondCouponDetailMarkInfoModel(json:json["markInfoVO"])
        commList = json["commList"].arrayValue.flatMap{LBSecondCouponDetailCommListModel(json:$0)}

    }
}
struct LBSecondCouponDetailMarkInfoModel:ResponeData{
    
    let id:String
    let orgcode:String
    let markType:String
    let markTitle:String
    let markSubhead:String
    let markNum:String
    let disAmount:String
    let disRate:Float
    let minAmount:String
    let validStartDate:String
    let validEndDate:String
    let markExplain:String
    let useScope:Int
    let shopCompanyName:String
    let mercId:String
    let textH:CGFloat
   

    init(json:LBJSON) {
        
        id = json["id"].stringValue
        orgcode = json["orgcode"].stringValue
        mercId = json["mercId"].stringValue
        
        markTitle = json["markTitle"].stringValue
        markSubhead = json["markSubhead"].stringValue
        markNum = json["markNum"].stringValue
        
        disAmount = json["disAmount"].stringValue
        disRate = json["disRate"].floatValue
        minAmount = json["minAmount"].stringValue
        
        validStartDate = json["validStartDate"].stringValue
        validEndDate = json["validEndDate"].stringValue
        markExplain = json["markExplain"].stringValue
        
        useScope = json["useScope"].intValue
        shopCompanyName = json["shopCompanyName"].stringValue
        
        
        switch json["markType"].intValue {
        case 0,3:
            markType = "代金券"
        case 1,4:
            markType = "折扣券"
        case 2:
            markType = "团购券"
        default:
            markType = ""
        }
        let size = CGSize(width:KSCREEN_WIDTH-28, height: CGFloat(MAXFLOAT))
       textH = markExplain.boundingRect(with: size,
                                         options: .usesLineFragmentOrigin,
                                         attributes: [NSFontAttributeName: FONT_26PX],
                                         context: nil).size.height
        }
}
struct LBSecondCouponDetailCommListModel:ResponeData{
    
    let commoName:String
    let commoPicUrl:String
    let commoPrice:String
    init(json:LBJSON) {
        
        commoName = json["commoName"].stringValue
        commoPicUrl = json["commoPicUrl"].stringValue
        commoPrice = json["commoPrice"].stringValue

    }
}






