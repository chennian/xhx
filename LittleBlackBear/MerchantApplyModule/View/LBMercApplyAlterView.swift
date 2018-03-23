//
//  LBMercApplyAlterView.swift
//  LittleBlackBear
//
//  Created by 蘇崢 on 2017/11/23.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit


@objc protocol LBMercApplyAlterViewDelegate:NSObjectProtocol{
	@objc func selfApplyAction(_ button:UIButton)
	@objc func otherApplyAction(_ btn:UIButton)
	@objc func closeAction()
}
class LBMercApplyAlterView: UIView {
	
	private let backView  = UIView()
	private let mercBackView = UIImageView()
	private let messageLabel = UILabel()
	private let selfApplyBtn  = UIButton()
	private let otherApplyBtn = UIButton()
	private let closeBtn  = UIButton()
	private let mercIconView:UIImageView = UIImageView()

	var delegate:LBMercApplyAlterViewDelegate?

	override init(frame: CGRect) {
		super.init(frame: frame)
		setUpSubView()
		configUI()
	}
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setUpSubView() {
		
		addSubview(backView)
		addSubview(mercBackView)
		mercBackView.addSubview(messageLabel)
		mercBackView.addSubview(mercIconView)
		mercBackView.addSubview(selfApplyBtn)
		mercBackView.addSubview(otherApplyBtn)
		addSubview(closeBtn)
		
		backView.translatesAutoresizingMaskIntoConstraints = false
		mercBackView.translatesAutoresizingMaskIntoConstraints = false
		messageLabel.translatesAutoresizingMaskIntoConstraints = false
		mercIconView.translatesAutoresizingMaskIntoConstraints = false
		selfApplyBtn.translatesAutoresizingMaskIntoConstraints = false
		otherApplyBtn.translatesAutoresizingMaskIntoConstraints = false
		closeBtn.translatesAutoresizingMaskIntoConstraints = false
		
		mercBackView.isUserInteractionEnabled = true 
		backView.backgroundColor = UIColor.rgb(0, 0, 0, alpha: 0.7)
		mercBackView.image = UIImage(named:"merchantApplyBackImg")
		mercIconView.image = UIImage(named:"mechantHomeLogo")
		
		closeBtn.setImage(UIImage(named:"merchantColse_X"), for: .normal)
		closeBtn.addTarget(self , action: #selector(closeViewAction), for: .touchUpInside)
		
		messageLabel.textColor = COLOR_9C9C9C
		messageLabel.font = FONT_30PX
		messageLabel.textAlignment = .center
		messageLabel.text = "您还不是商家，请先申请成为小黑熊商家"
        messageLabel.numberOfLines = 0

		selfApplyBtn.setBackgroundImage(UIImage(named:"selfApplyBtn"), for: .normal)
		selfApplyBtn.addTarget(self, action: #selector(clickSelfApplyBtnAction(_ :)), for: .touchUpInside)
		
		otherApplyBtn.setBackgroundImage(UIImage(named:"otherApplyBtn"), for: .normal)
		otherApplyBtn.addTarget(self, action: #selector(clickOtherApplyBtnAction(_ :)), for: .touchUpInside)
		
		
	}
	
	func configUI(){
		
		/// backView
		addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[backView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["backView":backView]))
		addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[backView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["backView":backView]))
		
		/// mercBackView
		addConstraint(BXLayoutConstraintMake(mercBackView, .centerX, .equal,self,.centerX))
		addConstraint(BXLayoutConstraintMake(mercBackView, .centerY, .equal,self,.centerY))
		addConstraint(BXLayoutConstraintMake(mercBackView, .width, .equal,nil,.width,295*AUTOSIZE_X))
		addConstraint(BXLayoutConstraintMake(mercBackView, .height, .equal,nil,.height,270*AUTOSIZE_Y))

		/// closeBtn
		addConstraint(BXLayoutConstraintMake(closeBtn, .centerX, .equal,mercBackView,.right,-5*AUTOSIZE_X))
		addConstraint(BXLayoutConstraintMake(closeBtn, .centerY, .equal,mercBackView,.top,15*AUTOSIZE_Y))
		addConstraint(BXLayoutConstraintMake(closeBtn, .width, .equal,nil,.width,32))
		addConstraint(BXLayoutConstraintMake(closeBtn, .height, .equal,nil,.height,32))
		
		/// mercIconView
		addConstraint(BXLayoutConstraintMake(mercIconView, .centerX, .equal,mercBackView,.centerX))
		addConstraint(BXLayoutConstraintMake(mercIconView, .top, .equal,mercBackView,.top,85*AUTOSIZE_Y))
		addConstraint(BXLayoutConstraintMake(mercIconView, .width, .equal,nil,.width,97*AUTOSIZE_X))
		addConstraint(BXLayoutConstraintMake(mercIconView, .height, .equal,nil,.height,50*AUTOSIZE_Y))
		
		/// messageLabel
		addConstraint(BXLayoutConstraintMake(messageLabel, .centerX, .equal,mercBackView,.centerX))
		addConstraint(BXLayoutConstraintMake(messageLabel, .top, .equal,mercIconView,.bottom, 18))
        addConstraint(BXLayoutConstraintMake(messageLabel, .left, .equal,mercBackView,.left,10*AUTOSIZE_X))
        addConstraint(BXLayoutConstraintMake(messageLabel, .right, .equal,mercBackView,.right,-10*AUTOSIZE_X))

		/// otherApplyBtn
		addConstraint(BXLayoutConstraintMake(otherApplyBtn, .left, .equal,mercBackView,.left,22*AUTOSIZE_X))
		addConstraint(BXLayoutConstraintMake(otherApplyBtn, .top, .equal,messageLabel,.bottom,10*AUTOSIZE_Y))
		addConstraint(BXLayoutConstraintMake(otherApplyBtn, .width, .equal,nil,.width,117*AUTOSIZE_X))
		addConstraint(BXLayoutConstraintMake(otherApplyBtn, .height, .equal,nil,.height,45*AUTOSIZE_Y))
		
		/// selfApplyBtn
		addConstraint(BXLayoutConstraintMake(selfApplyBtn, .top, .equal,otherApplyBtn,.top))
		addConstraint(BXLayoutConstraintMake(selfApplyBtn, .left, .equal,otherApplyBtn,.right,20))
		addConstraint(BXLayoutConstraintMake(selfApplyBtn, .width, .equal,otherApplyBtn,.width))
		addConstraint(BXLayoutConstraintMake(selfApplyBtn, .height, .equal,nil,.height,45*AUTOSIZE_Y))
	
	}
	
	func closeViewAction()  {
		guard (delegate?.responds(to: #selector(delegate?.closeAction)))!else {return}
		self.delegate?.closeAction()
		
	}
	func clickSelfApplyBtnAction(_ btn:UIButton)  {
		guard (delegate?.responds(to: #selector(delegate?.selfApplyAction(_:)) ))!else {return}
		self.delegate?.selfApplyAction(btn)
	}
	func clickOtherApplyBtnAction(_ btn:UIButton)  {
		guard (delegate?.responds(to: #selector(delegate?.otherApplyAction(_:)) ))!else {return}
		self.delegate?.otherApplyAction(btn)
	}
}


