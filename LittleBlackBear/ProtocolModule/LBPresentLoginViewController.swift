//
//  LBPresentLoginViewController.swift
//  LittleBlackBear
//
//  Created by Apple on 2018/1/8.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import Foundation
protocol LBPresentLoginViewControllerProtocol {
    func  presentLoginViewController(_ loginSuccessHandler:(()->())? ,_ presentCompletHandler:(()->())?)
}
extension LBPresentLoginViewControllerProtocol where Self:UIViewController{
    
    func  presentLoginViewController(_ loginSuccessHandler:(()->())?,_ presentCompletHandler:(()->())?){
        let viewController = LBLoginViewController()
        
        viewController.loginSuccessHanlder = {
            guard let action = loginSuccessHandler else { return }
            action()
            viewController.dismiss(animated: true, completion: nil)
        }
        
        present(LBNavigationController(rootViewController:viewController), animated: true, completion: presentCompletHandler)
    }
}

