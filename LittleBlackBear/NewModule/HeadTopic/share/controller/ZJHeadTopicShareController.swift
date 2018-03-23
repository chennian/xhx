//
//  ZJHeadTopicShareController.swift
//  LittleBlackBear
//
//  Created by MichaelChan on 18/3/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

class ZJHeadTopicShareController: SNBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    let topicView = ZJHeadTopicContentView()
    
    let textView = ZJHeadTopicInputView()
    
    override func setupView() {
        view.addSubview(topicView)
        view.addSubview(textView)
        textView.snp.makeConstraints { (make) in
            make.left.right.snEqualToSuperview()
            make.top.snEqualTo(20)
            make.height.snEqualTo(220)
        }
        topicView.snp.makeConstraints { (make) in
            make.left.snEqualTo(20)
            make.right.snEqualToSuperview().snOffset(-20)
            make.top.snEqualTo(textView.snp.bottom)
            make.height.snEqualTo(168)
        }
    }

}
