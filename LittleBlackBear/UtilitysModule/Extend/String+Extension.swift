//
//  String+Extension.swift
//  BXFractionLink
//
//  Created by 蘇崢 on 2017/7/14.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

/// MARK:-- URLEncode &  URLDecode
extension String{

	var URLEncode:String?{
		let characterSet = CharacterSet(charactersIn: ":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`")
		return self.addingPercentEncoding(withAllowedCharacters: characterSet)
	}
	var URLDecode:String?{
		return self.removingPercentEncoding
	}
	
	func utf8DecodedString()-> String {
		let data = self.data(using: .utf8)
		if let message = String(data: data!, encoding: .nonLossyASCII){
			return message
		}
		return ""
	}
	func utf8EncodedString()-> String {
		let messageData = self.data(using: .nonLossyASCII)
		let text = String(data: messageData!, encoding: .utf8)
		return text!
	}
}
/// MARK: String With、Height
extension String{
	
	func width(_ font:CGFloat) -> CGFloat {
		return getSize(font*default_scale).width
	}
	func height(_ font:CGFloat) -> CGFloat {
		return getSize(font*default_scale).height
	}
	func getSize(_ fontSize: CGFloat) -> CGSize {
		
		let str = self as NSString
		
		let size = CGSize(width: UIScreen.main.bounds.width, height: CGFloat(MAXFLOAT))
		return str.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: fontSize)], context: nil).size
	}
}

extension String{
	
	
	// MARK: 判断是否是URL格式
	func isURLFormate() -> Bool {
		let regex = "[a-zA-z]+://[^\\s]*"
		return  validateStringIsRegexFormate(formate: regex)
	}
	// 是否是手机号格式
	func isPhoneNumberFormate() -> Bool {
		
		let mobile = "^1[3|4|5|7|8][0-9]\\d{8}$"
		return  validateStringIsRegexFormate(formate: mobile)
		
	}
	// 域名
	func isDomainNameFormater() -> Bool {
		let DomainName = "[a-zA-Z0-9]+$"
		return validateStringIsRegexFormate(formate: DomainName)
	}
    /// 中文
    func isChinese()->Bool{
        return validateStringIsRegexFormate(formate: "[\\u4e00-\\u9fa5]")
        
    }
	// MARK:判断String是否是formate格式
	func validateStringIsRegexFormate(formate:String) -> Bool {
		
		let chargectersString = stringByTrimingWhitespace()
		if chargectersString.count == 0 {
			return false
		}
		let predicate = NSPredicate(format: "SELF MATCHES %@", formate)
		return predicate.evaluate(with: self)
	}
    
    func replacingString(text:String,replacingOccurrences text2:String) -> String {
        return self.replacingOccurrences(of: text, with: text2)
    }
	// MARK: 移除首尾空格和换行
	func stringByTrimingWhitespace() -> String {
		return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).trimmingCharacters(in: .whitespaces)
	}
	/// 剪切空格和换行字符，返回一个新字符串。
	public var trimmed: String {
		return trimmingCharacters(in: .whitespacesAndNewlines)
	}

	
}
