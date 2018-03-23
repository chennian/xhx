//
//  LBMerchantApplyViewControllerTypeThree.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/11/16.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

class LBMerchantApplyViewControllerTypeThree: LBMerchantApplyBaseViewControllerTypeThree {


    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "完善商家基本信息"
		headViewStyle = .none(topImage: "merchantsApply3")
        applyStepModelPriv = ApplyModel.shareApplyModel.applySelfModel.stepThree.priv
        applyStepModelCompany = ApplyModel.shareApplyModel.applySelfModel.stepThree.company
        
    }
}
