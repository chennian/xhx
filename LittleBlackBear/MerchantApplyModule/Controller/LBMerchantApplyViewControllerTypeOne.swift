//
//  LBMerchantApplyViewControllerTypeOne.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/11/16.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

class LBMerchantApplyViewControllerTypeOne:LBMerchantApplyBaseViewControllerTypeOne {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "完善商家基本信息"
		headViewStyle = .none(topImage: "merchantsApply1")
        nextVC = LBMerchantApplyViewControllerTypeTwo()
        applyStepModel = ApplyModel.shareApplyModel.applySelfModel.stepOne
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
}
}
