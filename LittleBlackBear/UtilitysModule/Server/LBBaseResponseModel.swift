//
//  LBBaseResponseModel.swift
//  LittleBlackBear
//
//  Created by 蘇崢 on 2017/6/27.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit
import SwiftyJSON
typealias LBJSON = JSON
protocol ResponeData {
	init(json:LBJSON)
}
protocol ResponseModel:ResponeData {
	
	associatedtype T:ResponeData
	var code:String{get}
	var message:String{get}
	var detail:T{get}
	
}

struct LBResponseModel:ResponeData {
	let code: String
	let message: String
	init(json: LBJSON) {
		code = json["RSPCOD"].stringValue
		message = json["RSPMSG"].stringValue
		Print(json)
	}
}
struct LBBaseResponeModel:ResponeData {
	init(json: LBJSON) {
	}
}
struct LBFailModel{
	
	let status:Bool
	let code:String
	let message:String
	
	init(status:Bool,code:String,message:String) {
		self.code = code
		self.message = message
		self.status = status
	}
	
	
}
