//
//  ZJShopDetailGroupTitleCell.swift
//  LittleBlackBear
//
//  Created by MichaelChan on 10/5/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit
import RxSwift
class ZJShopDetailGroupTitleCell: SNBaseTableViewCell {
    
    let clickMoreBtn = PublishSubject<String>()
    
    func set(title :  String, subTitle : String ,vc : String){
        titleLab.text = title
        moreButton.setTitle(subTitle, for: .normal)
        
        moreButton.rx.controlEvent(UIControlEvents.touchUpInside).subscribe(onNext: { () in
            self.clickMoreBtn.onNext(vc)
        }).disposed(by: disposeBag)
    }

    let titleLab = UILabel().then({
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
    })
    let moreButton = UIButton().then({
        $0.setTitleColor(Color(0x74787e), for: .normal)
        $0.titleLabel?.font = Font(27)
    })
    let arrowLImg = UIImageView(image: UIImage(named :"home_more")).then({
        $0.contentMode = .center
    })
    
    override func setupView() {
        contentView.addSubview(titleLab)
        contentView.addSubview(moreButton)
        contentView.addSubview(arrowLImg)
//        moreButton.sizeToFit()
        titleLab.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.snEqualTo(21)
        }
        moreButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().snOffset(-41)
            make.centerY.equalToSuperview()
        }
        arrowLImg.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().snOffset(-21)
        }
    }
    
    
    

}
