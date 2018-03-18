//
//  LBShopGroupCell.swift
//  LittleBlackBear
//
//  Created by Mac Pro on 2018/3/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

class LBShopGroupCell: SNBaseTableViewCell {

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
    
    private let  groupProgressLable = UILabel().then{
        $0.text = "拼团进度"
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        
    }
    //进度条
//        var groupProgress:MQGradientProgressView?
    
    var peopleNumLable = UILabel().then{
        $0.text = "4/6人"
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        
    }
    private let leftTimeLable = UILabel().then{
        $0.text = "剩余时间:"
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
    }
    
    var timeLable = UILabel().then{
        $0.text = "00:23:12:09"
        $0.font = BoldFont(30)
        $0.textColor = Color(0x313131)
    }

    override func setupView() {
        
//        groupProgress = MQGradientProgressView(frame: CGRect(x: fit(160), y: fit(105), width: fit(460), height: fit(20)))
        
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(lineLeft)
        contentView.addSubview(lineRight)
        contentView.addSubview(groupProgressLable)
        
        
        
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
        groupProgressLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(20)
            make.top.equalToSuperview().snOffset(105)
            
        }
        
        //拼团人数
//        peopleNumLable.snp.makeConstraints { (make) in
//        }
        
    }

}
