//
//  ZJCouponDetailVC.swift
//  LittleBlackBear
//
//  Created by MichaelChan on 27/4/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

class ZJCouponDetailVC: SNBaseViewController {
    var model : ZJCouponCellModel?{
        didSet{
            couponName.text = "商品：" + model!.name
            shopName.text = "店铺：" + model!.shopName
            date.text = "有效期至：" + model!.terminaltime
            codeLsb.text = "验证码：" + model!.verfifyCode
            erCodeImg.image = ErCodeTool.creatQRCodeImage(text: model!.verfifyCode, size: fit(384), icon: nil)
        }
    }

    let backgroundImg = UIImageView(image: UIImage(named:"coupon_background")).then({
        $0.contentMode = .center
    })
    let couponName = UILabel().then({
        $0.font = BoldFont(36)
        $0.textColor = Color(0x313131)
    })
    let shopName = UILabel().then({
        $0.font = Font(28)
        $0.textColor = Color(0x6a6a6a)
    })
    let date = UILabel().then({
        $0.font = Font(28)
        $0.textColor = Color(0xff0000)
    })
    let erCodeImg = UIImageView().then({
        $0.layer.borderColor = Color(0xf7f7f7).cgColor
        $0.layer.borderWidth = fit(1.5)
        $0.contentMode = .center
    })
    
    let tipLab = UILabel().then({
        $0.text = "请将此码展示给收银员扫描"
        $0.font = Font(24)
        $0.textColor = Color(0x888888)
    })
    
    let codeLsb = UILabel().then({
        $0.font = Font(28)
        $0.textColor = Color(0x3b3b3b)
        $0.layer.borderColor = Color(0x3b3b3b).cgColor
        $0.backgroundColor = Color(0xf7f7f7)
        $0.layer.borderWidth = fit(1)
        $0.textAlignment = .center
    })

    override func setupView() {
        title = "卡券详情"
        view.addSubview(backgroundImg)
        view.addSubview(couponName)
        view.addSubview(shopName)
        view.addSubview(date)
        view.addSubview(erCodeImg)
        view.addSubview(tipLab)
        view.addSubview(codeLsb)
        backgroundImg.snp.makeConstraints { (make) in
            make.top.snEqualTo(30)
            make.centerX.equalToSuperview()
        }
        couponName.snp.makeConstraints { (make) in
            make.left.snEqualTo(82)
            make.top.snEqualTo(77)
        }
        shopName.snp.makeConstraints { (make) in
            make.left.snEqualTo(82)
            make.top.snEqualTo(137)
        }
        date.snp.makeConstraints { (make) in
            make.left.snEqualTo(82)
            make.top.snEqualTo(187)
        }
        erCodeImg.snp.makeConstraints { (make) in
            make.width.height.snEqualTo(470)
            make.centerX.equalToSuperview()
            make.top.snEqualTo(323)
        }
        tipLab.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(erCodeImg.snp.bottom).snOffset(18)
        }
        codeLsb.snp.makeConstraints { (make) in
            make.width.snEqualTo(552)
            make.height.snEqualTo(78)
            make.bottom.equalTo(backgroundImg).snOffset(-67)
            make.centerX.equalToSuperview()
        }
    }

}
