//
//  ZJMineTableviewHeader.swift
//  LittleBlackBear
//
//  Created by MichaelChan on 26/4/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit
import RxSwift

enum HeaderClickType {
    case changeName
    case changeHead
    case login
}
class ZJMineTableviewHeader: SNBaseView {

    let publish = PublishSubject<HeaderClickType>()
    func refreshContent(){
        if LBKeychain.get(ISLOGIN)  == LOGIN_TRUE{
            
            headIcon.kf.setImage(with: URL(string:LBKeychain.get(HeadImg)), for: .normal)
            nameLab.setTitle(LBKeychain.get(LLNickName) == "" ? "请设置昵称" : LBKeychain.get(LLNickName), for: .normal)
        }else{
            nameLab.setTitle("请登录", for: .normal)
            headIcon.setImage(UIImage(named:"userIcon"), for: .normal)
        }
        
    }
    
    override func bindEvent() {
        headIcon.rx.controlEvent(UIControlEvents.touchUpInside).subscribe(onNext: { () in
            if LBKeychain.get(ISLOGIN)  == LOGIN_TRUE{
                self.publish.onNext(.changeHead)
            }else{
                self.publish.onNext(.login)
            }
        }).disposed(by: disposeBag)
        nameLab.rx.controlEvent(UIControlEvents.touchUpInside).subscribe(onNext: { () in
            if LBKeychain.get(ISLOGIN)  == LOGIN_TRUE{
                self.publish.onNext(.changeName)
            }else{
                self.publish.onNext(.login)
            }
        }).disposed(by: disposeBag)
        
    }
    
    let headIcon = UIButton().then({
        $0.layer.borderWidth = fit(1.5)
        $0.layer.borderColor = UIColor.white.cgColor
        $0.layer.cornerRadius = fit(56)
        $0.backgroundColor = .white
        $0.setImage(UIImage(named:"userIcon"), for: .normal)
        $0.clipsToBounds = true
    })
    
    let nameLab = UIButton().then({
        $0.titleLabel?.font = Font(40)
        $0.setTitle("请登录", for: .normal)
    })
    
    override func setupView() {
        backgroundColor = UIColor(red: 255.0 / 255.0, green: 92.0 / 255.0, blue: 3.0 / 255.0, alpha: 1.0)
        addSubview(headIcon)
        addSubview(nameLab)
        headIcon.snp.makeConstraints { (make) in
            make.width.height.snEqualTo(112)
            make.left.snEqualTo(62)
            make.top.snEqualTo(7)
        }
        nameLab.snp.makeConstraints { (make) in
            make.centerY.equalTo(headIcon)
            make.left.snEqualTo(199)
        }
    }

}
