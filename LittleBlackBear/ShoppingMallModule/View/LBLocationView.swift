//
//  LBLocationView.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/12/1.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

class LBLocationView: UIView {

    var clickLocationBtnAction:((_ btn:UIButton)->Void)?
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        btn.addTarget(self, action: #selector(clickLocationBtnAction(_ :)), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let btn = UIButton()
    func setupUI(){
        addSubview(btn)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -5)
        btn.titleLabel?.font = FONT_30PX
        btn.setTitleColor(COLOR_222222, for: .normal)
        addConstraint(BXLayoutConstraintMake(btn, .left, .equal,self,.left))
        addConstraint(BXLayoutConstraintMake(btn, .top, .equal,self,.top))
        addConstraint(BXLayoutConstraintMake(btn, .right, .equal,self,.right))
        addConstraint(BXLayoutConstraintMake(btn, .bottom, .equal,self,.bottom))
        
        
        btn.setImage(UIImage(named:"locationMark"), for: .normal)
		var city:String = LBKeychain.get(LOCATION_CITY_KEY)
        if city.count ==  0 {
            city = "定位"
        }
        btn.setTitle(city, for: .normal)

    }
    func clickLocationBtnAction(_ btn:UIButton)  {
        guard let action = clickLocationBtnAction else {return}
        action(btn)
    }
    
    
}
