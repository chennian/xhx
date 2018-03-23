//
//  LBNewMarketHead.swift
//  LittleBlackBear
//
//  Created by Mac Pro on 2018/3/17.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit
import RxSwift

enum ZJActicityBtnClickType : Int {
    case pin = 1
    case tuan
    case game
}

class LBNewMarketHead: SNBaseView {
    
    let btnClickPub = PublishSubject<ZJActicityBtnClickType>()
//    let

    var redLine = UILabel().then{
        $0.backgroundColor = UIColor.red
    }
    
    var button1 = UIButton().then {
        $0.setTitle("拼图卷", for: UIControlState.normal)
        $0.setTitleColor(UIColor.red, for: UIControlState.selected)
        $0.setTitleColor(UIColor.black, for: UIControlState.normal)
        $0.isSelected = true
    }
    var button2 = UIButton().then{

        $0.setTitle("秒杀卷", for: UIControlState.normal)
        $0.setTitleColor(UIColor.red, for: UIControlState.selected)
        $0.setTitleColor(UIColor.black, for: UIControlState.normal)

    }
    
    var button3 = UIButton().then{
        $0.setTitle("游戏卷", for: UIControlState.normal)
        $0.setTitleColor(UIColor.red, for: UIControlState.selected)
        $0.setTitleColor(UIColor.black, for: UIControlState.normal)
        
    }
    
    override func bindEvent() {
        button1.rx.controlEvent(UIControlEvents.touchUpInside).subscribe(onNext: { () in
            if self.button1.isSelected {return}
            self.button2.isSelected = false
            self.button3.isSelected = false
            self.button1.isSelected = true
            self.updateLineConstraints(btn : self.button1)
            self.btnClickPub.onNext(ZJActicityBtnClickType.pin)
        }).disposed(by: disposeBag)
        button2.rx.controlEvent(UIControlEvents.touchUpInside).subscribe(onNext: { () in
            if self.button2.isSelected {return}
            self.button1.isSelected = false
            self.button3.isSelected = false
            self.button2.isSelected = true
            self.updateLineConstraints(btn : self.button2)
            self.btnClickPub.onNext(ZJActicityBtnClickType.tuan)
        }).disposed(by: disposeBag)
        button3.rx.controlEvent(UIControlEvents.touchUpInside).subscribe(onNext: { () in
            self.btnClickPub.onNext(ZJActicityBtnClickType.game)
            if self.button3.isSelected {return}
            self.button1.isSelected = false
            self.button2.isSelected = false
            self.button3.isSelected = true
            self.updateLineConstraints(btn : self.button3)
        }).disposed(by: disposeBag)
    }
    
    func updateLineConstraints(btn : UIButton) {
        redLine.snp.remakeConstraints { (make) in
            make.centerX.equalTo(btn)
            make.bottom.equalToSuperview()
            make.height.snEqualTo(3)
            make.width.snEqualTo(160)
            self.needsUpdateConstraints()
            // 调用此方法告诉self.view检测是否需要更新约束，若需要则更新，下面添加动画效果才起作用
            self.updateConstraintsIfNeeded()
            
            self.layoutIfNeeded()
        }
    }

    override func setupView() {
        
        addSubview(button1)
        addSubview(button2)
        addSubview(button3)
        addSubview(redLine)


        button1.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(50)
            make.width.snEqualTo(120)
            make.height.snEqualTo(40)
            make.centerY.equalToSuperview()
        }
        button2.snp.makeConstraints { (make) in
            make.width.snEqualTo(120)
            make.height.snEqualTo(40)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        button3.snp.makeConstraints { (make) in
            make.right.equalToSuperview().snOffset(-50)
            make.width.snEqualTo(120)
            make.height.snEqualTo(40)
            make.centerY.equalToSuperview()
        }
        
        redLine.snp.makeConstraints { (make) in
            make.centerX.equalTo(button1.snp.centerX)
            make.bottom.equalToSuperview()
            make.height.snEqualTo(3)
            make.width.snEqualTo(160)
        }
        
    }
}
