//
//  ZJMerchantAccoutBookModel.swift
//  LittleBlackBear
//
//  Created by MichaelChan on 28/3/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit
import SwiftyJSON
class ZJMerchantAccoutBookModel: SNSwiftyJSONAble {
/*
     "name": "用户1",
     "payTotal": "1.00",
     "merchant_money": "+1.00",
     "add_time": "1521627728"
     */
    
    var name : String
    var payTotal : String
    var merchant_money : String
    var add_time : String
    
    required init?(jsonData: JSON) {
        name = jsonData["name"].stringValue
        payTotal = jsonData["payTotal"].stringValue
        merchant_money = jsonData["merchant_money"].stringValue
        add_time = jsonData["add_time"].stringValue
        
    }
}

class ZJMerchantAccoutBookJsonModel : SNSwiftyJSONAble{
    var merchantTotal : String
    var flowmeterTotal : String
    var list : [ZJMerchantAccoutBookModel]
    
    required init?(jsonData: JSON) {
        merchantTotal = jsonData["merchantTotal"].stringValue
        flowmeterTotal = jsonData["flowmeterTotal"].stringValue
        list = jsonData["list"].arrayValue.map({return ZJMerchantAccoutBookModel(jsonData: $0)!})
    }
}
