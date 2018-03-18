//
//  LBConst.swift
//  LittleBlackBear
//
//  Created by 蘇崢 on 2017/10/23.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit
//oss
let OSSAccessKey = "LTAI6rTfz7ikikTG"
let OSSSecretKey = "NRDMFWjDHmgvZGVh18WbWiUWC1KZ1R"

let EndPoint = "http://oss-cn-shenzhen.aliyuncs.com"
let BucketName = "litterblackbear-public-v1"

let frontUrl = "https://litterblackbear-public-v1.oss-cn-shenzhen.aliyuncs.com/"

/// ---------------------- key ---------
public let serverAK = "FQRXHUzpq2LoGATTG8KIUhbfLy0VtAFW"
public let AK = "56b6VxZxgPK44yiw4kvr9DCxT6eH25GA"
public let GEOTABLEID:Int32 = 180033

public let PrivateEndPoint:String = "http://oss-cn-shenzhen.aliyuncs.com"
public let RealNameAuthBucketName:String = "litterblackbear-public-v1"

public let JPushAppKey:String = "e72c4ebe11a99c0ae9b87d97"

public let WX_APP_ID:String = "wx27a446bf583193d2"
public let WX_OPEN_ID:String = "wx_open_id"
public let WX_UNION_ID:String = "wx_union_id"
public let WX_APP_SECRET:String  = "b9381344c02e745d609460edb5f38b2a"
public let LBB_URLCHEME:String = "LitteBlackBearSystem"

public let PGYer_ID: String = "e6ffc89e0704403bf1e87a3b3f751c11"

/// 时间戳
public let timestamp = Date().timeIntervalSince1970

/// is iphoneX
public let IS_IPHONEX:Bool = KSCREEN_WIDTH == 375 && KSCREEN_HEIGHT == 812 ? true:false
/// 状态栏高度
public let STATUS_BAR_HEIGHT = CGFloat(IS_IPHONEX ?44:20.0)
/// 导航条高度
public let NAV_BAR_HEIGHT = CGFloat(IS_IPHONEX ?64:44.0)
/// 导航条 + 状态栏 高度
public let STATUS_AND_NAV_HEIGHT = STATUS_BAR_HEIGHT + NAV_BAR_HEIGHT

/// 屏幕的 bounds
public let SCREEN_BOUNDS = UIScreen.main.bounds
/// 屏幕的 size
public let SCREEN_SIZE = SCREEN_BOUNDS.size
/// 屏幕的高度
public let KSCREEN_HEIGHT = SCREEN_BOUNDS.height
/// 屏幕的宽度
public let KSCREEN_WIDTH = SCREEN_BOUNDS.width
/// 内容的高度(去除导航条和状态栏)
public let CONTENT_HEIGHT = KSCREEN_HEIGHT - STATUS_AND_NAV_HEIGHT

/// 屏幕的 sacle
public let SCREEN_SCALE = UIScreen.main.scale
public let SCREEN_RESOLUTION = KSCREEN_WIDTH * KSCREEN_HEIGHT * SCREEN_SCALE

public let AUTOSIZE_X = UIScreen.main.bounds.size.width   / (IS_IPHONEX ?KSCREEN_WIDTH:375)
public let AUTOSIZE_Y = UIScreen.main.bounds.size.height / (IS_IPHONEX ?KSCREEN_HEIGHT:667)

public let default_scale = UIScreen.main.bounds.size.width / 375

public let LBSALT = "d4a45e4482ac463a38f3sd324few42f"
let allowedCharacterSet = (CharacterSet(charactersIn: "!*'();:@&=+$,/?%#[]|^{}\"[]\\<>`").inverted)



public let appStoreUrl:String = "http://itunes.apple.com/cn/lookup?id=1284088525"

// MARK:*********************************systemsConstant********************
public let iOS_Version:CGFloat = CGFloat((UIDevice.current.systemVersion as NSString).floatValue)
public let infonDict:[String : Any] = Bundle.main.infoDictionary!
public let VERSION:String  = infonDict["CFBundleShortVersionString"] as! String? ?? ""
public let DEVICEID:String = (UIDevice.current.identifierForVendor?.uuidString)!
public let APPNAME:String = infonDict["CFBundleName"] as! String? ?? ""

public func isIPad() -> Bool {
    let deviceType = UIDevice.current.model
	if deviceType == "iPad" {
		return true
	}else{
		return false
	}
}


public let BankIdAarry:[String] = [
    /*中国银行  工商银行 建设银行 农业银行 */
    "BOCCREDIT","ICBCCREDIT","BCCBCREDIT","ABCCREDIT",
    /*交通银行 民生银行 招商银行 兴业银行*/
    "BOCOM","CMBCCREDIT","CMBCHINACREDIT","CIBCREDIT",
    /*光大银行  广发银行 华夏银行 中信银行*/
    "EVERBRIGHTCREDIT","GDBCREDIT","HXBCREDIT","ECITICCREDIT",
    /*平安银行  浦发银行 邮政储蓄 北京银行*/
    "PINGANCREDIT","SPDBCREDIT","SDBCREDIT","PSBCCREDIT",
    /* 上海银行     包商银行*/
    "BOSHCREDIT","BSBCREDIT"
]
public let BankNameAarry:[String] = [
    
    "中国银行","工商银行","建设银行","农业银行",
    "交通银行","民生银行","招商银行","兴业银行",
    
    "光大银行","广发银行","华夏银行","中信银行",
    "平安银行","浦发银行","邮政储蓄","北京银行",
    
    "上海银行","包商银行"
]



