//
//  UIImage_Extension.swift
//  diandianzanumsers
//
//  Created by 楠 on 2017/6/9.
//  Copyright © 2017年 specddz. All rights reserved.
//

import UIKit


//颜色图片
func createImageBy(color : UIColor) -> UIImage{
    let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
    UIGraphicsBeginImageContext(rect.size)
    let context = UIGraphicsGetCurrentContext()
    context!.setFillColor(color.cgColor)
    context!.fill(rect)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    return image!
}

extension UIImage {
    
}
