//
//  BMAlertController.swift
//  fdIos
//
//  Created by MichaelChan on 27/12/2017.
//  Copyright © 2017年 Spectator. All rights reserved.
//

import UIKit

typealias alertCallBack = ()->()

class BMAlertController: UIAlertController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    class func vc(title : String,titles : [String] ,callBack : [alertCallBack]) -> BMAlertController{
        let vc = BMAlertController(title: title, message: nil, preferredStyle: .alert)
        
        for i in 0..<titles.count{
            
            let action = UIAlertAction(title: titles[i], style: .default, handler: { (_) in
                if callBack.count > i + 1{
                    callBack[i]()
                }
            })
            vc.addAction(action)
        }
        
        return vc
    }

}
