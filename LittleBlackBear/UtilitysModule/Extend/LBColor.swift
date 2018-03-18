//
//  LBColor.swift
//  LittleBlackBear
//
//  Created by 蘇崢 on 2017/10/25.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

let white  = UIColor.white
let black  = UIColor.black
let red    = UIColor.red
let green  = UIColor.green
let blue   = UIColor.blue
let gray   = UIColor.gray
let orange = UIColor.orange
let purple = UIColor.purple
let clear  = UIColor.clear
let tableViewColor = UIColor.groupTableViewBackground

// 16进制颜色转换 不带透明度得到
let TINT_COLOR   = UIColor.rgbColorWith(hex: 0x1478b8)
let COLOR_008fef = UIColor.rgbColorWith(hex: 0x008fef)
let COLOR_1379b7 = UIColor.rgbColorWith(hex: 0x1379b7)
let COLOR_1aa6ff = UIColor.rgbColorWith(hex: 0x1aa6ff)
let COLOR_1478b8 = UIColor.rgbColorWith(hex: 0x1478b8)
let COLOR_1DA6FE = UIColor.rgbColorWith(hex: 0x1DA6FE)
let COLOR_bebebe = UIColor.rgbColorWith(hex: 0xbebebe)

let COLOR_c22f4a = UIColor.rgbColorWith(hex: 0xc22f4a)
let COLOR_2bcec6 = UIColor.rgbColorWith(hex: 0x2bcec6)
let COLOR_2dd0cf = UIColor.rgbColorWith(hex: 0x2dd0cf)
let COLOR_222222 = UIColor.rgbColorWith(hex: 0x222222)

let COLOR_4a4d57 = UIColor.rgbColorWith(hex: 0x4a4d57)
let COLOR_555555 = UIColor.rgbColorWith(hex: 0x555555)
let COLOR_666666 = UIColor.rgbColorWith(hex: 0x666666)

let COLOR_75dde3 = UIColor.rgbColorWith(hex: 0x73dde3)
let COLOR_74caf5 = UIColor.rgbColorWith(hex: 0x74caf5)
let COLOR_7f7f7f = UIColor.rgbColorWith(hex: 0x7f7f7f)

let COLOR_820000 = UIColor.rgbColorWith(hex: 0x820000)
let COLOR_999999 = UIColor.rgbColorWith(hex: 0x999999)
let COLOR_9C9C9C = UIColor.rgbColorWith(hex: 0x9c9c9c)

let COLOR_99aab5 = UIColor.rgbColorWith(hex: 0x99aab5)
let COLOR_9688fd = UIColor.rgbColorWith(hex: 0x9688fd)
let COLOR_9ef0a4 = UIColor.rgbColorWith(hex: 0x9ef0a4)

let COLOR_c3c3c3 = UIColor.rgbColorWith(hex: 0xc3c3c3)
let COLOR_dadada = UIColor.rgbColorWith(hex: 0xdadada)

let COLOR_e60013 = UIColor.rgbColorWith(hex: 0xe60013)
let COLOR_e6e6e6 = UIColor.rgbColorWith(hex: 0xe6e6e6)
let COLOR_ededed = UIColor.rgbColorWith(hex: 0xededed)
let COLOR_efefef = UIColor.rgbColorWith(hex: 0xefefef)
let COLOR_eee471 = UIColor.rgbColorWith(hex: 0xeee471)
let COLOR_E8E8E8 = UIColor.rgbColorWith(hex: 0xE8E8E8)

let COLOR_f2808a = UIColor.rgbColorWith(hex: 0xf2808a)
let COLOR_fd833b = UIColor.rgbColorWith(hex: 0xfd833b)
let COLOR_fb6aae = UIColor.rgbColorWith(hex: 0xfb6aae)

let COLOR_f67877 = UIColor.rgbColorWith(hex: 0xf67877)
let COLOR_f7f8f8 = UIColor.rgbColorWith(hex: 0xf7f8f8)
let COLOR_fc010d = UIColor.rgbColorWith(hex: 0xfc010d)

let COLOR_fc843b = UIColor.rgbColorWith(hex: 0xfc843b)
let COLOR_fc8439 = UIColor.rgbColorWith(hex: 0xfc8439)
let COLOR_fca513 = UIColor.rgbColorWith(hex: 0xfca513)
let COLOR_f3f3f3 = UIColor.rgbColorWith(hex: 0xf3f3f3)
let COLOR_f2f2f2 = UIColor.rgbColorWith(hex: 0xf2f2f2)
let COLOR_fe9f0c = UIColor.rgbColorWith(hex: 0xfe9f0c)

let COLOR_ffffff = UIColor.rgbColorWith(hex: 0xffffff)
let COLOR_ffaf48 = UIColor.rgbColorWith(hex: 0xffaf48)


extension UIColor{
	
	// MARK:RGBA
	class func rgb(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, alpha: CGFloat = 1.0) -> UIColor {
		
		return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)
	}
	
	class func rgbColorWith(hex: Int,alpha: Float = 1.0) -> UIColor {
		return UIColor(red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
		               green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
		               blue: CGFloat(hex & 0x0000FF) / 255.0,
		               alpha: CGFloat(alpha))
	}
	
	// MARK:随机色
	class func arc4randomColor() -> UIColor {
		return rgb(CGFloat(arc4random_uniform(UInt32(256.0))), CGFloat(arc4random_uniform(UInt32(256.0))), CGFloat(arc4random_uniform(UInt32(256.0))), alpha: 1)
	}
	
}

