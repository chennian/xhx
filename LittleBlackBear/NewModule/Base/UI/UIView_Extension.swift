//
//  UIView_Extension.swift
//  diandianzanumsers
//
//  Created by 楠 on 2017/7/13.
//  Copyright © 2017年 specddz. All rights reserved.
//

import UIKit

extension UIView {
    
    func corner(with: CGFloat, coners: UIRectCorner) {
        
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: with, height: with))
        
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    
}


extension UIButton{
    //设置图片与文字的间距
    func setTextImageInsert(margin : CGFloat){
        titleEdgeInsets = UIEdgeInsetsMake(0, margin / 2, 0, -margin / 2)
        imageEdgeInsets = UIEdgeInsetsMake(0, -margin / 2, 0, margin / 2)
    }
    
    
    
}
