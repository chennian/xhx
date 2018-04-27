//
//  ZJMyCouponListHeader.swift
//  LittleBlackBear
//
//  Created by MichaelChan on 27/4/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit
import RxSwift
class ZJMyCouponListHeader: SNBaseView {
    
    let selectType = PublishSubject<ZJMyCouponType>()

//    fileprivate var lineAnimated : Bool = false
    var lineWIdth : CGFloat = fit(120)
    let unUsedBtn = UIButton().then({
        $0.setTitle("未使用", for: .normal)
        $0.setTitleColor(Color(0x313131), for: .normal)
        $0.setTitleColor(Color(0xff0000), for: .selected)
        $0.titleLabel?.font = Font(30)
        $0.isSelected = true
    })
    let usedBtn = UIButton().then({
        $0.setTitle("已使用", for: .normal)
        $0.setTitleColor(Color(0x313131), for: .normal)
        $0.setTitleColor(Color(0xff0000), for: .selected)
        $0.titleLabel?.font = Font(30)
        $0.isSelected = false
    })
    let dayOffBtn = UIButton().then({
        $0.setTitle("已过期", for: .normal)
        $0.setTitleColor(Color(0x313131), for: .normal)
        $0.setTitleColor(Color(0xff0000), for: .selected)
        $0.titleLabel?.font = Font(30)
        $0.isSelected = false
    })
    let line = UIView().then({
        $0.backgroundColor = Color(0xff0000)
        $0.layer.cornerRadius = fit(3)
    })
    override func setupView() {
        addSubview(unUsedBtn)
        addSubview(usedBtn)
        addSubview(dayOffBtn)
        addSubview(line)
        usedBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.snEqualTo(29)
        }
        unUsedBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(usedBtn)
            make.centerX.equalTo(usedBtn).snOffset(-256)
        }
        dayOffBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(usedBtn)
            make.centerX.equalTo(usedBtn).snOffset(256)
        }
        line.snp.makeConstraints { (make) in
            make.width.snEqualTo(120)
            make.height.snEqualTo(6)
            make.centerX.equalTo(unUsedBtn)
            make.bottom.equalToSuperview()
        }
    }
    
    override func bindEvent() {
        usedBtn.rx.controlEvent(UIControlEvents.touchUpInside).subscribe(onNext: { () in
            self.btnClick(btn: self.usedBtn)
            self.selectType.onNext(ZJMyCouponType.used)
        }).disposed(by: disposeBag)
        unUsedBtn.rx.controlEvent(UIControlEvents.touchUpInside).subscribe(onNext: { () in
            self.btnClick(btn: self.unUsedBtn)
            self.selectType.onNext(ZJMyCouponType.unused)
        }).disposed(by: disposeBag)
        dayOffBtn.rx.controlEvent(UIControlEvents.touchUpInside).subscribe(onNext: { () in
            self.btnClick(btn: self.dayOffBtn)
            self.selectType.onNext(ZJMyCouponType.dayOff)
        }).disposed(by: disposeBag)
    }
    func btnClick(btn : UIButton){
        if btn.isSelected {return}
        usedBtn.isSelected = false
        unUsedBtn.isSelected = false
        dayOffBtn.isSelected = false
        btn.isSelected = true
        updateLineConstraints(centerX: btn.centerX)
    }
    
    func setCurrentSelect(type : ZJMyCouponType,animated : Bool = false){
//        for model in menusModels{
//            model.isSelected = false
//
//            if model.type == type{
//                model.isSelected = true
//            }
//        }
//        selectType.value = type
//        lineAnimated = animated
        usedBtn.isSelected = false
        unUsedBtn.isSelected = false
        dayOffBtn.isSelected = false
        switch type {
        case .unused:
            unUsedBtn.isSelected = true
            self.updateLineConstraints(centerX: unUsedBtn.centerX)
        case .used:
            usedBtn.isSelected = true
            self.updateLineConstraints(centerX: usedBtn.centerX)
        case .dayOff:
            dayOffBtn.isSelected = true
            self.updateLineConstraints(centerX: dayOffBtn.centerX)
 
        }
        
        
    }
    
    func updateLineConstraints(centerX : CGFloat){
        line.snp.remakeConstraints { (make) in
            make.centerX.equalTo(centerX)
            make.width.equalTo(lineWIdth)
            make.height.snEqualTo(6)
            make.bottom.equalToSuperview()
        }
        
        // 告诉self.view约束需要更新
        self.needsUpdateConstraints()
        // 调用此方法告诉self.view检测是否需要更新约束，若需要则更新，下面添加动画效果才起作用
        self.updateConstraintsIfNeeded()
//        if lineAnimated {
            // 更新动画
            UIView.animate(withDuration: 0.2, animations: {
                self.layoutIfNeeded()
            })
//        }else{
//            self.layoutIfNeeded()
//        }
//        lineAnimated = false
    }

}
