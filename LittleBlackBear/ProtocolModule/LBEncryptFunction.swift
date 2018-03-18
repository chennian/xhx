//
//  LBEncryptFunction.swift
//  LittleBlackBear
//
//  Created by 蘇崢 on 2017/11/19.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit
import CryptoSwift
// 排序MD5
public func lb_md5Parameter(parameter:[String:Any]? = nil)->[String:Any]{
	
	let dateFormatter = DateFormatter()
	dateFormatter.locale = Locale(identifier: "en_US_POSIX") //24H
	dateFormatter.dateFormat = "yMMddHH"
	let timestamp = dateFormatter.string(from: Date())
	
	var sign:String = ""
	guard (parameter != nil) else {
		sign.append("timestamp=\(timestamp)" + "&key=\(LBSALT)")
		sign = sign.md5().uppercased()
		return ["sign":sign]
	}
	
	let list:[String] = (parameter?.keys.sorted(by: {$0 < $1}).filter { $0 != "sign"})!
	guard list.count > 0 else {
		return parameter!
	}
	var param:[String:Any]? = parameter
	for key in list {
		
		let args:[CVarArg] = [(param![key] as? CVarArg)!]
		Print(key + "\(args)")
		for objc in args{
			
			if objc is String {
				
				var text = objc as! String
				
				if text.count == 0 {
					
				}else{
					text = text.stringByTrimingWhitespace()
                    /// Java URLEncode.encode("":"UTF-8")对 “ ” 转换成 +
                    text = text.replacingOccurrences(of: " ", with: "+")
					text = text.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet)!
					sign.append(String.init(format: "%@%@%@%@", key,"=",text,"&"))
				}
				
			}else if objc is Int || objc is Double{
				sign.append(String.init(format: "%@%@%@%@", key,"=","\(objc)","&"))
			}else{
				sign.append(String.init(format: "%@%@%@%@", key,"=",objc,"&"))
			}
		}
	}
	sign.append("timestamp=\(timestamp)" + "&key=\(LBSALT)")
	Print("MD5之前"+sign)
	sign = sign.md5().uppercased()
	param?["sign"] = sign
	return param!
}


