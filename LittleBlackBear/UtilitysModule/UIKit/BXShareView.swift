//
//  BXShareView.swift
//  BaiXiangPay
//
//  Created by 蘇崢 on 2017/5/16.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit
protocol BXShareViewDelegate:NSObjectProtocol {
	func sendWXSecneSession()
	func sendWXSecneTimeline()
}
class BXShareView: UIView {

	weak var delegate:BXShareViewDelegate?
	
	
	override init(frame:CGRect) {
		super.init(frame: frame)
        self.frame = CGRect(x: 0,
                            y: 64,
                            width: KSCREEN_WIDTH,
                            height: KSCREEN_HEIGHT-64)
		InitSubView()
        self.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                         action: #selector(dissmissShareView)))
    }
    
    func dissmissShareView() {
        self.removeFromSuperview()
    }
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	let contentView: UIView = {
		let view  = UIView(frame: CGRect(x: 0,
                                         y: KSCREEN_HEIGHT - 49 - 64,
                                         width: KSCREEN_WIDTH,
                                         height: 49))
		view .backgroundColor  = white
		return view
	}()
	//WXSceneSession
	let sessionBtn: UIButton = {
		let  btn  = UIButton()
		btn.setTitle("微信", for: .normal)
		btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
		btn.setTitleColor(black, for: .normal)
		btn.setImage(UIImage(named: "WXSceneSession"), for: .normal)
		return btn
	}()
	let timelineBtn: UIButton = {
		let  btn  = UIButton()
		btn.setTitle("朋友圈", for: .normal)
		btn.setTitleColor(black, for: .normal)
		btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
		btn.setImage(UIImage(named: "WXSceneTimeline"), for: .normal)
		return btn
	}()
	let centerLine: UIView = {
		let view  = UIView()
		view.backgroundColor = COLOR_e60013
		return view
	}()
	func InitSubView() {
		
		addSubview(contentView)
		contentView.addSubview(sessionBtn)
		contentView.addSubview(timelineBtn)
		contentView.addSubview(centerLine)
		sessionBtn.addTarget(self, action:#selector(sendWXSecneSession(_ :)), for: .touchUpInside)
		timelineBtn.addTarget(self, action:#selector(sendWXSecneTimeline(_ :)), for: .touchUpInside)

		if WXApi.isWXAppInstalled(){
			sessionBtn.isHidden = false
			timelineBtn.isHidden = false
		}else{
			sessionBtn.isHidden = true
			timelineBtn.isHidden = true
		}
        
        sessionBtn.translatesAutoresizingMaskIntoConstraints = false
        timelineBtn.translatesAutoresizingMaskIntoConstraints = false
        centerLine.translatesAutoresizingMaskIntoConstraints = false
        
        sessionBtn.titleLabel?.textAlignment = .center
        sessionBtn.titleLabel?.textAlignment = .center

        contentView.addConstraint(BXLayoutConstraintMake(sessionBtn, .top, .equal,contentView,.top))
        contentView.addConstraint(BXLayoutConstraintMake(sessionBtn, .left, .equal,contentView,.left))
        contentView.addConstraint(BXLayoutConstraintMake(sessionBtn, .right, .equal,centerLine,.left))
        contentView.addConstraint(BXLayoutConstraintMake(sessionBtn, .width, .equal,timelineBtn,.width))
        contentView.addConstraint(BXLayoutConstraintMake(sessionBtn, .height, .equal,nil,.height,49))
        
        contentView.addConstraint(BXLayoutConstraintMake(timelineBtn, .top, .equal,contentView,.top))
        contentView.addConstraint(BXLayoutConstraintMake(timelineBtn, .right, .equal,contentView,.right))
        contentView.addConstraint(BXLayoutConstraintMake(timelineBtn, .left, .equal,centerLine,.right))
        contentView.addConstraint(BXLayoutConstraintMake(timelineBtn, .width, .equal,sessionBtn,.width))
        contentView.addConstraint(BXLayoutConstraintMake(timelineBtn, .height, .equal,nil,.height,49))
        
        contentView.addConstraint(BXLayoutConstraintMake(centerLine, .top, .equal,contentView,.top,5))
        contentView.addConstraint(BXLayoutConstraintMake(centerLine, .centerX, .equal,contentView,.centerX))
        contentView.addConstraint(BXLayoutConstraintMake(centerLine, .centerY, .equal,contentView,.centerY))
        contentView.addConstraint(BXLayoutConstraintMake(centerLine, .width, .equal,nil,.width,1))
        contentView.addConstraint(BXLayoutConstraintMake(centerLine, .bottom, .equal,contentView,.bottom,-5))

		

	}
	
	func sendWXSecneSession(_ button:UIButton) {
		self.delegate?.sendWXSecneSession()
	}
	func sendWXSecneTimeline(_ button:UIButton) {
		self.delegate?.sendWXSecneTimeline()
	}

}
