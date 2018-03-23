//
//  LBNewMarketCellTableViewCell.swift
//  LittleBlackBear
//
//  Created by Mac Pro on 2018/3/17.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

class LBNewMarketCellTableViewCell: SNBaseTableViewCell {
    
    var imgLogo = UIImageView().then{
//        $0.kf.setImage(with:URL(string:"123"))
        $0.image = UIImage(named:"home_merchant")
    }
    var label1 = UILabel().then{
        $0.text = "月卡团购卷"
    }
    var label2 = UILabel().then{
        $0.text = "全明星儿童乐园月卡"
        $0.textColor = Color(0xa5a5a5)
    }
    var totol = UILabel().then{
        $0.text = "总量:10份"
        $0.textColor = Color(0xa5a5a5)

    }
    var status = UILabel().then{
        $0.text = "进行中"
        $0.textColor = Color(0xa5a5a5)

    }
    
    var line1 = UILabel().then{
        $0.backgroundColor = UIColor.gray
    }
    
    var state1 = UILabel().then{
        $0.text = "使用说明"
    }
    
    var state2 = UILabel().then{
        $0.text = "每个账号，只能团购一次"
        $0.textColor = Color(0xa5a5a5)

    }
    
    var line2 = UILabel().then{
        $0.backgroundColor = UIColor.gray
    }
    
    var activityTime = UILabel().then{
        $0.textColor = UIColor.red
    }
    
    var previewImg = UIImageView().then{
        $0.image = UIImage(named:"preview")
    }
    var previewLable = UILabel().then{
        $0.text = "预览"
    }
    
    var deleteImg = UIImageView().then{
        $0.image = UIImage(named:"delete")
    }
    
    var deleteLabel  = UILabel().then{
        $0.text = "删除"
    }
    override func setupView() {
        contentView.addSubview(imgLogo)
        contentView.addSubview(label1)
        contentView.addSubview(label2)
        contentView.addSubview(totol)
        contentView.addSubview(status)
        contentView.addSubview(line1)
        contentView.addSubview(line2)
        contentView.addSubview(state1)
        contentView.addSubview(state2)
        contentView.addSubview(activityTime)
        contentView.addSubview(previewImg)
        contentView.addSubview(previewLable)
        contentView.addSubview(deleteImg)
        contentView.addSubview(deleteLabel)
        
        imgLogo.snp.makeConstraints({ (make) in
            make.left.equalToSuperview().snOffset(20)
            make.top.equalToSuperview().snOffset(40)
            make.width.snEqualTo(120)
            make.height.snEqualTo(120)
        })
        
        label1.snp.makeConstraints { (make) in
            make.left.equalTo(imgLogo.snp.right).snOffset(35)
            make.top.equalTo(imgLogo.snp.top)
        }
        label2.snp.makeConstraints { (make) in
            make.centerY.equalTo(label1.snp.centerY)
            make.left.equalTo(label1.snp.right).snOffset(16)
            
        }
        totol.snp.makeConstraints { (make) in
            make.left.equalTo(label1.snp.left)
            make.top.equalTo(label1.snp.bottom).snOffset(16)
        }
        status.snp.makeConstraints { (make) in
            make.left.equalTo(totol.snp.left)
            make.top.equalTo(totol.snp.bottom).snOffset(16)
        }
        
        state1.snp.makeConstraints { (make) in
            make.top.equalTo(imgLogo.snp.bottom).snOffset(44)
            make.centerX.equalToSuperview()
        }
        
        line1.snp.makeConstraints { (make) in
            make.centerY.equalTo(state1.snp.centerY)
            make.right.equalTo(state1.snp.left).snOffset(-27)
            make.left.equalToSuperview().snOffset(20)
            make.height.snEqualTo(2)
        }
        
        line2.snp.makeConstraints { (make) in
            make.centerY.equalTo(state1.snp.centerY)
            make.left.equalTo(state1.snp.right).snOffset(27)
            make.right.equalToSuperview().snOffset(-20)
            make.height.snEqualTo(2)
        }
        
        state2.snp.makeConstraints { (make) in
            make.top.equalTo(state1.snp.bottom).snOffset(28)
            make.centerX.equalTo(state1.snp.centerX)
        }
        
        activityTime.snp.makeConstraints { (make) in
            make.top.equalTo(state2.snp.bottom).snOffset(20)
            make.centerX.equalTo(state2.snp.centerX)
        }
        previewImg.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(168)
            make.top.equalTo(activityTime.snp.bottom).snOffset(60)
            make.height.snEqualTo(45)
            make.width.snEqualTo(45)
        }
        previewLable.snp.makeConstraints { (make) in
            make.centerX.equalTo(previewImg.snp.centerX)
            make.top.equalTo(previewImg.snp.bottom).snOffset(20)
        }
        deleteImg.snp.makeConstraints { (make) in
            make.right.equalToSuperview().snOffset(-168)
            make.top.equalTo(activityTime.snp.bottom).snOffset(60)
            make.height.snEqualTo(45)
            make.width.snEqualTo(45)
        }
        deleteLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(deleteImg.snp.centerX)
            make.top.equalTo(deleteImg.snp.bottom).snOffset(20)
        }
    }
}
