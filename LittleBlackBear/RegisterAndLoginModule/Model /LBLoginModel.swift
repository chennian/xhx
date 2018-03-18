//
//  LBLoginModel.swift
//  LittleBlackBear
//
//  Created by 蘇崢 on 2017/11/24.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

struct LBLoginModel<loginDetail>: ResponseModel where loginDetail:ResponeData {
    
	typealias T = loginDetail
	let code: String
	let message: String
	let detail: T
    
	init(json: LBJSON) {
        
		code = json["RSPCOD"].stringValue
		message = json["RSPMSG"].stringValue
		detail = loginDetail(json: json["detail"])

	}
}

struct loginDetail:ResponeData {
	
	let mercStatus:String // 商户状态
	let first_Trans_Status:String // 第一次交易状态 0交易成功 1未进行交易
	let userStatus:String // 实名认证状态-1:审核未通过 0:提交已通过 1已提交待认证 2未提交 3银行卡信息已提交
	let userName:String
	let logNum:String // 是否首次  0首次 （暂时不用）
	let recommendNum:String // 推荐人数
	let agentId:String // 代理商Id
	let noticeMSg:String // （暂时不用）
	let rate:String // 费率
	let phoneNum:String
	let oemId:String //
	let agentLevel:String // 代理等级
	let isMerc:String // 是否是商家
	let mercNum:String // == userId 商户Id
    let isAgent:String // 是否是代理
    let headImgUrl:String
    
	init(json: LBJSON) {
		
		mercStatus = json["MERSTS"].stringValue
		first_Trans_Status = json["TXNSTS"].stringValue
		userStatus = json["STS"].stringValue
		userName = json["ACTNAM"].string ?? "匿名用户"
		logNum = json["logNum"].stringValue
		recommendNum = json["EXTENDCOUNT"].stringValue
		agentId = json["agentId"].stringValue
		noticeMSg = json["NOTICEMESSAGE"].stringValue
		rate = json["NOCARDFEERATE"].stringValue
		phoneNum = json["PHONENUMBER"].stringValue
		oemId = json["OEMID"].stringValue
		agentLevel = json["agentLevel"].stringValue
		isMerc = json["ISMER"].stringValue
		mercNum = json["MERCNUM"].stringValue
        isAgent = json["isAgent"].stringValue
        headImgUrl = json["headImgUrl"].stringValue
        
        LBKeychain.set(mercNum, key: CURRENT_MERC_ID)
        LBKeychain.set(isMerc,  key: ISMERC)
        LBKeychain.set(isAgent, key: ISAGENT)
        
        LBKeychain.set(phoneNum, key: PHONE_NUMBER)
        LBKeychain.set(userName, key: CURRENT_USER_NAME)
    
        LBKeychain.set(userStatus,  key: ISATHUENICATION)
        LBKeychain.set(headImgUrl,  key: USER_ICON_URL)
        LBKeychain.set(agentLevel,  key: AGENT_LEVEL)
        
	}
	
	
}


