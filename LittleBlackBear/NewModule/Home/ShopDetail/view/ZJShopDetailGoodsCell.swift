//
//  ZJShopDetailGoodsCell.swift
//  LittleBlackBear
//
//  Created by MichaelChan on 10/5/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

class ZJShopDetailGoodsCell: SNBaseTableViewCell {
    var model : ZJShopGoodsModel?{
        didSet{
            goodImg.kf.setImage(with: URL(string: model!.main_img))
            goodNameLab.text = model!.name
            priceLabb.text = "¥" + model!.price
            sellLab.text = "已售：" + model!.sell_num
        }
    }

    let goodImg = UIImageView().then({
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    })
    
    let goodNameLab = UILabel().then({
        $0.textColor = Color(0x313131)
        $0.font = BoldFont(32)
    })
    
    let priceLabb = UILabel().then({
        $0.textColor = Color(0xff2e3e)
        $0.font = Font(30)
    })
    let sellLab = UILabel().then({
        $0.textColor = Color(0x858585)
        $0.font = Font(24)
    })
    
    override func setupView() {
        goodNameLab.text = "香辣小龙虾"
        priceLabb.text = "¥ 90.00"
        sellLab.text = "已售：800000"
        goodImg.backgroundColor = Color(0xf5f5f5)
        contentView.addSubview(goodImg)
        contentView.addSubview(goodNameLab)
        contentView.addSubview(priceLabb)
        contentView.addSubview(sellLab)
        goodImg.snp.makeConstraints { (make) in
            make.width.snEqualTo(224)
            make.height.snEqualTo(174)
            make.left.snEqualTo(20)
            make.centerY.equalToSuperview()
        }
        
        goodNameLab.snp.makeConstraints { (make) in
            make.left.snEqualTo(277)
            make.right.snEqualToSuperview().snOffset(-20)
            make.top.snEqualTo(46)
        }
        priceLabb.snp.makeConstraints { (make) in
            make.centerY.equalTo(goodImg)
            make.left.snEqualTo(goodNameLab)
        }
        sellLab.snp.makeConstraints { (make) in
            make.left.snEqualTo(goodNameLab)
            make.bottom.equalToSuperview().snOffset(-56)
        }
    }
}
