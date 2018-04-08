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
            tipLab.text = "| " +  model!.merTypeLabel//"距离" + model!.distance
            //                configMerLevel(model)
            //                configMerchantClass(model)
            //            popularityBtn.setTitle("人气76", for: .disabled)
            if model!.mainImgUrl.isURLFormate() == true {
                imgV.kf.setImage(with: URL(string:model!.mainImgUrl))
            }
            
            distanceLab.text = "距离" + model!.distance
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
        $0.font = BoldFont(33)//Font(30)
        $0.textColor = Color(0xf9f9f9)
    }
    
    let distanceLab = UILabel().then{
        $0.font = Font(30)
        $0.textColor = Color(0xf6f6f6)
    }
    let tipLab = UILabel().then{
        $0.font = Font(30)
        $0.textColor = Color(0xf6f6f6)
    }
    
    override func setupView() {
        line.isHidden = true
        contentView.layer.borderWidth = fit(1)
        contentView.layer.borderColor = Color(0xf5f5f5).cgColor
        contentView.snp.remakeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.bottom.equalToSuperview().snOffset(-20)
        }
        contentView.clipsToBounds = true
        contentView.addSubview(imgV)
        contentView.addSubview(cover)
        contentView.addSubview(name)
        contentView.addSubview(tipLab)
        contentView.addSubview(distanceLab)
        imgV.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.height.equalToSuperview()
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        cover.snp.makeConstraints { (make) in
            make.left.right.equalTo(imgV)
            make.bottom.equalTo(imgV)
            make.height.snEqualTo(120)
        }
        name.snp.makeConstraints { (make) in
            make.top.equalTo(cover).snOffset(20)
            make.left.equalTo(cover).snOffset(15)
        }
        tipLab.snp.makeConstraints { (make) in
            make.bottom.equalTo(cover).snOffset(-20)
            make.left.equalTo(name)
        }
        distanceLab.snp.makeConstraints { (make) in
            make.centerY.equalTo(cover)
            make.right.snEqualToSuperview().snOffset(-15)
        }
    }

}
