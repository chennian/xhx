//
//  LBSubmitButtonCell.swift
//  LittleBlackBear
//
//  Created by Mac Pro on 2018/3/19.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

class LBSubmitButtonCell: SNBaseTableViewCell {

    var submitBoutton = UIButton().then{
        $0.backgroundColor = Color(0x272424)
        $0.layer.cornerRadius = fit(4)
        $0.setTitleColor(UIColor.white, for:UIControlState.normal)
        $0.titleLabel?.font = Font(30)
        $0.titleLabel?.textColor = .white
    }
    
    override func setupView() {
        contentView.addSubview(submitBoutton)
        submitBoutton.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(20)
            make.right.equalToSuperview().snOffset(-20)
            make.height.snEqualTo(100)
            make.centerY.equalToSuperview()
        }
        
    }

}
