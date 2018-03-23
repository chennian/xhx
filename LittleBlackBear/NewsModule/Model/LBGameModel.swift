//
//  LBGameModel.swift
//  LittleBlackBear
//
//  Created by Apple on 2018/1/24.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

struct LBGameModel:ResponeData {
    
    let id:String
    let markTitle:String
    let markSubhead:String
    let disAmount:String
    let disRate:String
    let minAmount:String
    let validStartDate:String
    let validEndDate:String
    let markExplain:String
    let markType:String
    let useScope:String
    
    
    let merName:String
    let logo:String

    init(json: LBJSON) {
        
        merName = json["merName"].stringValue
        logo = json["logo"].stringValue
        
        let json = json["merMarkActivit"]
        id = json["id"].stringValue
        markTitle = json["markTitle"].stringValue
        disAmount = json["disAmount"].stringValue
        disRate = json["disRate"].stringValue
        minAmount = json["minAmount"].stringValue
        validStartDate = json["validStartDate"].stringValue
        validEndDate = json["validEndDate"].stringValue
        markExplain = json["markExplain"].stringValue
        markType = json["markExplain"].stringValue
        useScope = json["markExplain"].stringValue
        markSubhead = json["markSubhead"].stringValue

    }
}
