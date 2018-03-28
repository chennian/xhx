//
//  ZJServiceAccountHeaderView.swift
//  LittleBlackBear
//
//  Created by MichaelChan on 29/3/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

class ZJServiceAccountHeaderView: SNBaseView {

    let count = UILabel().then({
        $0.font = Font(60)
        $0.textColor = Color(0x313131)
    })
    let tipLab = UILabel().then({
        $0.font = Font(28)
        $0.text = "累计收益"
        $0.textColor = Color(0x313131)
    })
    
    override func setupView() {
        addSubview(count)
        addSubview(tipLab)
        tipLab.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.snEqualToSuperview().snOffset(-63)
        }
        count.snp.makeConstraints { (make) in
            make.top.snEqualTo(64)
            make.centerX.equalToSuperview()
            
        }
    }
    


}
