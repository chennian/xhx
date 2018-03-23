//
//  LBPrivatePolicyButtonCell.swift
//  LittleBlackBear
//
//  Created by Apple on 2018/1/31.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

class LBPrivatePolicyButtonView: UIView {
    var clickPrivateDetailBtn:((UIButton)->())?
    var clickPrivateBtn:((UIButton)->())?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = CGRect(x: 0, y: 0, width: KSCREEN_WIDTH, height: 40)
        setupUI()
        privateDtailButton.addTarget(self, action: #selector(clickPrivateDetailBtn(_ :)), for: .touchUpInside)
        privateBtn.addTarget(self, action: #selector(clickPrivateBtn(_:)), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let privateBtn = UIButton()
    private let privateDtailButton = UIButton()
 
    
    private func setupUI(){
        addSubview(privateBtn)
        addSubview(privateDtailButton)
        
        privateBtn.translatesAutoresizingMaskIntoConstraints = false
        privateDtailButton.translatesAutoresizingMaskIntoConstraints = false
        
        privateBtn.setImage(UIImage(named:"protocolNormal"), for: .normal)
        privateBtn.setImage(UIImage(named:"protocolSelect"), for: .selected)
        
        privateDtailButton.titleLabel?.font = FONT_22PX
        privateDtailButton.setTitleColor(COLOR_222222, for: .normal)
        privateDtailButton.setTitle("请勾选 我已阅读并接受《小黑熊用户协议》", for: .normal)
        
        addConstraint(BXLayoutConstraintMake(privateBtn, .left, .equal,self,.left,40))
        addConstraint(BXLayoutConstraintMake(privateBtn, .centerY, .equal,self,.centerY))
        addConstraint(BXLayoutConstraintMake(privateBtn, .width, .equal,nil,.width,30))
        addConstraint(BXLayoutConstraintMake(privateBtn, .height, .equal,self,.height))
        
        addConstraint(BXLayoutConstraintMake(privateDtailButton, .left, .equal,privateBtn,.right,10))
        addConstraint(BXLayoutConstraintMake(privateDtailButton, .centerY, .equal,self,.centerY))
    }
    
    func clickPrivateDetailBtn(_ button:UIButton)  {
        guard let action = clickPrivateDetailBtn else { return  }
        action(button)
    }
    func clickPrivateBtn(_ button:UIButton){
        guard let action = clickPrivateBtn else { return  }
        action(button)
    }
    
}
