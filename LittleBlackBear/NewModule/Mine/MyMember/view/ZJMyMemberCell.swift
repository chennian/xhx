//
//  ZJMyMemberCell.swift
//  LittleBlackBear
//
//  Created by MichaelChan on 29/3/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

class ZJMyMemberCell: SNBaseTableViewCell {

    var model : ZJMyMemberModel?{
        didSet{
            nameLab.text = model!.username
            tipLab.text = model!.detail
            timeLab.text = model!.create_time
            headIcon.image = UIImage(named : "LBlogoIcon")
        }
    }
    let headIcon = UIImageView().then({
        $0.layer.cornerRadius = fit(55)
        $0.clipsToBounds = true
    })
    
    let nameLab = UILabel().then({
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
    })
    let tipLab = UILabel().then({
        $0.font = Font(24)
        $0.textColor = Color(0x898989)
    })
    
    let timeLab = UILabel().then({
        $0.font = Font(24)
        $0.textColor = Color(0x898989)
    })
    
    override func setupView() {
        contentView.addSubview(headIcon)
        contentView.addSubview(nameLab)
        contentView.addSubview(tipLab)
        contentView.addSubview(timeLab)
        
        headIcon.snp.makeConstraints { (make) in
            make.width.height.snEqualTo(110)
            make.centerY.equalToSuperview()
            make.left.snEqualTo(23)
        }
        nameLab.snp.makeConstraints { (make) in
            make.left.snEqualTo(153)
            make.top.snEqualTo(43)
        }
        tipLab.snp.makeConstraints { (make) in
            make.left.snEqualTo(nameLab)
            make.top.snEqualTo(87)
        }
        timeLab.snp.makeConstraints { (make) in
            make.left.snEqualTo(nameLab)
            make.bottom.equalToSuperview().snOffset(-39)
        }
    }

}
