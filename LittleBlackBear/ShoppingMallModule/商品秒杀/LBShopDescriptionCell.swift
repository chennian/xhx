//
//  LBShopDescriptionCell.swift
//  LittleBlackBear
//
//  Created by Mac Pro on 2018/3/17.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit
import RxSwift
class LBShopDescriptionCell: SNBaseTableViewCell {
    let funcPub = PublishSubject<ZJShopDetailFuntionType>()
    var model : ZJActgivityDetailMerchantCellModel?{
        didSet{
            shopImg.kf.setImage(with: URL(string : model!.icon))
            shopName.text = model!.name
            distense.setTitle(model!.distance + "km", for: .normal)
            address.text = model!.addredd
            classLable.text = model!.lab
            
            
            guidNavibtn.rx.controlEvent(UIControlEvents.touchUpInside).subscribe(onNext: { () in
                self.funcPub.onNext(ZJShopDetailFuntionType.naiv(lat: self.model!.latitude, lng: self.model!.longitude))
            }).disposed(by: disposeBag)
            
            teleButton.rx.controlEvent(UIControlEvents.touchUpInside).subscribe(onNext: { () in
                self.funcPub.onNext(ZJShopDetailFuntionType.tele(phone: self.model!.phone))
            }).disposed(by: disposeBag)
        }
    }
    var shopImg = UIImageView().then{
        $0.backgroundColor = UIColor.red
    }
    
    var shopName = UILabel().then{
        $0.text = "点都德"
        $0.font = BoldFont(32)
        $0.textColor  = Color(0x313131)
    }
    
    var distense = UIButton().then{
        $0.titleLabel?.font = Font(24)
        $0.setTitleColor(Color(0x565656), for: .disabled)
        $0.isEnabled = false
        $0.setImage(UIImage(named : "mapLoc"), for: .disabled)
//        $0.setTitle("200m", for: .disabled)

    }

    private let sepLine = UIView().then{
        $0.backgroundColor = Color(0x8e8e8e)
    }
    
    var address = UILabel().then{
        $0.text = "深圳市龙华新区明治街道"
        $0.textColor  = Color(0x565656)
        $0.font = Font(24)
        $0.numberOfLines = 1
    }
    
    var teleButton = UIButton().then{
//        $0.image =
        $0.setImage(UIImage(named:"store_telephone"), for: .normal)
    }
    
    let guidNavibtn = UIButton().then({
        $0.setImage(UIImage(named:"store_address"), for: .normal)
    })

    
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
        contentView.addSubview(teleButton)
        contentView.addSubview(classLable)
        contentView.addSubview(guidNavibtn)
        shopImg.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(20)
            make.centerY.equalToSuperview()
            make.width.snEqualTo(140)
            make.height.snEqualTo(140)
        }
        
        shopName.snp.makeConstraints { (make) in
            make.top.equalTo(shopImg.snp.top).snOffset(14)
            make.left.equalTo(shopImg.snp.right).snOffset(24)
        }
        distense.snp.makeConstraints { (make) in
            make.left.equalTo(shopName)
            make.top.equalTo(shopName).snOffset(50)
//            make.width.snEqualTo(100)
//            make.height.snEqualTo(24)
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
            make.right.snEqualTo(guidNavibtn.snp.left).snOffset(-27)
        }
        
        teleButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(address.snp.centerY)
            make.right.equalToSuperview().snOffset(-20)
            make.width.snEqualTo(60)
            make.height.snEqualTo(60)
        }
        guidNavibtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(teleButton)
            make.size.equalTo(teleButton)
            make.right.equalTo(teleButton.snp.left).snOffset(-33)
        }
        classLable.snp.makeConstraints { (make) in
            make.left.equalTo(shopName.snp.left)
            make.top.equalTo(distense.snp.bottom).snOffset(10)
            make.height.snEqualTo(36)
        }
        
    }
}
