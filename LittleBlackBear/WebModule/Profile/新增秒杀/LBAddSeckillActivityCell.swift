//
//  LBAddSeckillActivityCell.swift
//  LittleBlackBear
//
//  Created by Mac Pro on 2018/3/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit
import RxSwift


class LBAddSeckillActivityCell: SNBaseTableViewCell {
    var imgTap1 =  PublishSubject<(AliOssTransferProtocol,String)>()

    private let activityLable = UILabel().then{
        $0.text = "活动展示图"
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
    }
    
    var activityImge = DDZUploadBtn().then{
        $0.setImage(UIImage(named:"new_addition1"),for:.normal)
        $0.fuName = "img5"
        $0.imageView?.contentMode = .scaleAspectFill
    }
    
    func bindEvent(){
        
        activityImge.rx.controlEvent(UIControlEvents.touchUpInside).asObservable().subscribe(onNext: {[unowned self] () in
            self.imgTap1.onNext((self.activityImge,self.activityImge.fuName))
        }).disposed(by: disposeBag)
        
    }
    
    override func setupView() {
        contentView.addSubview(activityLable)
        contentView.addSubview(activityImge)
        bindEvent()

        
        activityLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalToSuperview().snOffset(26)
        }
        
        activityImge.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(activityLable.snp.bottom).snOffset(40)
            make.width.snEqualTo(270)
            make.height.snEqualTo(158)
        }
        
    }


}
