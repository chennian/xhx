//
//  LBLoginHttpServer.swift
//  LittleBlackBear
//
//  Created by 蘇崢 on 2017/11/24.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

protocol LBLoginHttpServer {
	// 手机号登录
	func phoneLoginRequire(phoneNum:String,password:String,success:@escaping(LBLoginModel<loginDetail>)->Void,failure:@escaping((String)->Void))
	// 微信登录
	func wxLoginRequire(openId:String,unionId:String,success:@escaping(LBLoginModel<loginDetail>)->Void,failure:@escaping((String)->Void))
	// 微信登录授权
	func wxLoginRequestUnionIDWithCode(code:String,success:@escaping(WXLoginInfonModel)->Void,failure:@escaping((String)->Void))
	// 获取用户信息
	func requireWXUserInfoWithResult(_ access_token:String, _ openid:String,success:@escaping(WXUserInfonModel)->Void,failure:@escaping((String)->Void))
}
extension LBLoginHttpServer where Self:LBLoginViewController {
	
	func phoneLoginRequire(phoneNum:String,password:String,success:@escaping(LBLoginModel<loginDetail>)->Void,failure:@escaping((String)->Void)){
		
		let parameters:[String:Any] = [
			"phoneNumber":phoneNum,
			"password":password,
			"clientType":"2",//1安卓 2iOS 3微信
			"curVersion":VERSION,
			"appType":"2",
			"deviceId":DEVICEID,
			"lng":LBKeychain.get(longiduteKey),
			"lat":LBKeychain.get(latitudeKey),
			]
		LBHttpService.LB_Request(.phone_wechat_login, method: .post, parameters: lb_md5Parameter(parameter: parameters), headers: nil, success: { (json)in success(LBLoginModel(json: json))
		}, failure: ({failure($0.message)}), requestError: ({_ in failure(RESPONSE_FAIL_MSG)}))
	}
	
	func wxLoginRequire(openId:String,unionId:String,success:@escaping(LBLoginModel<loginDetail>)->Void,failure:@escaping((String)->Void)){
		let parameters:[String:Any] = [
			"openId":openId,
			"unionId":unionId,
			"clientType":"3",//1安卓 2iOS 3微信
			"curVersion":VERSION,
			"appType":"2",
			"deviceId":DEVICEID,
			"lng":LBKeychain.get(longiduteKey),
			"lat":LBKeychain.get(latitudeKey),
			]
		LBHttpService.LB_Request(.phone_wechat_login, method: .post, parameters:  lb_md5Parameter(parameter: parameters), headers: nil, success: { (json)in success(LBLoginModel(json: json))
		}, failure: ({failure($0.message)}), requestError: ({_ in failure(RESPONSE_FAIL_MSG)}))
	}
	
	func wxLoginRequestUnionIDWithCode(code:String,success:@escaping(WXLoginInfonModel)->Void,failure:@escaping((String)->Void)){
		let parameters:[String:Any] = ["appid":WX_APP_ID,"secret":WX_APP_SECRET,"code":code ,"grant_type":"authorization_code"]
        LBHttpManager.request(LBRequestUrlType.wxLoginURL.rawValue, method: .post, parameters:parameters , headers: nil, success: { (json) in
            success(WXLoginInfonModel(json: json))
        },failure:{error in
            failure(error.localizedDescription)

        })
	
	}
	
	 func requireWXUserInfoWithResult(_ access_token:String, _ openid:String,success:@escaping(WXUserInfonModel)->Void,failure:@escaping((String)->Void)){
		let parameters = ["access_token":access_token,"openid":openid]
        LBHttpManager.request(LBRequestUrlType.wxInfoUrl.rawValue, method: .post, parameters:parameters , headers: nil, success: { (json) in
            success(WXUserInfonModel(json: json))
        },failure:{error in
            failure(error.localizedDescription)
        })
	
		
	}
}











