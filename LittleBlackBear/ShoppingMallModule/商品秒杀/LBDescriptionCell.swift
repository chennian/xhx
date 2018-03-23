//
//  LBDescriptionCell.swift
//  LittleBlackBear
//
//  Created by Mac Pro on 2018/3/17.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

class LBDescriptionCell: SNBaseTableViewCell {
    
    private let descriptionLabel = UILabel().then{
        $0.text = "详情介绍"
        $0.textColor = Color(0x878787)
        $0.font = Font(26)
    }
    
    private let lineLeft = UIView().then{
        $0.backgroundColor = Color(0x878787)
    }
    
    private let lineRight = UIView().then{
        $0.backgroundColor = Color(0x878787)
    }
    
    var descriptionDetail = UILabel().then{
        $0.text = "MD5的典型应用是对一段信息（Message）产生信息摘要（Message-Digest），以防止被篡改。"
        $0.font = Font(30)
        $0.textColor = Color(0x505050)
        $0.numberOfLines = 0

    }

    override func setupView() {
        line.isHidden = true
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(lineLeft)
        contentView.addSubview(lineRight)
        contentView.addSubview(descriptionDetail)

        
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
            make.left.equalTo(descriptionLabel.snp.right).snOffset(12)
            make.centerY.equalTo(descriptionLabel.snp.centerY)
            make.width.snEqualTo(60)
            make.height.snEqualTo(1)
        }
        descriptionDetail.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(20)
            make.right.equalToSuperview().snOffset(-20)
            make.top.equalTo(descriptionLabel.snp.bottom).snOffset(40)
            
        }
        
    }

}
