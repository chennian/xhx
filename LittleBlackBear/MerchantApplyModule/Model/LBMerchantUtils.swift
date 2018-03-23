//
//  LBMerchantUtils.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/11/16.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

// int -> float
extension Int {
    var f: CGFloat {
        return CGFloat(self)
    }
}

// 字体转换
extension UIFont {
    class func fontWith(pixel: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: pixel / 96.f * 72.f)
    }
}

extension NSString {
    // 计算字符串 size
    func textSizeWith(contentSize:CGSize, font: UIFont) -> CGSize {
        let attrs = [NSFontAttributeName: font]
        return self.boundingRect(with: contentSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attrs, context: nil).size
    }
}

extension UILabel {
    // 不等高字体富文本
    func text(contents: (text: String, font: UIFont) ...) {
        let textArray = contents.map{ $0.text }
        let attriStr = NSMutableAttributedString(string: textArray.joined())
        var location = 0
        for content in contents {
            let range = NSMakeRange(location, content.text.count)
            attriStr.addAttribute(NSFontAttributeName, value: content.font, range: range)
            location += content.text.count
        }
        self.attributedText = attriStr
    }
    // 文字对齐 支持大于等于与2个汉子 不带冒hao
    func alignmentJustify(withWidth: CGFloat) {
        guard let originText = self.text, originText.count > 1 else {
            assert(false, "Label没有内容或者Lable内容长度小于2")
            return
        }
        let text = originText as NSString
        
        let textSize = text.textSizeWith(contentSize: CGSize(width: withWidth, height: CGFloat(MAXFLOAT)), font: self.font)
        let margin = (withWidth - textSize.width) / CGFloat(originText.count - 1)
        let attriStr = NSMutableAttributedString(string: originText)
        attriStr.addAttribute(kCTKernAttributeName as String, value: margin, range:NSRange(location: 0, length: originText.count - 1))
		if text.contains("*") {
			attriStr.addAttribute(NSForegroundColorAttributeName, value: COLOR_fc843b, range:NSRange(location: 0, length: 1))
		}
        self.attributedText = attriStr
    }
    // 文字对齐 支持大于等于与3个汉子 带冒号
    func alignmentJustify_colon(withWidth: CGFloat) {
		
        guard let originText = self.text, originText.count > 2 else {
            assert(false, "Label没有内容或者Lable内容长度小于3")
            return
        }
        let text = originText as NSString
	
        let colon_W = ":".textSizeWith(contentSize: CGSize(width: withWidth, height: CGFloat(MAXFLOAT)), font: self.font).width
        
        let textSize = text.textSizeWith(contentSize: CGSize(width: withWidth, height: CGFloat(MAXFLOAT)), font: self.font)
        let margin = (withWidth - colon_W - textSize.width) / CGFloat((originText.count - 2))
        let attriStr = NSMutableAttributedString(string: originText)
        attriStr.addAttribute(NSKernAttributeName, value: margin, range:NSRange(location: 0, length: originText.count - 2))
		if text.contains("*") {
			attriStr.addAttribute(NSForegroundColorAttributeName, value: COLOR_fc843b, range:NSRange(location: 0, length: 1))
		}
        self.attributedText = attriStr
    }
}

extension UITextField {
    // 占位符号对齐
    func placeholderAlignment(alignment: NSTextAlignment) {
        guard let placeholder = placeholder else {
            return
        }
        let style = NSMutableParagraphStyle()
        style.alignment = alignment
        let attriStr = NSMutableAttributedString(string: placeholder)

        attriStr.addAttribute(NSParagraphStyleAttributeName, value: style, range: NSRange(location: 0, length: placeholder.count))
        self.attributedPlaceholder = attriStr
    }
}

// cell 扩展两个属性 一个是 当前indexpath 另一个是高度(高度好像是)
extension UITableViewCell {
    
    private static var currentIndexPath = "currentIndexPath"
    private static var cellHeight = "cellHeight"
    
    
    var currentIndexPath: IndexPath? {
        set {
            objc_setAssociatedObject(self, &UITableViewCell.currentIndexPath, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
        }
        get {
            return objc_getAssociatedObject(self, &UITableViewCell.currentIndexPath) as? IndexPath
        }
    }
    var cellHeight: CGFloat? {
        set {
            objc_setAssociatedObject(self, &UITableViewCell.cellHeight, newValue, .OBJC_ASSOCIATION_ASSIGN)
            
        }
        get {
            return objc_getAssociatedObject(self, &UITableViewCell.cellHeight) as? CGFloat
        }
    }
    
}

