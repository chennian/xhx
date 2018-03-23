//
//  ZJHeadTopicShareCell.swift
//  LittleBlackBear
//
//  Created by MichaelChan on 18/3/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

class ZJHeadTopicShareCell: SNBaseTableViewCell {

    let headIcon = UIImageView().then{
        $0.layer.cornerRadius = fit(27)
        $0.clipsToBounds = true
    }
    let nameLab = UILabel().then{
        $0.textColor = Color(0x313131)
        $0.font = Font(26)
    }
    override func setupView() {
        contentView.addSubview(headIcon)
        contentView.addSubview(nameLab)
//        contentView.addSubview(contentLab)
        headIcon.snp.makeConstraints { (make) in
            make.width.height.snEqualTo(54)
            make.left.snEqualTo(20)
            make.top.snEqualTo(27)
        }
        nameLab.snp.makeConstraints { (make) in
            make.centerY.equalTo(headIcon)
            make.left.snEqualTo(headIcon.snp.right).snOffset(13)
        }
        

        line.snp.remakeConstraints { (make) in
            make.right.bottom.equalToSuperview()
            make.left.snEqualTo(nameLab)
            make.height.snEqualTo(1)
        }
    }

}
