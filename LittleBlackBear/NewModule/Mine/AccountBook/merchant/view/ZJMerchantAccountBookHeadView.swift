//
//  ZJMerchantAccountBookHeadView.swift
//  LittleBlackBear
//
//  Created by MichaelChan on 28/3/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit
import RxSwift
class ZJMerchantAccountBookHeadView: SNBaseView {
    
    
    let searchType = PublishSubject<String>()

    let line = UIView().then({
        $0.layer.cornerRadius = fit(4)
        $0.backgroundColor = Color(0x313131)
    })
    
    
    func setContnt(text1 : String,text2 : String){
        huoKuanBtn.countLab.text = text1 == "" ? "0.00" : text1
        daoliu.countLab.text = text2 == "" ? "0.00" : text2
    }
    let huoKuanBtn = ZJMerchantAccountBookHeadButton(name: "待结算货款")
    let daoliu = ZJMerchantAccountBookHeadButton(name: "导流收益")
    
    override func setupView() {
        addSubview(huoKuanBtn)
        addSubview(daoliu)
        addSubview(line)
        
        huoKuanBtn.snp.makeConstraints { (make) in
            make.bottom.snEqualToSuperview()
            make.height.equalToSuperview()
            make.width.snEqualTo(140)
            make.left.snEqualTo(137)
//            make.width.snEqualTo(130)
//            make.centerY.equalToSuperview()
        }
        daoliu.snp.makeConstraints { (make) in
             make.bottom.snEqualTo(huoKuanBtn)
             make.right.snEqualToSuperview().snOffset(-137)
            make.size.equalTo(huoKuanBtn)
        }
        line.snp.makeConstraints { (make) in
            make.bottom.snEqualToSuperview()
            make.width.snEqualTo(230)
            make.height.snEqualTo(9)
            make.centerX.equalTo(huoKuanBtn)
        }
        
    }
    
    override func bindEvent() {
        huoKuanBtn.rx.controlEvent(UIControlEvents.touchUpInside).subscribe(onNext: { () in
            if self.huoKuanBtn.isSelected {return}
            self.huoKuanBtn.isSelected = true
            self.daoliu.isSelected = false
            self.anmiLine(btn: self.huoKuanBtn)
            self.searchType.onNext("1")
        }).disposed(by: disposeBag)
        daoliu.rx.controlEvent(UIControlEvents.touchUpInside).subscribe(onNext: { () in
            if self.daoliu.isSelected {return}
            self.huoKuanBtn.isSelected = false
            self.daoliu.isSelected = true
            self.anmiLine(btn: self.daoliu)
            self.searchType.onNext("2")
        }).disposed(by: disposeBag)
    }

    private func anmiLine(btn : UIButton){
        line.snp.remakeConstraints { (make) in
            make.centerX.equalTo(btn)
            make.bottom.snEqualToSuperview()
            make.width.snEqualTo(230)
            make.height.snEqualTo(9)
        }
        // 告诉self.view约束需要更新
        self.needsUpdateConstraints()
        // 调用此方法告诉self.view检测是否需要更新约束，若需要则更新，下面添加动画效果才起作用
        self.updateConstraintsIfNeeded()
        
        self.layoutIfNeeded()
        
    }
}


class ZJMerchantAccountBookHeadButton : UIButton{
    let countLab = UILabel().then({
        $0.font = Font(34)
        $0.textColor = Color(0x313131)
        $0.textAlignment = .center
    })
    
    let nameLab = UILabel().then({
        $0.font = Font(26)
        $0.textColor = Color(0x313131)
        $0.textAlignment = .center
    })
    
    convenience init(name : String){
        self.init()
        nameLab.text = name
        setUpView()
    }
    
    func setUpView(){
        addSubview(countLab)
        addSubview(nameLab)
        nameLab.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().snOffset(-40)
            make.centerX.equalToSuperview()
            
            
        }
        countLab.snp.makeConstraints { (make) in
//            make.bottom.equalTo(nameLab.snp.top).snOffset(8)
//            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview()
            make.top.snEqualTo(40)
        }
//        sizeToFit()
    }
    

}

