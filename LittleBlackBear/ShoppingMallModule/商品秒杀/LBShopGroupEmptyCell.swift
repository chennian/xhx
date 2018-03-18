//
//  LBShopGroupEmptyCell.swift
//  LittleBlackBear
//
//  Created by Mac Pro on 2018/3/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

class LBShopGroupEmptyCell: SNBaseTableViewCell {

    private let descriptionLabel = UILabel().then{
        $0.text = "团团进行中"
        $0.textColor = Color(0x878787)
        $0.font = Font(26)
    }
    
    private let lineLeft = UIView().then{
        $0.backgroundColor = Color(0x878787)
    }
    
    private let lineRight = UIView().then{
        $0.backgroundColor = Color(0x878787)
    }
    
    private let placeHoldLable = UILabel().then{
        $0.text = "6人成团 快去发起拼团吧"
        $0.textColor = Color(0xcbcbcb)
        $0.font = Font(30)
    }
    
    override func setupView() {
        
        //        groupProgress = MQGradientProgressView(frame: CGRect(x: fit(160), y: fit(105), width: fit(460), height: fit(20)))
        
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(lineLeft)
        contentView.addSubview(lineRight)
        contentView.addSubview(placeHoldLable)
        
        
        
        descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().snOffset(25)
            make.centerX.equalToSuperview()
        }
        lineLeft.snp.makeConstraints { (make) in
            make.centerY.equalTo(descriptionLabel.snp.centerY)
            make.right.equalTo(descriptionLabel.snp.left).snOffset(-12)
            make.height.snEqualTo(1)
            make.width.snEqualTo(60)
        }
        lineRight.snp.makeConstraints { (make) in
            make.left.snEqualTo(descriptionLabel.snp.right).offset(12)
            make.centerY.equalTo(descriptionLabel.snp.centerY)
            make.width.snEqualTo(60)
            make.height.snEqualTo(1)
        }
     
        placeHoldLable.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(descriptionLabel.snp.bottom).snOffset(60)
        }
        
        //拼团人数
        //        peopleNumLable.snp.makeConstraints { (make) in
        //        }
        
    }

}
