//
//  SNSwiftyJSONAble.swift
//  zhipinhui
//
//  Created by 朱楚楠 on 2017/10/3.
//  Copyright © 2017年 Spectator. All rights reserved.
//

import UIKit
import SwiftyJSON
import Moya

public protocol SNSwiftyJSONAble {
    init?(jsonData:JSON)
}

protocol JSONMappableTargetType: TargetType {
    var responseType: SNSwiftyJSONAble.Type { get }
}

let MOYA_RESULT_CODE = "RSPCOD"
let MOYA_RESULT_MSG = "RSPMSG"
let MOYA_RESULT_DATA = "RSPDATA"
