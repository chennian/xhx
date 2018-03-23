//
//  LBNavigationController.swift
//  LittleBlackBear
//
//  Created by 蘇崢 on 2017/10/25.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

class LBNavigationController: UINavigationController {
	
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        configNavigationBar()
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        configNavigationBar()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
		super.viewDidLoad()

    
	}
    func configNavigationBar(){
        UIApplication.shared.setStatusBarStyle(.default, animated: true)
        let navigaitonBar =  UINavigationBar.appearance()
        navigaitonBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.black,NSFontAttributeName:UIFont.boldSystemFont(ofSize: 16*default_scale)]
        
        let image = UIImage.imageWithColor(COLOR_ffffff)
        navigaitonBar.setBackgroundImage(image, for: .default)
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffsetMake(-KSCREEN_WIDTH, 0), for: .default)
        
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(named:
            "backIcon")?.withRenderingMode(.alwaysOriginal)
        UINavigationBar.appearance().backIndicatorImage = UIImage(named:
            "backIcon")?.withRenderingMode(.alwaysOriginal)
    }
	override func pushViewController(_ viewController: UIViewController, animated: Bool) {
		self.childViewControllers.last?.hidesBottomBarWhenPushed = true
		super.pushViewController(viewController, animated: animated)
		if self.childViewControllers.count == 2 {
			self.childViewControllers.first?.hidesBottomBarWhenPushed = false
		}
	}
	
	override var preferredStatusBarStyle: UIStatusBarStyle{
		return .default
	}

}
