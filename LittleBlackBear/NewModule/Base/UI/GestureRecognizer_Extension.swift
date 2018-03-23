//
//  GestureRecognizer_Extension.swift
//  ShenZhouDaDiXing
//
//  Created by spectator Mr.Z on 2016/10/25.
//  Copyright © 2016年 ZZC WORKSPACE. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func addTap(to: UIView, target: Any, action: Selector) {
        
        let ges = UITapGestureRecognizer(target: target, action: action)
        to.addGestureRecognizer(ges)
    }
    
    func addTap(_ target: Any, action: Selector) {
        
        let ges = UITapGestureRecognizer(target: target, action: action)
        self.addGestureRecognizer(ges)
        
    }
    
}
