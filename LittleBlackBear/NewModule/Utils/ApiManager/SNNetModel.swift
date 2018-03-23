//
//  SNNetModel.swift
//  zhipinhui
//
//  Created by 朱楚楠 on 2017/10/18.
//  Copyright © 2017年 Spectator. All rights reserved.
//

import UIKit
import SwiftyJSON

public class SNNetModel: SNSwiftyJSONAble {
    
    let code : String
    let msg : String
    let data : JSON?
    
    required public init?(jsonData: JSON) {
        self.code = jsonData[MOYA_RESULT_CODE].stringValue
        self.msg = jsonData[MOYA_RESULT_MSG].stringValue
        let oda = jsonData[MOYA_RESULT_DATA].object
        self.data = JSON(oda)
    }
    

}


extension SNNetModel : CustomStringConvertible {
    public var description: String {
        return "SNNetModel code -- \(code), msg -- \(msg)"
    }
}
