//
//  LBMerchantApplyViewControllerTypeTwo.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/11/16.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

class LBMerchantApplyViewControllerTypeTwo: LBMerchantApplyBaseViewControllerTypeTwo {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "完善商家基本信息"
        headViewStyle = .none(topImage: "merchantsApply2")
        nextVC = LBMerchantApplyViewControllerTypeThree()
        applyStepModel = ApplyModel.shareApplyModel.applySelfModel.stepTwo
    }

}
