//
//  ZJHomeMerchantCell.swift
//  LittleBlackBear
//
//  Created by MichaelChan on 10/3/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

class ZJHomeMerchantCell: SNBaseTableViewCell {

    let imgV = UIImageView().then({
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    })
    
    
//    var model : ZJHomeGroupModel?{
//        didSet{
//            imgV.kf.setImage(with: URL(string: model!.mainImg))
//            name.text = model!.name
//            price.text = "¥" + model!.price
//        }
//    }
    
    var model:LBMerInfosModel?{
        didSet{
            guard model != nil else {return}
            name.text = model!.merShortName
            price.text =  "距离" + model!.distance
            //                configMerLevel(model)
            //                configMerchantClass(model)
            //            popularityBtn.setTitle("人气76", for: .disabled)
            if model!.mainImgUrl.isURLFormate() == true {
                imgV.kf.setImage(with: URL(string:model!.mainImgUrl))
            }
//            merLabe.text = model!.labelName
//            if merLabe.text == "" {
//                merLabe.isHidden = true
//            }
//            let width = countWidth(text: model!.labelName, font: Font(24)).width + fit(28)
//            merLabe.snp.remakeConstraints { (make) in
//                make.bottom.equalToSuperview().snOffset(-42)
//                make.left.equalTo(titleLabel)
//                make.height.snEqualTo(36)
//                make.width.equalTo(width)
//            }
//            starView?.currentScore = 4.5
//            scoreLab.text = "4.5"
        }
    }
    let cover = UIView().then{
        $0.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.36)
    }
    
    let name = UILabel().then{
        $0.font = Font(30)
        $0.textColor = Color(0xf9f9f9)
    }
    
    let price = UILabel().then{
        $0.font = Font(30)
        $0.textColor = Color(0xf6f6f6)
    }
    
    override func setupView() {
        line.isHidden = true
        contentView.clipsToBounds = true
        contentView.addSubview(imgV)
        contentView.addSubview(cover)
        contentView.addSubview(name)
        contentView.addSubview(price)
        
        imgV.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.height.equalToSuperview()
            make.width.snEqualTo(710)
            make.centerX.equalToSuperview()
        }
        
        cover.snp.makeConstraints { (make) in
            make.left.right.equalTo(imgV)
            make.bottom.equalTo(imgV)
            make.height.snEqualTo(86)
        }
        name.snp.makeConstraints { (make) in
            make.centerY.equalTo(cover)
            make.left.equalTo(cover).snOffset(15)
        }
        price.snp.makeConstraints { (make) in
            make.centerY.equalTo(cover)
            make.right.equalTo(cover).snOffset(-15)
        }
    }

}
