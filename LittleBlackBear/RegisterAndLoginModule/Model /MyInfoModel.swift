//
//  MyInfoModel.swift
//  LittleBlackBear
//
//  Created by Mac Pro on 2018/4/9.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit
import SwiftyJSON

class MyInfoModel: SNSwiftyJSONAble {
    
    /// 手机号码
    var phone : String
    
    /// 会员昵称
    var nickName : String
    
    /// 是否商家
    var isMer : String
    
    /// 是否代理商
    var isAgent : String
    
    /// 会员号
    var mercId : String
    
    
    required init?(jsonData: JSON) {
        
        self.phone = jsonData["phone"].stringValue
        self.nickName = jsonData["nickName"].stringValue
        self.isMer = jsonData["isMer"].stringValue
        self.isAgent = jsonData["isAgent"].stringValue
        self.mercId = jsonData["mercId"].stringValue

    }
    
    init(phone : String = "", nickName : String = "", isMer : String = "", isAgent : String = "",mercId : String = "") {
        self.phone = phone
        self.nickName = nickName
        self.isMer = isMer
        self.isAgent = isAgent
        self.mercId = mercId
      
    }
    
}
