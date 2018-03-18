//
//  LBSendRegValiMsgCodeServer.swift
//  LittleBlackBear
//
//  Created by 蘇崢 on 2017/11/24.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

class LBSendRegValiMsgCodeServer: NSObject {
	
	class func sendRegValiMsgCode(phone:String,type:String) {// type 0 为注册 1修改密码
        let parameters = lb_md5Parameter(parameter: ["phoneNumber":phone,"type":type] )
		LBHttpService.LB_Request(.sendRegValiMsgCode, method: .post, parameters:parameters, headers: nil, success: { (json) in
			UIAlertView(title: "提示", message: json["RSPMSG"].stringValue, delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
		}, failure: { (faileItem) in
			UIAlertView(title: "提示", message: faileItem.message, delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
		}) { (eror) in
				UIAlertView(title: "提示", message: RESPONSE_FAIL_MSG, delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "确定").show()
		}
	}
}
