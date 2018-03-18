//
//  LBMyMerchantWebViewController.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/12/19.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

class LBMyMerchantWebViewController: LBBaseWebViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        loadWithUrlString(urlString: baseUrl+"Merchant/"+"\(mercId)/"+"\(phone)/" + signString.md5())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
