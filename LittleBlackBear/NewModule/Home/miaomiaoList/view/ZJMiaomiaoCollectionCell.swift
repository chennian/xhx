//
//  ZJMiaomiaoCollectionCell.swift
//  LittleBlackBear
//
//  Created by MichaelChan on 12/5/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

class ZJMiaomiaoCollectionCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpVIew()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var model : ZJHomeMiaoMiaoModel?{
        didSet{
            imgView.kf.setImage(with: URL(string: model!.mainImg), placeholder: createImageBy(color: Color(0xf5f5f5)))
            couponTitleLabel.text = model!.name
            price.text = "¥" + model!.price
            countDownView.setRemainTime(endTime: model!.endTime)
        }
    }
    
    func setUpVIew(){
        contentView.backgroundColor = .white
        contentView.addSubview(imgView)
        contentView.addSubview(couponTitleLabel)
        contentView.addSubview(price)
        contentView.addSubview(countDownView)
        imgView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.snEqualTo(235)
        }
        couponTitleLabel.snp.makeConstraints { (make) in
            make.left.snEqualTo(13)
            make.top.snEqualTo(imgView.snp.bottom).snOffset(17)
        }
        
        price.snp.makeConstraints { (make) in
            make.left.snEqualTo(couponTitleLabel)
            make.bottom .equalToSuperview().snOffset(-20)
        }
        countDownView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalTo(imgView)
            make.height.snEqualTo(48)
        }
        
    }
    
    private let imgView = UIImageView().then({
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    })//主图
    
    private let couponTitleLabel = UILabel().then{
        $0.textColor = Color(0x313131)
        $0.font = Font(28)
    }// 卡券标题
    //home_ticket2
    //    private let kajuanView = ZJKaJuanView()
    
    let price = UILabel().then{
        $0.textColor = Color(0xff2e3e)
        $0.font = BoldFont(30)
    }
    
    let countDownView = ZJCountDownView.size(width: 35, height: 32, fontSize: fit(22))
    
    
}
