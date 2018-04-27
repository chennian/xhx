//
//  ZJGetCouponVC.swift
//  LittleBlackBear
//
//  Created by MichaelChan on 27/4/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit
import RxSwift
class ZJGetCouponVC: SNBaseViewController {

 
    let goToMyCouponList = PublishSubject<Void>()
    
    let backgroundImage = UIImageView.init(image: UIImage(named:"succeed_background"))
    
    let iconImgV = UIImageView(image: UIImage(named:"succeed"))
    
    let closeBtn = UIButton().then({
        $0.setImage(UIImage(named:"succeed_close"), for: .normal)
    })
    let tipLab = UILabel().then({
        $0.text = "领取成功"
        $0.textColor = .white
        $0.font = Font(40)
    })
    
    let bottomBtn = UIButton().then({
        $0.backgroundColor = Color(0x272424)
        $0.setTitle("前往我的卡券包", for: .normal)
        $0.titleLabel?.font = Font(30)
        $0.layer.cornerRadius = fit(5)
    })
    
    
    override func setupView() {
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        view.addSubview(backgroundImage)
        view.addSubview(closeBtn)
        view.addSubview(tipLab)
        view.addSubview(bottomBtn)
        view.addSubview(iconImgV)
        
        backgroundImage.snp.makeConstraints { (make) in
             make.center.equalToSuperview()
        }
        iconImgV.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.snEqualTo(106)
        }
        
        closeBtn.snp.makeConstraints { (make) in
            make.top.snEqualTo(7)
            make.right.snEqualToSuperview().snOffset(-20)
        }
        tipLab.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.snEqualTo(250)
        }
        bottomBtn.snp.makeConstraints { (make) in
            make.width.snEqualTo(500)
            make.height.snEqualTo(90)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().snOffset(-68)
        }
    }
    
    override func bindEvent() {
        closeBtn.rx.controlEvent(UIControlEvents.touchUpInside).subscribe(onNext: { () in
            self.dismiss(animated: true, completion: nil)
        }).disposed(by: disposeBag)
        bottomBtn.rx.controlEvent(UIControlEvents.touchUpInside).subscribe(onNext: { () in
            self.goToMyCouponList.onNext(())
            self.dismiss(animated: false, completion: nil)
        }).disposed(by: disposeBag)
    }

}
