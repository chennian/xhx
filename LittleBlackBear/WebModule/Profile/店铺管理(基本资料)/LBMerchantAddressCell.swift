//
//  LBMerchantAddressCell.swift
//  LittleBlackBear
//
//  Created by Mac Pro on 2018/4/4.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

class LBMerchantAddressCell: SNBaseTableViewCell {
    private let addressImg = UIImageView().then{
        $0.image = UIImage(named:"mapLoc")
    }
    
    private let address = UILabel().then{
        $0.text = "商家地址"
        $0.font = Font(26)
        $0.textColor = Color(0x313131)
        $0.numberOfLines = 0
    }
    override func setupView() {
        contentView.addSubview(addressImg)
        contentView.addSubview(address)
        
        addressImg.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalToSuperview().snOffset(30)
            make.width.snEqualTo(18)
            make.height.snEqualTo(25)
        }
        
        address.snp.makeConstraints { (make) in
            make.left.equalTo(addressImg.snp.right).snOffset(15)
            make.right.equalToSuperview().snOffset(30)
            make.centerY.equalTo(addressImg.snp.centerY)
        }
        
    }
   
}

