//
//  LBTabbarViewController.swift
//  LittleBlackBear
//
//  Created by 蘇崢 on 2017/10/25.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

class LBTabbarViewController: UITabBarController {

	override func viewDidLoad() {
		super.viewDidLoad()
		configuraTabBarItem()
		configViewControllers()
	}
	
	override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
		return .portrait
	}
	
	func configuraTabBarItem() {
		
		let tabBarItem = UITabBarItem.appearance()
		tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor:COLOR_222222,NSAttributedStringKey.font:UIFont.systemFont(ofSize: 12.0)], for: .normal)
		tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor:COLOR_e60013,NSAttributedStringKey.font:UIFont.systemFont(ofSize: 12.0)], for: .selected)
		
		let tabBar = UITabBar.appearance()
		
		tabBar.barTintColor = UIColor.white
		tabBar.backgroundColor = UIColor.white
		tabBar.backgroundImage = image(white)
		tabBar.shadowImage = image(UIColor.rgbColorWith(hex: 0xE8E8E8))
		
	}

	func configViewControllers() {
        
        let shoppingMallViewController = LBShoppingMallViewController()
        let newsViewController = ZJHeadTopicViewController()//LBNewsViewController(style: .grouped)
//        let gamesViewController = LBGamesViewController()
        let mapViewController = LBMapViewController()
        
        
        let profileViewController = ZJMineViewController()//LBProfileViewController()

        
		_initRootViewController(viewController: shoppingMallViewController, title: "生活圈", image: "home_range", selImage: "home_range")
		_initRootViewController(viewController: newsViewController, title: "头条", image: "home_headline", selImage: "home_headline1")
        _initRootViewController(viewController: mapViewController, title: "地图", image: "home_map", selImage: "home_map1")
//        _initRootViewController(viewController: gamesViewController, title: "游戏", image: "tabbar_game_N", selImage: "tabbar_game_H")
		_initRootViewController(viewController: profileViewController, title: "我的", image: "home_my", selImage: "home_my1")
	
		
	
	}
	func _initRootViewController(viewController:UIViewController,title:String,image:String,selImage:String) ->Void {
		
		viewController.tabBarItem.title = title
		viewController.tabBarItem.image = UIImage(named: image)?.withRenderingMode(.alwaysOriginal)
		viewController.tabBarItem.selectedImage = UIImage(named: selImage)?.withRenderingMode(.alwaysOriginal)
	
        let navigationVC  = LBNavigationController(rootViewController: viewController)

		self.addChildViewController(navigationVC)
		
	}
	
	
	func image(_ color:UIColor) -> UIImage {
		
		let ract:CGRect = CGRect(x: 0, y: 0, width: 0.5, height: 0.5)
		
		UIGraphicsBeginImageContextWithOptions(ract.size, false, 0)
		color.setFill()
		UIRectFill(ract)
		
		let image:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
		UIGraphicsEndImageContext()
		return image
	}
	
	
	
}
