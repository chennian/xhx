//
//  shopGoodNameCell.swift
//  LittleBlackBear
//
//  Created by Mac Pro on 2018/3/17.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

class LBShopGoodNameCell: SNBaseTableViewCell {
    
    
    var model : ZJActgivityDetailNameCellModel?{
        didSet{
            nameLable.text = model!.name
            price.text = "¥" + model!.price
            num.text = "已售" + model!.count + "件"

        }
    }
    var lableHeight: CGFloat{
        get{
            nameLable.sizeToFit()
            return nameLable.frame.size.height
        }

    }
    
    var nameLable = UILabel().then{
        $0.text = "MD5的典型应用是对一段信息（Message）产生信息摘要"
        $0.numberOfLines = 2
        $0.font = BoldFont(36)
        $0.textColor  = Color(0x313131)
    }
    
    var price = UILabel().then{
        $0.text = "￥100.00"
        $0.textColor = Color(0xff0000)
        $0.font = Font(44)
    }
    
    var num = UILabel().then{
        $0.text = "已售1222件"
        $0.textColor = Color(0xa5a5a5)
        $0.font = Font(26)
    }
    
    override func setupView() {
        line.isHidden = true
        contentView.addSubview(nameLable)
        contentView.addSubview(price)
        contentView.addSubview(num)
        
        nameLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(20)
            make.right.equalToSuperview().snOffset(-20)
            make.top.equalToSuperview().snOffset(22)
        }
        
        price.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(20)
            make.top.equalTo(nameLable.snp.bottom).snOffset(30)
        }
        
        num.snp.makeConstraints { (make) in
            make.right.equalToSuperview().snOffset(-20)
            make.centerY.equalTo(price.snp.centerY)
        }
    }


    
}
