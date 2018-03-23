//
//  LBSwitchCell.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/12/19.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

class LBSwitchCell: UITableViewCell {

    var cellType:LBSettingCellType = .switch("", false){
        didSet{
            switch cellType {
            case let.switch(text,status):
                _switch.isOn = status
                label.text = text
                
            default: break
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   private let label = UILabel()
   private let _switch = UISwitch()
   private func setupUI()  {
        contentView.addSubview(label)
        contentView.addSubview(_switch)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        _switch.translatesAutoresizingMaskIntoConstraints = false
        _switch.onImage = UIImage.imageWithColor(COLOR_e60013)
        
        label.textColor = COLOR_222222
        label.font = FONT_28PX
        
        contentView.addConstraint(BXLayoutConstraintMake(label, .centerY, .equal,contentView,.centerY))
        contentView.addConstraint(BXLayoutConstraintMake(label, .left, .equal,contentView,.left,16))
        contentView.addConstraint(BXLayoutConstraintMake(_switch, .right, .equal,contentView,.right,-16))
        contentView.addConstraint(BXLayoutConstraintMake(_switch, .centerY, .equal,contentView,.centerY))
        
        
    }
}
