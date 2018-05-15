//
//  ZJShopDetailHeaderCell.swift
//  LittleBlackBear
//
//  Created by MichaelChan on 10/5/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit
import SDCycleScrollView
import RxSwift
enum ZJShopDetailFuntionType {
    case naiv(lat : String,lng : String)
    case tele(phone : String)
}
class ZJShopDetailHeaderCell: SNBaseTableViewCell {
    let funcPub = PublishSubject<ZJShopDetailFuntionType>()
    var model : ZJShopDetailInfoModel?{
        didSet{
            sdCircleImageView.imageURLStringsGroup = model!.detail
            shopIcon.kf.setImage(with: URL(string: model!.logo), placeholder: createImageBy(color: Color(0xf5f5f5)))
            shopName.text = model!.shopName
//            model!.distance
            tipLab.text = "人气123 | \(model!.tab) | 距离\(model!.distance)km"
            addressLab.text = model!.address
            
            
            guidNavibtn.rx.controlEvent(UIControlEvents.touchUpInside).subscribe(onNext: { () in
                self.funcPub.onNext(ZJShopDetailFuntionType.naiv(lat: self.model!.latitude, lng: self.model!.longitude))
            }).disposed(by: disposeBag)
            teleButton.rx.controlEvent(UIControlEvents.touchUpInside).subscribe(onNext: { () in
                self.funcPub.onNext(ZJShopDetailFuntionType.tele(phone: self.model!.phone))
            }).disposed(by: disposeBag)
        }
    }

    let sdCircleImageView = SDCycleScrollView(frame: CGRect.zero, delegate: nil, placeholderImage: createImageBy(color: Color(0xf5f5f5))).then({
        $0.pageControlAliment = SDCycleScrollViewPageContolAlimentRight
        $0.bannerImageViewContentMode = .scaleAspectFill
    })
    let shopIcon = UIImageView().then({
        $0.layer.cornerRadius = fit(50)
        $0.layer.borderWidth = fit(1.5)
        $0.contentMode = .scaleAspectFill
        $0.layer.borderColor = UIColor.white.cgColor
        $0.clipsToBounds = true
    })
    let shopName = UILabel().then({
        $0.font = BoldFont(34)
        $0.textColor = Color(0x313131)
        $0.textAlignment = .center
    })
    
    let tipLab = UILabel().then({
        $0.textColor = Color(0x4e5156)
        $0.font = Font(24)
    })
    let addressLab = UILabel().then({
        $0.textColor = Color(0x565656)
        $0.font = Font(26)
        $0.numberOfLines = 2
    })
    let guidNavibtn = UIButton().then({
        $0.setImage(UIImage(named:"store_address"), for: .normal)
    })
    let teleButton = UIButton().then({
        $0.setImage(UIImage(named:"store_telephone"), for: .normal)
    })
    
    
    override func setupView() {
        line.isHidden = true
        contentView.addSubview(sdCircleImageView)
        contentView.addSubview(shopIcon)
        contentView.addSubview(shopName)
        contentView.addSubview(tipLab)
        contentView.addSubview(addressLab)
        contentView.addSubview(guidNavibtn)
        contentView.addSubview(teleButton)
        sdCircleImageView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.snEqualTo(503)
        }
        shopIcon.snp.makeConstraints { (make) in
            make.width.height.snEqualTo(100)
            make.centerX.equalToSuperview()
            make.centerY.snEqualTo(503)
        }
        shopName.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.snEqualTo(sdCircleImageView.snp.bottom).snOffset(65)
        }
        tipLab.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.snEqualTo(sdCircleImageView.snp.bottom).snOffset(130)
        }
        addressLab.snp.makeConstraints { (make) in
            make.width.snEqualTo(490)
            make.left.snEqualTo(21)
            make.top.snEqualTo(sdCircleImageView.snp.bottom).snOffset(216)
        }
        guidNavibtn.snp.makeConstraints { (make) in
            make.top.snEqualTo(addressLab)
            make.left.snEqualTo(addressLab.snp.right).snOffset(54)
        }
        teleButton.snp.makeConstraints { (make) in
            make.top.snEqualTo(addressLab)
            make.right.equalToSuperview().snOffset(-45)
        }
    }

}
