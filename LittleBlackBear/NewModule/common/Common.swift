//
//  Common.swift
//  ChouNiMei-Client
//
//  Created by Spectator on 16/7/15.
//  Copyright © 2016年 ZZC WORKSPACE. All rights reserved.
//

import Foundation
import UIKit
class common: NSObject {
    
}


// MARK: - 颜色
let color_bg_gray = Color(0xf4f4f4)
let color_bg_gray_f5 = Color(0xf5f5f5)
let color_bg_gray_e5 = Color(0xe5e5e5)
let color_bg_gray_fa = Color(0xfafafa)
let color_bg_light_blue = Color(0x88d2ff)
let color_text_f5b49 = Color(0xff5b29)
let color_main = Color(0x28c041)
let color_gray_cf = Color(0xcfcfcf)
let color_font_black_607 = Color(0x000607)
let color_font_gray_9f = Color(0x9f9f9f)
let color_font_gray_7c = Color(0x7c7c7c)
let color_line_gray_dc = Color(0xdcdcdc)


//MARK: - 公共属性

let ScreenW = UIScreen.main.bounds.width

let ScreenH = UIScreen.main.bounds.height

let isiPhoneX = ScreenW == 375.0 && ScreenH == 812.0

// Status bar height.
let  LL_StatusBarExtraHeight : CGFloat = (isiPhoneX ? 24.0 : 0.0)

// Navigation bar height.
let  LL_NavigationBarHeight : CGFloat = 44.0

// Tabbar height.
let  LL_TabbarHeight : CGFloat = (isiPhoneX ? (49.0+34.0) : 49.0)

// Tabbar safe bottom margin.
let  LL_TabbarSafeBottomMargin : CGFloat = (isiPhoneX ? 34.0 : 0.0)

// Status bar & navigation bar height.
let  LL_StatusBarAndNavigationBarHeight : CGFloat =  (isiPhoneX ? 88.0 : 64.0)



func fit(_ attribute: CGFloat) -> CGFloat {
    return adjustSizeWithUiDesign(attribute: attribute, UiDesignWidth: 750.0)
}


let IS_IPONE = UIDevice.current.model == "iPhone"
//用于屏幕设配 等比例方法缩小
fileprivate func adjustSize(attribute: CGFloat) -> CGFloat {
    
    
//    precondition(IS_IPONE, "this is not iphone,adjust method can not be used")
    
    var result : CGFloat = 0.0
    switch ScreenW {
    case 414:
        result = attribute
    case 375:
        result = attribute/1.104
        
    case 768:
        result = attribute * 1.85507
    default:
        result = attribute/1.29375
    }
    return result
}

func countWidth(text : String,size: CGSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude),font : UIFont) -> CGSize{
    let dic = [NSFontAttributeName : font]
    
    return (text as NSString).boundingRect(with: size, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: dic, context: nil).size
}
//此方法基本不用,通过APPCommon中的adjustSizeAPP调用此方法
func adjustSizeWithUiDesign(attribute: CGFloat,UiDesignWidth: CGFloat) -> CGFloat {
    var rate : CGFloat
    if isiPhoneX{
        rate = UiDesignWidth/414.0
    }else{
        
        rate = UiDesignWidth/414.0
    }
    
    return adjustSize(attribute: attribute/rate)
}


public func SNLog<T>(_ message: T, file: String = #file, function: String = #function, line: Int = #line) {
    #if DEBUG
    var fileName = file as NSString
    
    fileName = fileName.lastPathComponent as NSString
    print("[\(fileName)--\(function)--\(line) : \(message)]")
    #endif
}

func ZJLog<T>(messagr : T ,file : String = #file,function : String = #function, line : Int = #line  )
{
    #if DEBUG
        let str1 = (file as NSString).lastPathComponent
        let str2 = NSMutableString.init(string: str1)
        let range = NSRange.init(location: 0, length: str2.length)
        str2.replaceOccurrences(of: ".swift", with: "", options: NSString.CompareOptions.backwards, range: range)
        print("<\(str2)--\(function)>[\(line)]:\(messagr)")
    #endif
}

func ColorRGB(red: CGFloat, green: CGFloat , blue: CGFloat ) -> UIColor {
    
    return ColorRGBA(red: red, green: green, blue: blue, alpha: 1.0)
}

func ColorRGBA(red: CGFloat, green: CGFloat , blue: CGFloat ,alpha: CGFloat) -> UIColor {
    let color = UIColor.init(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)
    
    return color
}

func cellIdentify(_ cellClass : AnyClass) -> String {
    return NSStringFromClass(cellClass)
    
}

//MARK: - 获取版本号
func getCurrentIOS() -> CGFloat
{
    return CGFloat(Float(UIDevice.current.systemVersion)!)
    
}


// UI
/// 图片
func Image(_ name: String) -> UIImage? {
    return UIImage(named: name)
}

/// 十六进制颜色
func Color(_ hex: Int) -> UIColor {
    return UIColor(hexadecimal: hex)
} 

func randomColor() -> UIColor{
    let red = arc4random() % 256
    let greeen = arc4random() % 256
    let blue = arc4random() % 256
    return UIColor(red: CGFloat(red) / 255.0, green: CGFloat(greeen) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1)
}

/// 字体
func Font(_ size: CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: fit(size))
}

/// 加粗字体
func BoldFont(_ size: CGFloat) -> UIFont {
    return UIFont.boldSystemFont(ofSize: fit(size))
}

