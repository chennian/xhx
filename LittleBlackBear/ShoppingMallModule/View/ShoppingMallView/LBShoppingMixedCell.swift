//
//  LBShoppingMixedCell.swift
//  LittleBlackBear
//
//  Created by 蘇崢 on 2017/12/11.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

class LBShoppingMixedCell: SNBaseTableViewCell {
    
    var cellType: shoppingCellTye = .title("",""){
        didSet{
            switch cellType {
            case let .mixCell(model):
//                titleLabel.text = model.merShortName
//                distanceLabel.text = "人均 ¥12/人 | " + "距离" + model.distance
//
//                popularityBtn.setTitle("人气76", for: .disabled)
//                if model.mainImgUrl.isURLFormate() == true {
//                    imgView.kf.setImage(with: URL(string:model.mainImgUrl))
//                }
//                titleLabel.text = model.labelName

                scoreLab.text = "4.5"
            default:
                break
            }
        }
    }

    private let imgView = UIImageView().then{
        $0.layer.borderWidth = fit(1)
        $0.layer.borderColor = Color(0xececec).cgColor
    }
    
    
    private let popularityBtn = UIButton().then{
        $0.titleLabel?.font = Font(24)
        $0.setTitleColor(Color(0x415e56), for: .disabled)
        $0.isEnabled = false
        $0.setImage(UIImage(named : "home_popularity"), for: .disabled)
        $0.isHidden = true
    }
    private let titleLabel = UILabel().then{
        $0.textColor = Color(0x313131)
        $0.font = BoldFont(32)
    }
    private let distanceLabel = UILabel().then{
        $0.font = Font(24)
        $0.textColor = Color(0x565656)
    }
    
    var starView : XHStarRateView?

    let scoreLab = UILabel().then{
        $0.textColor = Color(0x4e5156)
        $0.font = Font(24)
    }
    private let merLabe = UILabel().then{
        $0.font = Font(24)
        $0.textAlignment = .center
        $0.textColor = Color(0xff4242)
        $0.backgroundColor = Color(0xffecec)
        $0.layer.borderColor = Color(0xffc1c1).cgColor
        $0.layer.borderWidth = fit(1)
    }
    
 
    var model:LBMerInfosModel?{
        didSet{
            guard model != nil else {return}
            titleLabel.text = model!.merShortName
            distanceLabel.text = "人气76 | " + "距离" + model!.distance
            //                configMerLevel(model)
            //                configMerchantClass(model)
//            popularityBtn.setTitle("人气76", for: .disabled)
            if model!.mainImgUrl.isURLFormate() == true {
                imgView.kf.setImage(with: URL(string:model!.mainImgUrl))
            }
            merLabe.text = model!.labelName
            if merLabe.text == "" {
                merLabe.isHidden = true
            }
            let width = countWidth(text: model!.labelName, font: Font(24)).width + fit(28)
            merLabe.snp.remakeConstraints { (make) in
                make.bottom.equalToSuperview().snOffset(-42)
                make.left.equalTo(titleLabel)
                make.height.snEqualTo(36)
                make.width.equalTo(width)
            }
            starView?.currentScore = 4.5
            scoreLab.text = "4.5"
        }
    }
    
    
    

    
    override func setupView() {
        starView = XHStarRateView(frame: CGRect(x: fit(226), y: fit(80), width: fit(150), height: fit(22)))
        starView!.isUserInteractionEnabled = false
//        starView.frame = CGRectAdjust(x: 0, y: 0, width: fit(155), height: fit(30))
        contentView.addSubview(imgView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(distanceLabel)
        contentView.addSubview(merLabe)
        contentView.addSubview(popularityBtn)
        contentView.addSubview(starView!)
        contentView.addSubview(scoreLab)
        self.backgroundColor = ColorRGB(red: 255, green: 255, blue: 255)
        imgView.snp.makeConstraints { (make) in
            make.left.snEqualTo(20)
            make.centerY.equalToSuperview()
            make.height.width.snEqualTo(174)
        }
        starView?.delegate = self
        titleLabel.snp.makeConstraints { (make) in
            make.top.snEqualTo(33)
            make.left.equalTo(imgView.snp.right).snOffset(30)
        }
        popularityBtn.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().snOffset(-30)
        }
        
        distanceLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.bottom.equalTo(merLabe.snp.top).snOffset(-8)
        }
        line.snp.remakeConstraints { (make) in
            make.left.snEqualTo(206)
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
            make.height.snEqualTo(fit(1))
        }
        scoreLab.snp.makeConstraints { (make) in
            make.centerY.equalTo(starView!)
            make.left.snEqualTo(starView!.snp.right)
        }
//        starView.snp.makeConstraints { (make) in
//            make.width.snEqualTo(150)
//            make.height.snEqualTo(22)
//            make.left.snEqualTo(titleLabel)
//            make.top.snEqualTo(titleLabel.snp.bottom).snOffset(8)
//        }
    }


    
}

extension LBShoppingMixedCell : XHStarRateViewDelegate{
    func starRateView(_ starRateView: XHStarRateView!, currentScore: CGFloat) {
        
    }
}
