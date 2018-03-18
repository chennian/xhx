//
//  LBMapAlertMercView.swift
//  LittleBlackBear
//
//  Created by 蘇崢 on 2018/2/4.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

class LBMapAlertMercView: UIView {
	
	var goonAction:((UIButton)->())?
	var pushShopAction:((UIButton)->())?
	
	var model:mapDetailListModel<mapLocation>?{
		didSet{
			guard model != nil else { return  }
			shopNameLabel.text = model!.companyName
			distanceLabel.text = model!.distance
			autographLabel.text = model!.address
			guard model!.headImgUrl.count > 0,model!.headImgUrl.isURLFormate() else { return  }
			avatarView.kf.setImage(with: URL(string:model!.headImgUrl))
	
		}
	}
	var imageUrl:String = ""{
		didSet{
			guard imageUrl.count > 0,imageUrl.isURLFormate() else { return  }
			avatarView.kf.setImage(with: URL(string:imageUrl))
		}
	}
	
	var shopName:String = ""{
		didSet{
			shopNameLabel.text = shopName
		}
	}
	
	var distance:String = ""{
		didSet{
			distanceLabel.text = distance
		}
	}
	
	var autograph:String = ""{
		didSet{
			autographLabel.text = autograph
		}
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.frame = CGRect(x: 0,
							y: 0,
							width: KSCREEN_WIDTH,
							height: KSCREEN_HEIGHT)
		self.backgroundColor = UIColor.rgb(0, 0, 0, alpha: 0.75)
		
		
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.frame = CGRect(x: 0,
							y: 0,
							width: KSCREEN_WIDTH,
							height: KSCREEN_HEIGHT)
		self.backgroundColor = UIColor.rgb(0, 0, 0, alpha: 0.75)
	
		
	}
	static func initSelf()->LBMapAlertMercView{
		let view  = Bundle.main.loadNibNamed("LBMapAlertMercView",
										owner: nil,
										options: nil)?.last as! LBMapAlertMercView
        
        
        view.setupAnimation()
		return view
		
	}
    
    private func setupAnimation(){
   
        let animation  = CABasicAnimation(keyPath: "transform.scale")
        animation.fromValue = 0.1
        animation.toValue = 1.0
        packetView.layer.add(animation, forKey: "Animation")

        
    }

	@IBOutlet weak var packetView: UIView!

	// 用户头像
	@IBOutlet weak var avatarView: UIImageView!
	// 店铺名称
	@IBOutlet weak var shopNameLabel: UILabel!
	// 距离
	@IBOutlet weak var distanceLabel: UILabel!
	// //签名  改为地址
	@IBOutlet weak var autographLabel: UILabel!
	// 继续寻宝
	@IBAction func clickGoonButton(_ sender: UIButton) {
		guard let action = goonAction else { return  }
		let animation = CABasicAnimation(keyPath: "transform.scale")
		animation.fromValue = 1.0
		animation.toValue = 3.0
		animation.duration = 0.525
		packetView.layer.add(animation, forKey: nil)

		UIView.animate(withDuration: 0.425, animations: {[weak self] in
			self?.alpha = 0
		}, completion: {_ in
            self.packetView.layer.removeAllAnimations()
            action(sender)
            
        })
		
		
	}
	// 进店逛逛
	@IBAction func clickPushShopButton(_ sender: UIButton) {
		guard let action = pushShopAction else { return  }
        self.removeFromSuperview()
		action(sender)
	}
}
