//
//  LBPriofileFooterView.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/12/19.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

class LBPriofileFooterView: UIView {
    
    var applyAction:((_ btn:UIButton)->())?
    var buttonTitle:String = ""{
        didSet{
            guard  buttonTitle.count > 0 else { return  }
            applyButton.setTitle(buttonTitle, for: .normal)
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        self.frame = CGRect(x: 0, y: 0, width: KSCREEN_WIDTH, height: 110)
        setupUI()
        applyButton.addTarget(self,
                              action: #selector(clickApplyBtnAction(_ :)),
                              for: .touchUpInside)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let applyButton = UIButton()
    private let lineView  = UIView()
    
    private func setupUI() {
        
        addSubview(applyButton)
        addSubview(lineView)
        
        lineView.translatesAutoresizingMaskIntoConstraints = false
        applyButton.translatesAutoresizingMaskIntoConstraints = false
        applyButton.setTitle("申请成为商家", for: .normal)
        applyButton.backgroundColor = COLOR_e60013
        applyButton.setTitleColor(UIColor.white, for: .normal)
        applyButton.layer.cornerRadius = 10
        applyButton.layer.masksToBounds = true
        
        lineView.backgroundColor = COLOR_e6e6e6
        
        addConstraint(BXLayoutConstraintMake(applyButton, .centerX, .equal,self,.centerX))
        addConstraint(BXLayoutConstraintMake(applyButton, .centerY, .equal,self,.centerY))
        addConstraint(BXLayoutConstraintMake(applyButton, .width, .equal,nil,.width,200*AUTOSIZE_X))
        addConstraint(BXLayoutConstraintMake(applyButton, .height, .equal,nil,.height,45))
        
        addConstraint(BXLayoutConstraintMake(lineView, .centerX, .equal,self,.centerX))
        addConstraint(BXLayoutConstraintMake(lineView, .top, .equal,self,.top))
        addConstraint(BXLayoutConstraintMake(lineView, .width, .equal,nil,.width,KSCREEN_WIDTH))
        addConstraint(BXLayoutConstraintMake(lineView, .height, .equal,nil,.height,10))
        
    }
    @objc private func clickApplyBtnAction(_ btn:UIButton)  {
        guard let action = applyAction else { return }
        action(btn)
    }
    
    
}
