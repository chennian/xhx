//
//  ZJShopDetailCommonCell.swift
//  LittleBlackBear
//
//  Created by MichaelChan on 10/5/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

class ZJShopDetailCommonCell: SNBaseTableViewCell {

 
    var model : ZJReplayModel?{
        didSet{
            headIcon.kf.setImage(with: URL(string: model!.headImg))
            nickeName.text = model!.nickName
            commonLab.text = model!.description
            dateLab.text = model!.add_time
            startView.startCount = Int((model!.grade as NSString).doubleValue + 0.5)
        }
    }
    let headIcon = UIImageView().then({
        $0.layer.cornerRadius = fit(27)
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
    })
    
    let nickeName = UILabel().then({
        $0.font = Font(32)
        $0.textColor = Color(0x313131)
    })
    
    let commonLab = UILabel().then({
        $0.font = Font(28)
        $0.textColor = Color(0x313131)
        $0.numberOfLines = 2 
    })
    let dateLab = UILabel().then({
        $0.font = Font(24)
        $0.textColor = Color(0xa5a5a5)
    })
    
    let startView = LBStartLevelView().then({
        $0.spacing = fit(7)
        $0.isUserInteractionEnabled = false
    })
    override func setupView() {
        contentView.addSubview(headIcon)
        contentView.addSubview(nickeName)
        contentView.addSubview(commonLab)
        contentView.addSubview(dateLab)
        contentView.addSubview(startView)
        headIcon.snp.makeConstraints { (make) in
            make.width.height.snEqualTo(54)
            make.left.snEqualTo(20)
            make.top.snEqualTo(20)
        }
        nickeName.snp.makeConstraints { (make) in
            make.left.snEqualTo(90)
            make.centerY.equalTo(headIcon)
        }
        commonLab.snp.makeConstraints { (make) in
            make.left.snEqualTo(89)
            make.top.snEqualTo(93)
            make.right.snEqualToSuperview().snOffset(-26)
        }
        dateLab.snp.makeConstraints { (make) in
            make.centerY.equalTo(headIcon)
            make.right.equalToSuperview().snOffset(-20)
        }
        
        startView.snp.makeConstraints { (make) in
            make.bottom.snEqualTo(nickeName).snOffset(-5)
            make.left.snEqualTo(164)
            make.width.snEqualTo(194)
            make.height.snEqualTo(28)
        }
    }
}
