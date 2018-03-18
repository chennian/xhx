//
//  LBOpinionsWebViewController.swift
//  LittleBlackBear
//
//  Created by Apple on 2018/1/25.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

class LBOpinionsWebViewController: LBBaseWebViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        loadWithUrlString(urlString: baseUrl+"opinions/"+"\(mercId)/"+"\(phone)/" + signString.md5())
        // Do any additional setup after loading the view.
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
