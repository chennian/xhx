//
//  ZJHomeSeckillCell.swift
//  LittleBlackBear
//
//  Created by MichaelChan on 10/3/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit
import RxSwift
class ZJHomeSeckillCell: SNBaseTableViewCell {
    
    let didSelected = PublishSubject<ZJHomeMiaoMiaoModel>()
    //ZJHomeMiaoMiaoModel LBMerMarkListModel
    var models : [ZJHomeMiaoMiaoModel] = []{
        
        didSet{
            if models.count == 0 {return}
            goodsOne.groupCouponModel = models[0]
            if models.count <= 1{
                goodsTwo.groupCouponModel = models[0]
            }else{
                goodsTwo.groupCouponModel = models[1]
            }
        }
    }

    let goodsOne = ZJSeckillSubView()
    let goodsTwo = ZJSeckillSubView()
    
    override func setupView() {
        contentView.addSubview(goodsOne)
        contentView.addSubview(goodsTwo)
        goodsOne.snp.makeConstraints { (make) in
            make.width.snEqualTo(340)
            make.height.snEqualToSuperview()
            make.left.snEqualTo(20)
            make.top.equalToSuperview()
        }
        goodsTwo.snp.makeConstraints { (make) in
            make.size.equalTo(goodsOne)
            make.right.equalToSuperview().snOffset(-20)
            make.top.equalToSuperview()
        }
        goodsOne.addTap(self, action: #selector(tapOne))
        goodsTwo.addTap(self, action: #selector(tapTwo))
    }
    @objc func tapOne(){
        didSelected.onNext(goodsOne.groupCouponModel!)
    }
    @objc func tapTwo(){
        didSelected.onNext(goodsTwo.groupCouponModel!)
    }

}


class ZJSeckillSubView : SNBaseView{
    var groupCouponModel : ZJHomeMiaoMiaoModel? {
        didSet{
            guard let  model = groupCouponModel else{return}
//            let model = groupCouponModel
            imgView.kf.setImage(with: URL(string: model.mainImg))
//            if model.mainImgUrl.count > 0,model.mainImgUrl.isURLFormate() {
//            }
            couponTitleLabel.text = model.name
            //            subCouponTitleLabel.text = model!.markSubhead
            //            calculationCurrentTime(model!.validEndDate + " " + "23:59:59")
            price.text = "¥\(model.price)"
            nameBtn.setTitle(model.shopName, for: .disabled)
            countDownView.setRemainTime(endTime: model.endTime + " " + "23:59:59" )
        }
    }
    private let nameBtn = UIButton().then{
        $0.setImage(UIImage(named : "home_store"), for: .disabled)
        $0.titleLabel?.font = Font(24)
        $0.setTitleColor(Color(0x8f8f8f), for: .disabled)
        $0.isEnabled = false
//        $0.titleEdgeInsets = UIEdgeInsetsMake(0,2,0,0)
    } // 店铺名称
    private let imgView = UIImageView()//主图
    
    private let couponTitleLabel = UILabel().then{
        $0.textColor = Color(0x313131)
        $0.font = Font(30)
    }// 卡券标题
    //home_ticket2
//    private let kajuanView = ZJKaJuanView()
    
    let price = UILabel().then{
        $0.textColor = Color(0xff2e3e)
        $0.font = BoldFont(32)
    }
    
    let countDownView = ZJCountDownView.size(width: 35, height: 32, fontSize: fit(22))
    override func setupView() {
        addSubview(imgView)
        addSubview(nameBtn)
        addSubview(couponTitleLabel)
        addSubview(price)
        addSubview(countDownView)
        imgView.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.snEqualTo(234)
            make.top.snEqualTo(30)
            make.centerX.equalToSuperview()
        }
        couponTitleLabel.snp.makeConstraints { (make) in
            make.left.snEqualTo(5)
            make.top.equalTo(imgView.snp.bottom).snOffset(17)
        }
        price.snp.makeConstraints { (make) in
            make.bottom.snEqualToSuperview().snOffset(-30)
//            make.height.snEqualTo(32)
//            make.width.snEqualTo(106)
            make.left.snEqualTo(couponTitleLabel)
        }
        nameBtn.snp.makeConstraints { (make) in
            make.left.snEqualTo(couponTitleLabel)
            make.top.equalTo(couponTitleLabel.snp.bottom).snOffset(8)
//            make.width.snEqualTo(180)
        }
        countDownView.snp.makeConstraints { (make) in
            make.left.right.snEqualTo(imgView)
            make.bottom.snEqualTo(imgView)
            make.height.snEqualTo(48)
        }
    }
}
