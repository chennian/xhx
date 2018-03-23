//
//  VaporTestModel.swift
//  zhipinhui
//
//  Created by 朱楚楠 on 2017/10/7.
//  Copyright © 2017年 Spectator. All rights reserved.
//

import UIKit
import SwiftyJSON

class VaporTestModel: SNSwiftyJSONAble {
    
    let code : Int
    let msg : String
    let data : String
    
    required init?(jsonData: JSON) {
        self.code = jsonData["code"].intValue
        self.msg = jsonData["msg"].stringValue
        self.data = jsonData["data"].stringValue
    }
}

extension VaporTestModel : CustomStringConvertible {
    var description: String {
        return "the model result code is \(code), and data is string type for value -- \(data), result message is -- \(msg)"
    }
}
