//
//  LBShopGroupCell.swift
//  LittleBlackBear
//
//  Created by Mac Pro on 2018/3/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

class LBShopGroupCell: SNBaseTableViewCell {

    var model : ZJActgivityDetailTuantuanInfoCellModel?{
        didSet{
            if !model!.hasActivity{
//                lineLeft.isHidden = true
                groupProgressLable.isHidden = true
                groupProgress.isHidden = true
                peopleNumLable.isHidden = true
                leftTimeLable.isHidden = true
                timeLable.isHidden = true
                
                tipLab.isHidden = false
                tipLab.text = model!.needPerson + "人成团 快去发起拼团吧"
            }else{
                tipLab.isHidden = true
                tipLab.text = ""
            }
        }
    }
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
    
    
    var tipLab = UILabel().then{
        $0.font = Font(30)
        $0.textColor = Color(0xcbcbcb)
        
    }
    var groupProgress = UIProgressView().then{
        $0.progress = 2/3
        $0.progressTintColor = .red
        $0.layer.cornerRadius = fit(12)
        $0.layer.masksToBounds = true
        $0.backgroundColor = Color(0xe6e8e9)
    }
    
    
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
        line.isHidden = true
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(lineLeft)
        contentView.addSubview(lineRight)
        contentView.addSubview(groupProgressLable)
        contentView.addSubview(groupProgress)
        contentView.addSubview(peopleNumLable)
        contentView.addSubview(leftTimeLable)
        contentView.addSubview(timeLable)

        contentView.addSubview(tipLab)
        groupProgress.snp.makeConstraints { (make) in
            make.left.equalTo(groupProgressLable.snp.right).snOffset(26)
            make.centerY.equalTo(groupProgressLable.snp.centerY)
            make.height.snEqualTo(25)
            make.width.snEqualTo(465)
        }
        
        descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().snOffset(25)
            make.centerX.equalToSuperview()
        }
        lineLeft.snp.makeConstraints { (make) in
            make.right.equalTo(descriptionLabel.snp.left).snOffset(-12)
            make.centerY.equalTo(descriptionLabel.snp.centerY)
            make.height.snEqualTo(1)
            make.width.snEqualTo(60)
        }
        lineRight.snp.makeConstraints { (make) in
            make.left.equalTo(descriptionLabel.snp.right).snOffset(12)
            make.centerY.equalTo(descriptionLabel.snp.centerY)
            make.width.snEqualTo(60)
            make.height.snEqualTo(1)
        }
        groupProgressLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(20)
            make.top.equalToSuperview().snOffset(105)
            
        }
        peopleNumLable.snp.makeConstraints { (make) in
            make.centerY.equalTo(groupProgressLable.snp.centerY)
            make.left.equalTo(groupProgress.snp.right).snOffset(20)
        }
        
        leftTimeLable.snp.makeConstraints { (make) in
            make.top.equalTo(groupProgressLable.snp.bottom).snOffset(32)
            make.left.equalTo(groupProgressLable.snp.left)
        }
        
        timeLable.snp.makeConstraints { (make) in
            make.centerY.equalTo(leftTimeLable.snp.centerY)
            make.left.equalTo(leftTimeLable.snp.right).snOffset(16)
        }
        tipLab.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().snOffset(-50)
        }
        
    }

}
