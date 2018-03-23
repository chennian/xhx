//
//  LBMapNavibarView.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/12/21.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

class LBMapNavigationBar: UIView {
    var transformCityAction:((UILabel)->())?
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor =  COLOR_ffffff
        self.frame  = CGRect(x: 0, y: 0, width:KSCREEN_WIDTH, height: NAV_BAR_HEIGHT+STATUS_BAR_HEIGHT)
        setupUI()
        button.addTarget(self, action: #selector(transformCityAction(_:)), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var cityText:String = ""{
        didSet{
            guard cityText.count > 0 else {return}
            label.text = cityText
        }
    }
    private let imgview = UIImageView(image: UIImage(named:"locationMark"))
    private let label = UILabel()
    private let button = UIButton()
    
    private func setupUI() {
        
        addSubview(imgview)
        addSubview(label)
        addSubview(button)
        
        imgview.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false

        label.text = "当前位置: " + LBKeychain.get(LOCATION_CITY_KEY)
        label.font = FONT_30PX
        label.textColor = COLOR_222222
        label.textAlignment = .left
        
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.layer.borderColor = COLOR_e60013.cgColor
        button.layer.borderWidth = 0.5
        button.setTitle( "切换", for: .normal)
        button.setTitleColor(COLOR_e60013, for: .normal)
        
        addConstraint(BXLayoutConstraintMake(imgview, .left, .equal,self,.left,10))
        addConstraint(BXLayoutConstraintMake(imgview, .bottom,.equal,self,.bottom,-10))
        addConstraint(BXLayoutConstraintMake(imgview, .width, .equal,nil,.width,15*AUTOSIZE_X))
        addConstraint(BXLayoutConstraintMake(imgview, .height,.equal,nil,.height,16*AUTOSIZE_Y))
        
        addConstraint(BXLayoutConstraintMake(label, .left, .equal,imgview,.right,5))
        addConstraint(BXLayoutConstraintMake(label, .bottom,.equal,self,.bottom,-10))

        addConstraint(BXLayoutConstraintMake(button, .right, .equal,self,.right,-10))
        addConstraint(BXLayoutConstraintMake(button, .bottom,.equal,self,.bottom,-10))
        addConstraint(BXLayoutConstraintMake(button, .width, .equal,nil,.width,50))
        addConstraint(BXLayoutConstraintMake(button, .height,.equal,nil,.height,20))

    }
    
    func transformCityAction(_ button:UIButton) {
        guard let action = transformCityAction else { return }
        action(label)
    }
 
}
