//
//  ZJShopDetailDecriptionCell.swift
//  LittleBlackBear
//
//  Created by MichaelChan on 10/5/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

class ZJShopDetailDecriptionCell: SNBaseTableViewCell {

    var descriptionText : String = "" {
        didSet{
            descriptionLab.text = descriptionText
        }
    }
    let tipLab = UILabel().then({
        $0.text = "店铺介绍"
        $0.textColor = Color(0x313131)
        $0.font = Font(30)
    })
    
    let descriptionLab = UILabel().then({
        $0.numberOfLines = 0
        $0.textColor = Color(0x6e6e6e)
        $0.font = Font(26)
    })
    
    override func setupView() {
        line.isHidden = true
        contentView.addSubview(tipLab)
        contentView.addSubview(descriptionLab)
        
        tipLab.snp.makeConstraints { (make) in
            make.top.snEqualTo(27)
            make.left.snEqualTo(20)
        }
        
        descriptionLab.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.snEqualTo(713)
            make.top.snEqualTo(83)
        }
    }

}
