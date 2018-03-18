//
//  LBCouponDetailModel.swift
//  LittleBlackBear
//
//  Created by Apple on 2018/1/11.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

struct LBMoreCouponModel: ResponeData{
    typealias T = LBMerMarkListModel
    let pages:Int
    let pageNum:Int
    let lastPage:Int
    let isLastPage:String
    let total:Int
    let list:[T]
    init(json: LBJSON) {
        
        list = json["list"].arrayValue.flatMap{T(json:$0)}
        pages = json["pages"].intValue
        pageNum = json["pageNum"].intValue
        lastPage = json["lastPage"].intValue
        isLastPage = json["isLastPage"].stringValue
        total = json["total"].intValue
        
    }
    
}

