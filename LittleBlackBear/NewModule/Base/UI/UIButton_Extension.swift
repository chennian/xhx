//
//  UIButton_Extension.swift
//  diandianzanumsers
//
//  Created by 楠 on 2017/6/9.
//  Copyright © 2017年 specddz. All rights reserved.
//

import UIKit


extension UIButton {
    
    func sn_setImage(_ imageName: String, for state: UIControlState) {
        
        let img = UIImage(named: imageName)
        self.setImage(img, for: state)
        
    }
}
