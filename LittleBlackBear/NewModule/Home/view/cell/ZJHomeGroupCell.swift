//
//  ZJHomeGroupCell.swift
//  LittleBlackBear
//
//  Created by MichaelChan on 10/3/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit
import Kingfisher
class ZJHomeGroupCell: SNBaseTableViewCell {

    let imgV = UIImageView()
    
    
    var model : ZJHomeGroupModel?{
        didSet{
            imgV.kf.setImage(with: URL(string: model!.mainImg))
            name.text = model!.name
            price.text = "¥" + model!.price
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
