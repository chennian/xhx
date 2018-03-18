//
//  LBFansWebViewController.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/12/19.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit
/// 流量管理
class LBFansWebViewController: LBBaseWebViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        loadWithUrlString(urlString: baseUrl+"member/"+"\(mercId)/"+"\(phone)/" + signString.md5())

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
