//
//  LBShopGroupEmptyCell.swift
//  LittleBlackBear
//
//  Created by Mac Pro on 2018/3/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

class LBShopGroupEmptyCell: SNBaseTableViewCell {

    private let descriptionL = UILabel().then{
        $0.text = "团团进行中"
        $0.textColor = Color(0x878787)
        $0.font = Font(26)
    }
    
    private let leftLine = UIView().then{
        $0.backgroundColor = Color(0x878787)
    }
    
    private let lineL = UIView().then{
        $0.backgroundColor = Color(0x878787)
    }
    
    private let lineR = UIView().then{
        $0.backgroundColor = Color(0x878787)
    }
    
    private let placeHoldLable = UILabel().then{
        $0.text = "6人成团 快去发起拼团吧"
        $0.textColor = Color(0xcbcbcb)
        $0.font = Font(30)
    }
    
    override func setupView() {
        
        //        groupProgress = MQGradientProgressView(frame: CGRect(x: fit(160), y: fit(105), width: fit(460), height: fit(20)))
        line.isHidden = true
        contentView.addSubview(descriptionL)
        contentView.addSubview(lineL)
        contentView.addSubview(lineR)
        contentView.addSubview(placeHoldLable)
        contentView.addSubview(leftLine)
        
        
        
        descriptionL.snp.makeConstraints { (make) in
            make.top.equalToSuperview().snOffset(25)
            make.centerX.equalToSuperview()
        }
        leftLine.snp.makeConstraints { (make) in
            make.right.equalTo(descriptionL.snp.left).snOffset(-12)
            make.centerY.equalTo(descriptionL.snp.centerY)
            make.height.snEqualTo(1)
            make.width.snEqualTo(60)
        }
        lineL.snp.makeConstraints { (make) in
            make.right.equalTo(descriptionL.snp.left).snOffset(-12)
            make.centerY.equalTo(descriptionL.snp.centerY)
            make.height.snEqualTo(1)
            make.width.snEqualTo(60)
        }
        lineR.snp.makeConstraints { (make) in
            make.left.equalTo(descriptionL.snp.right).snOffset(12)
            make.centerY.equalTo(descriptionL.snp.centerY)
            make.width.snEqualTo(60)
            make.height.snEqualTo(1)
        }
        
        placeHoldLable.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(descriptionL.snp.bottom).snOffset(60)
        }
        
        //拼团人数
        //        peopleNumLable.snp.makeConstraints { (make) in
        //        }
        
    }

}
