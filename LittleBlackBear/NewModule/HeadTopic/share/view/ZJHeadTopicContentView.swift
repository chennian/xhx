//
//  ZJHeadTopicContentView.swift
//  LittleBlackBear
//
//  Created by MichaelChan on 18/3/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

class ZJHeadTopicContentView: SNBaseView {

    let nameLabe = UILabel().then{
        $0.font = Font(32)
        $0.textColor = Color(0x313131)
    }
    let contentLab = UILabel().then{
        $0.font = Font(26)
        $0.textColor = Color(0xa1a1a1)
    }
    
    let imgV = UIImageView().then{
        $0.contentMode = .scaleAspectFill
    }
    
    override func setupView() {
        backgroundColor = Color(0xf5f5f5)
        addSubview(nameLabe)
        addSubview(contentLab)
        addSubview(imgV)
    }
    
    

}
