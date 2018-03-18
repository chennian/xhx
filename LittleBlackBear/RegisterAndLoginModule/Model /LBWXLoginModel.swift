//
//  LBWXLoginModel.swift
//  LittleBlackBear
//
//  Created by 蘇崢 on 2017/12/27.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit


struct WXLoginInfonModel:ResponeData{
	
	let access_token:String
	let openid:String
	let refresh_token:String
	let unionid:String
	
	init(json: LBJSON) {
		
		access_token = json["access_token"].stringValue
		openid = json["openid"].stringValue
		refresh_token = json["refresh_token"].stringValue
		unionid = json["unionid"].stringValue
		LBKeychain.set(openid, key: WX_OPEN_ID)
        LBKeychain.set(unionid, key: WX_UNION_ID)
	}
    
}

struct WXUserInfonModel:ResponeData{
	
	let nickname:String
	let headimgurl:String
	
	init(json: LBJSON) {
		nickname = json["nickname"].stringValue
		headimgurl = json["headimgurl"].stringValue
		LBKeychain.set(headimgurl, key: USER_ICON_URL)
	}
	

	
}


