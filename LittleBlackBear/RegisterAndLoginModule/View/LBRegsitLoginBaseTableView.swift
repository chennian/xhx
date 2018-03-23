//
//  LBRegsitLoginBaseTableView.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/11/23.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

class LBRegsitLoginBaseTableView: UITableView {
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        if ((view as? UITextField) != nil) {
            return view
        }
        endEditing(true)
        let isButton = view as? UIButton != nil
        if isButton{
            return view
        }
        return self
    }
	
}
