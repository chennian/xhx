//
//  LBProfileRightItemView.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/12/14.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

class LBProfileRightItemView: UIView {
    var clickSettingBtnAction:(()->())?
    var clickEmailBtnACton:(()->())?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = CGRect(x: KSCREEN_WIDTH-110, y: 0, width: 103, height: 44)
        setupUI()
        settingBtn.addTarget(self, action: #selector(clickSettingBtnAction(_:)), for: .touchUpInside)
//        emailBtn.addTarget(self, action: #selector(clickEmailBtnACton(_:)), for: .touchUpInside)

    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private let settingBtn = UIButton()
    private let emailBtn = UIButton()
    
    func setupUI() {
        addSubview(settingBtn)
//        addSubview(emailBtn)
        settingBtn.translatesAutoresizingMaskIntoConstraints = false
//        emailBtn.translatesAutoresizingMaskIntoConstraints = false
        
        
        settingBtn.setImage(UIImage(named:"setting"), for: .normal)
//        emailBtn.setImage(UIImage(named:"message"), for: .normal)
        
        settingBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0)
        
        addConstraint(BXLayoutConstraintMake(settingBtn, .right, .equal,self,.right))
        addConstraint(BXLayoutConstraintMake(settingBtn, .centerY,.equal,self,.centerY))
        addConstraint(BXLayoutConstraintMake(settingBtn, .width, .equal,nil,.width,45))
        addConstraint(BXLayoutConstraintMake(settingBtn, .height,.equal,nil,.height,44))
        

//        addConstraint(BXLayoutConstraintMake(emailBtn, .centerY, .equal,self,.centerY))
//        addConstraint(BXLayoutConstraintMake(emailBtn, .right, .equal,self,.right))
//        addConstraint(BXLayoutConstraintMake(emailBtn, .width, .equal,nil,.width,45))
//        addConstraint(BXLayoutConstraintMake(emailBtn, .height,.equal,nil,.height,44))

        
    }
    
    func clickSettingBtnAction(_ btn:UIButton) {
        guard let aciton = clickSettingBtnAction else {return}
        aciton()
    }
    
    func clickEmailBtnACton(_ btn:UIButton){
        guard let aciton = clickEmailBtnACton else {return}
        aciton()
    }
}








