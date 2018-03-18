//
//  UISearchBarExtension.swift
//  LittleBlackBear
//
//  Created by 蘇崢 on 2018/2/5.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

class UISearchBarExtension: UISearchBar {

}
extension UISearchBar{
	public var cancelButton:UIButton?{
		var btn:UIButton?
		for view in self.subviews{
			if let button = view as? UIButton{
				btn =  button
			}
		}
		return btn
	}
}
