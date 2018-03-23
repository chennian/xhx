//
//  LBPrint.swift
//  LittleBlackBear
//
//  Created by 蘇崢 on 2017/10/25.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit
// MARK:****************************自定义Print*******************************
public func Print<T>(_ message: T, fileName: String = #file, methodName: String =  #function, lineNumber: Int = #line)
{
    #if DEBUG
		let dateFormatter = DateFormatter()
		dateFormatter.locale = Locale(identifier: "en_US_POSIX") //24H
		dateFormatter.dateFormat = "y-MM-dd HH:mm:ss.SSS"
		
		let str : String = (fileName as NSString).pathComponents.last!
		//.stringByReplacingOccurrencesOfString("swift", withString: "")
		
		print("\(dateFormatter.string(from: Date())) --***-- \("fileName:")\(str) --***-- \("methodName:")\(methodName) --***-- \("lineNumber:")\(lineNumber) --***-- log:\(message)")
		
    #endif
}
