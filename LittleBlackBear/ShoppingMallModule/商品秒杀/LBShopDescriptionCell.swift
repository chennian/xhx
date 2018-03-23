//
//  LBShopDescriptionCell.swift
//  LittleBlackBear
//
//  Created by Mac Pro on 2018/3/17.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

class LBShopDescriptionCell: SNBaseTableViewCell {
    
    var model : ZJActgivityDetailMerchantCellModel?{
        didSet{
            shopImg.kf.setImage(with: URL(string : model!.icon))
            shopName.text = model!.name
            distense.setTitle(model!.distance, for: .normal)
            address.text = model!.addredd
            classLable.text = model!.lab
        }
    }
    var shopImg = UIImageView().then{
        $0.backgroundColor = UIColor.red
    }
    
    var shopName = UILabel().then{
        $0.text = "点都德"
        $0.font = BoldFont(34)
        $0.textColor  = Color(0x313131)
    }
    
    var distense = UIButton().then{
        $0.titleLabel?.font = Font(26)
        $0.setTitleColor(Color(0x565656), for: .disabled)
        $0.isEnabled = false
        $0.setImage(UIImage(named : "mapLoc"), for: .disabled)
        $0.setTitle("200m", for: .disabled)

    }

    private let sepLine = UIView().then{
        $0.backgroundColor = Color(0x565656)
    }
    
    var address = UILabel().then{
        $0.text = "深圳市龙华新区明治街道"
        $0.textColor  = Color(0x565656)
        $0.font = Font(26)
        
    }
    
    var telphoneImg = UIImageView().then{
        $0.image = UIImage(named:"telephone")
    }
    
    var classLable = UILabel().then{
        $0.backgroundColor = Color(0xffecec)
        $0.text = "小龙虾"
        $0.font = Font(24)
        $0.textColor = Color(0xff4242)
        $0.layer.borderWidth = fit(1)
        $0.layer.borderColor = Color(0xffc1c1).cgColor
    }
    override func setupView() {
        line.isHidden = true
        contentView.addSubview(shopImg)
        contentView.addSubview(shopName)
        contentView.addSubview(distense)
        contentView.addSubview(sepLine)
        contentView.addSubview(address)
        contentView.addSubview(telphoneImg)
        contentView.addSubview(classLable)
        shopImg.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(20)
            make.top.equalToSuperview().snOffset(35)
            make.width.snEqualTo(160)
            make.height.snEqualTo(160)
        }
        
        shopName.snp.makeConstraints { (make) in
            make.top.equalTo(shopImg.snp.top).snOffset(14)
            make.left.equalTo(shopImg.snp.right).snOffset(24)
        }
        distense.snp.makeConstraints { (make) in
            make.left.equalTo(shopName)
            make.top.equalTo(shopName.snp.bottom).snOffset(22)
            make.width.snEqualTo(100)
            make.height.snEqualTo(24)
        }
        sepLine.snp.makeConstraints { (make) in
            make.left.equalTo(distense.snp.right).snOffset(5)
            make.width.snEqualTo(2)
            make.height.snEqualTo(18)
            make.centerY.snEqualTo(distense.snp.centerY)
        }
        
        address.snp.makeConstraints { (make) in
            make.left.equalTo(sepLine.snp.right).snOffset(5)
            make.centerY.equalTo(sepLine.snp.centerY)
        }
        telphoneImg.snp.makeConstraints { (make) in
            make.centerY.equalTo(address.snp.centerY)
            make.right.equalToSuperview().snOffset(-28)
            make.width.snEqualTo(80)
            make.height.snEqualTo(80)
        }
        classLable.snp.makeConstraints { (make) in
            make.left.equalTo(shopName.snp.left)
            make.top.equalTo(distense.snp.bottom).snOffset(20)
            make.height.snEqualTo(36)
        }
        
    }
}
