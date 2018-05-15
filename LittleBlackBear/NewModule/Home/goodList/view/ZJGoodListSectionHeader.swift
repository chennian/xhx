//
//  ZJGoodListSectionHeader.swift
//  LittleBlackBear
//
//  Created by MichaelChan on 11/5/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

class ZJGoodListSectionHeader: SNBaseView {


    
    let title = UILabel().then({
        $0.font = Font(26)
        $0.textColor = Color(0x696969)
    })
    
    override func setupView() {
        title.text = "米饭"
        backgroundColor = Color(0xf5f5f5)
        let view = UIView()
        view.backgroundColor = .white
        addSubview(view)
        addSubview(title)
        
        view.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
            make.height.snEqualTo(53)
        }
        view.addSubview(title)
        title.snp.makeConstraints { (make) in
            make.left.snEqualTo(20)
            make.bottom.equalToSuperview()
        }
    }

}
