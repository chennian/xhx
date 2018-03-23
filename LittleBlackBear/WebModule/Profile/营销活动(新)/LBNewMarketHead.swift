//
//  LBNewMarketHead.swift
//  LittleBlackBear
//
//  Created by Mac Pro on 2018/3/17.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit
import RxSwift

class LBNewMarketHead: SNBaseTableViewCell {

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

    override func setupView() {
        
        contentView.addSubview(button1)
        contentView.addSubview(button2)
        contentView.addSubview(button3)
        contentView.addSubview(redLine)


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
