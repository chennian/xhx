//
//  ZJMerchantAccountBookCell.swift
//  LittleBlackBear
//
//  Created by MichaelChan on 28/3/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

class ZJMerchantAccountBookCell: SNBaseTableViewCell {
//    var serviceModel : ZJServiceAccountCellModel?{
//        didSet{
//            nameLab.text = model!.name
//            tipLab.text = "消费：" + model!.payTotal
//            moneyLab.text = model!.merchant_money
//            timeLab.text = model!.add_time
//            headIcon.image = UIImage(named : "LBlogoIcon")
//        }
//    }
    
    var model : ZJMerchantAccoutBookModel?{
        didSet{
//            headIcon.kf.setImage(with: URL(string: model!.payTotal))
            nameLab.text = model!.name
            tipLab.text = "消费：" + model!.payTotal
            moneyLab.text = model!.merchant_money
            timeLab.text = model!.add_time
            headIcon.image = UIImage(named : "LBlogoIconHead")
        }
    }

    let headIcon = UIImageView().then({
        $0.layer.cornerRadius = fit(37)
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
    let moneyLab  = UILabel().then({
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
    })
    
    override func setupView() {
        contentView.addSubview(headIcon)
        contentView.addSubview(nameLab)
        contentView.addSubview(tipLab)
        contentView.addSubview(timeLab)
        contentView.addSubview(moneyLab)
        
        headIcon.snp.makeConstraints { (make) in
            make.top.snEqualTo(43)
            make.left.snEqualTo(38)
            make.width.height.snEqualTo(74)
        }
        nameLab.snp.makeConstraints { (make) in
            make.left.snEqualTo(132)
            make.top.snEqualTo(38)
        }
        tipLab.snp.makeConstraints { (make) in
            make.left.snEqualTo(nameLab)
            make.bottom.snEqualToSuperview().snOffset(-30)
        }
        timeLab.snp.makeConstraints { (make) in
            make.top.snEqualTo(43)
            make.right.snEqualToSuperview().snOffset(-37)
        }
        moneyLab.snp.makeConstraints { (make) in
            make.right.snEqualToSuperview().snOffset(-33)
            make.bottom.equalTo(tipLab)
        }
    }

}
