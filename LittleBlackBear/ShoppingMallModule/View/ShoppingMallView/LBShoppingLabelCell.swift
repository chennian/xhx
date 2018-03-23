//
//  LBShoppingLabelCell.swift
//  LittleBlackBear
//
//  Created by 蘇崢 on 2017/12/11.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit
import RxSwift
class LBShoppingLabelCell: SNBaseTableViewCell {

    let didSelectMore = PublishSubject<String>()
    var title_text : String = "" {
        didSet{
            titleLab.text = title_text
            arrowButton.rx.controlEvent(UIControlEvents.touchUpInside).subscribe(onNext: {[unowned self] () in
                self.didSelectMore.onNext(self.title_text)
            }).disposed(by: disposeBag)
            switch title_text {
            case "优优商家":
                titleLab.textColor = Color(0xfa6205)
                imgView.image = UIImage(named:"home_merchant")
            case "秒秒":
                titleLab.textColor = Color(0xcb8406)
                imgView.image = UIImage(named:"home_seckill")
            case "团团":
                titleLab.textColor = Color(0x0481ef)
                imgView.image = UIImage(named:"home_purchase")
            default:
                break
            }
        }
    }
    var imgView : UIImageView = UIImageView()
    var titleLab = UILabel().then{
        $0.font = Font(32)
    }
    var arrowButton = UIButton().then{
        $0.setImage(UIImage(named : "home_more"), for: .normal)
        $0.isEnabled = false
        $0.isHidden = true
    }
    override func setupView() {
        contentView.addSubview(imgView)
        contentView.addSubview(titleLab)
        contentView.addSubview(arrowButton)
        imgView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.snEqualTo(30)
        }
        titleLab.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.snEqualTo(80)
        }
        arrowButton.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().snOffset(-30)
        }
    }
    
}
