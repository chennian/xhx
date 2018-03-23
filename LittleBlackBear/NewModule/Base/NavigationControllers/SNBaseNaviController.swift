//
//  DDZBaseNaviController.swift
//  diandianzanumsers
//
//  Created by 楠 on 2017/6/10.
//  Copyright © 2017年 specddz. All rights reserved.
//

import UIKit


class SNBaseNaviController: UINavigationController {
    
    override func viewDidLoad() {
        stroeShadowImage = navigationBar.shadowImage
        self.interactivePopGestureRecognizer?.delegate = self
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
             if self.childViewControllers.count >= 1 {
            let button = UIButton()
            button.setImage(UIImage(named:"map_return1"), for: .normal)
//            button.sizeToFit()
            button.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
            button.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0)
            button.addTarget(self, action: #selector(backUp), for: .touchUpInside)
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
       
            
            viewController.hidesBottomBarWhenPushed = true
     
        }
        super.pushViewController(viewController, animated: animated)

      
    }
    
    
    
    
    override func popViewController(animated: Bool) -> UIViewController? {
        //print(viewControllers.count)
        
//        if viewControllers.count == 2{
//            DispatchQueue.main.async {
//                
//                self.tabBarController?.tabBar.isHidden = false
//                
//            }
//        }
        return super.popViewController(animated: animated)
        
        
    }
    
    @objc private func backUp(){
        
//        if DDZSingleton.shared.isBackToHome == .popToHome {
////            popToRootViewController(animated: false)
////            self.viewControllers[0].tabBarController?.tabBar.isHidden = false
//            self.viewControllers[0].tabBarController?.selectedIndex = 0
//            DDZSingleton.shared.isBackToHome = .pop
//            popToRootViewController(animated: true)
//        } else {
//        let _ = popViewController(animated: true)
//        }
        let _ = popViewController(animated: true)
    }
    
    
    
    
    @objc private func cancelButtonClick(){
        
        
        let _ = popViewController(animated: true)
        
    }
    
    var stroeShadowImage : UIImage?
    
    
    

}

extension SNBaseNaviController : UIGestureRecognizerDelegate {
    
}


extension SNBaseNaviController {
    
//    let stroeShadowImage = navigationBar.shadowImage
    
    func hindShadowImage(){
        navigationBar.shadowImage = UIImage()
    }
    
    func resetShadowImage(){
        navigationBar.shadowImage = stroeShadowImage
    }
    
}




class BMGeneralNaviBarItemButton : UIButton{
    
    convenience init(title : String,selectTitle : String = "") {
        self.init()
        setTitle(title, for: .normal)
        setTitle(selectTitle, for: .selected)
        setTitleColor( color_font_black_607, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: fit( 30))
        sizeToFit()
    }

}





