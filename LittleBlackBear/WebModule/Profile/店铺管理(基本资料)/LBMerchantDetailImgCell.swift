//
//  LBMerchantDetailImgCell.swift
//  LittleBlackBear
//
//  Created by Mac Pro on 2018/4/4.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

class LBMerchantDetailImgCell: SNBaseTableViewCell {

    private let merMain = UILabel().then{
        $0.text = "商家详情图"
        $0.font = Font(26)
        $0.textColor = Color(0x313131)
    }
    
    private let notice = UILabel().then{
        $0.text = "请上传最佳分表率(700*400像素比例)的图片"
        $0.font = Font(26)
        $0.textColor = Color(0xe8e8e8)
    }
    
    var mainImge = DDZUploadBtn().then{
        $0.setImage(UIImage(named:"new_addition"),for:.normal)
        $0.fuName = "img"
        $0.imageView?.contentMode = .scaleAspectFill
        
    }
    
    override func setupView() {
        contentView.addSubview(merMain)
        contentView.addSubview(notice)
        contentView.addSubview(mainImge)
        
        merMain.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalToSuperview().snOffset(30)
        }
        
        notice.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalTo(merMain.snp.bottom).snOffset(30)
        }
        mainImge.snp.makeConstraints { (make) in
            make.top.equalTo(notice.snp.bottom).snOffset(30)
            make.left.equalToSuperview().snOffset(30)
            make.width.height.snEqualTo(100)
        }
        
    }
}
