//
//  ZJPayErCodeContetnView.swift
//  LittleBlackBear
//
//  Created by MichaelChan on 27/3/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit
import RxSwift
class ZJPayErCodeContetnView: SNBaseView {

    
    let btnClick = PublishSubject<String>()
    
    func creatErcode(){
        let mercId = LBKeychain.get(CURRENT_MERC_ID)
        let url = "http://pay.xiaoheixiong.net/public/getOpenid_uid?mer_id=" + mercId
        let img = ErCodeTool.creatQRCodeImage(text: url, size: fit(400), icon: nil)
        ercodeBtn.setImage(img, for: UIControlState.normal)
    }
    
    override func bindEvent() {
        ercodeBtn.rx.controlEvent(UIControlEvents.touchUpInside).subscribe(onNext: {[unowned self] () in
            let mercId = LBKeychain.get(CURRENT_MERC_ID)
            let url = "http://pay.xiaoheixiong.net/public/getOpenid_uid?mer_id=" + mercId
//            let img = ErCodeTool.creatQRCodeImage(text: url, size: fit(400), icon: nil)
            self.btnClick.onNext(url)
        }).disposed(by: disposeBag)
    }
   
    let titleLab = UILabel().then({
        $0.text = "扫描二维码支付"
        $0.textColor = Color(0x484747)
        $0.font = Font(34)
        $0.textAlignment = .center
    })
    
    let line = UIView().then({
        $0.backgroundColor = Color(0xe5e5e5)
    })
    let tipLab = UILabel().then({
        $0.text = "点击二维码保存"
        $0.textColor = Color(0x868686)
        $0.font = Font(28)
        $0.textAlignment = .center
    })
    
    
    let ercodeBtn = UIButton()
    
    override func setupView() {
        addSubview(titleLab)
        addSubview(line)
        addSubview(tipLab)
        addSubview(ercodeBtn)
        
        titleLab.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.snEqualTo(66)
        }
        
        line.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.snEqualTo(1)
            make.top.snEqualTo(132)
        }
        
        
        tipLab.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.snEqualToSuperview().snOffset(-69)
        }
        ercodeBtn.snp.makeConstraints { (make) in
            make.width.height.snEqualTo(400)
            make.centerX.equalToSuperview()
            make.top.snEqualTo(line.snp.bottom).snOffset(50)
        }
        
        
    }
    
}
