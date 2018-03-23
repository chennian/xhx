//
//  LBBarButtonItem.swift
//  LittleBlackBear
//
//  Created by 蘇崢 on 2017/10/25.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
	
	convenience init(title: String,imgName:String, fontSize: CGFloat = 14, target: AnyObject?, action: Selector) {
		
		let btn = UIButton()
		btn.setTitleColor(UIColor.red, for: .normal)
		btn.setTitle(title, for: .normal)
		btn.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
		btn.setImage(UIImage(named: imgName), for: .normal)
		btn.setImage(UIImage(named: imgName), for: .highlighted)
		btn.addTarget(target, action: action, for: .touchUpInside)
		btn.frame = CGRect(x: 0, y: 0, width: 8, height: 16)
		self.init(customView: btn)
		
	}
	
}
