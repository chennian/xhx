//
//  ZJHeadTopicInputBar.swift
//  LittleBlackBear
//
//  Created by MichaelChan on 18/3/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

class ZJHeadTopicInputBar: SNBaseView {

    
    override func setupView() {
        addSubview(textInput)
//        addSubview(line)
//        addSubview(pubButton)
        textInput.snp.makeConstraints { (make) in
            make.left.snEqualTo(20)
            make.top.snEqualTo(20)
            
        }
        
//        pubButton.snp.makeConstraints { (make) in
//            mask
//        }
    }
    
    let textInput = UITextView().then{
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
    }
    
    let line = UIView().then{
        $0.backgroundColor = Color(0xf5f5f5)
    }
    
    let pubButton = UIButton().then{
        $0.setTitleColor(Color(0xff0000), for: .normal)
        $0.setTitle("发送", for: .normal)
        $0.titleLabel?.font = Font(32)
    }

}
