//
//  ZJHeadTopicCommonCell.swift
//  LittleBlackBear
//
//  Created by MichaelChan on 18/3/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

class ZJHeadTopicCommonCell: SNBaseTableViewCell {
    var model : ZJHeadTopicDetailReplayModel?{
        didSet{
            headIcon.kf.setImage(with: URL(string : model!.headImg))
            nameLab.text = model!.nickName
            contentLab.text = model!.comments
        }
    }

    let headIcon = UIImageView().then{
        $0.layer.cornerRadius = fit(27)
        $0.clipsToBounds = true
    }
    let nameLab = UILabel().then{
        $0.textColor = Color(0x939393)
        $0.font = Font(26)
    }
//    let timeLab = UILabel().then{
//        $0.textColor = Color(0xa5a5a5)
//        $0.font = Font(26)
//    }
    let contentLab = UILabel().then{
        $0.textColor = Color(0x313131)
        $0.font = Font(30)
        $0.numberOfLines = 0
        //        $0.lineBreakMode = .
    }
    
    override func setupView() {
//        line.backgroundColor = Color(0xe2e2e2)
        contentView.addSubview(headIcon)
        contentView.addSubview(nameLab)
        contentView.addSubview(contentLab)
        headIcon.snp.makeConstraints { (make) in
            make.width.height.snEqualTo(54)
            make.left.snEqualTo(20)
            make.top.snEqualTo(22)
        }
        nameLab.snp.makeConstraints { (make) in
            make.centerY.equalTo(headIcon)
            make.left.snEqualTo(headIcon.snp.right).snOffset(15)
        }
        
        contentLab.snp.makeConstraints { (make) in
            make.left.equalTo(nameLab)
            make.right.snEqualToSuperview().snOffset(-20)
            make.top.equalTo(nameLab.snp.bottom)
        }
        line.snp.remakeConstraints { (make) in
            make.right.bottom.equalToSuperview()
            make.left.snEqualTo(headIcon.snp.right)
            make.height.snEqualTo(1)
        }
    }

}
