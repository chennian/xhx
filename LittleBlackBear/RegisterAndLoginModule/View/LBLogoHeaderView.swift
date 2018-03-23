//
//  LBLogoHeaderView.swift
//  LittleBlackBear
//
//  Created by 蘇崢 on 2017/11/23.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

class LBLogoHeaderView: UIView {

	override init(frame: CGRect) {
		super.init(frame: frame)
        self.frame = CGRect(x: 0, y: 0, width: KSCREEN_WIDTH, height: 185*AUTOSIZE_Y)
		configUI()
	}
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private let logoImgView = UIImageView()
	private let nameLabel = UILabel()
	private func configUI() {
		
		addSubview(logoImgView)
		addSubview(nameLabel)
		
		logoImgView.image = UIImage(named:"LBlogoIcon")
		logoImgView.translatesAutoresizingMaskIntoConstraints = false
		nameLabel.translatesAutoresizingMaskIntoConstraints = false
		nameLabel.text = "小黑熊"
		nameLabel.font = FONT_36PX
		nameLabel.textColor = COLOR_222222
		
		addConstraint(BXLayoutConstraintMake(logoImgView, .centerX, .equal,self,.centerX))
		addConstraint(BXLayoutConstraintMake(logoImgView, .centerY, .equal,self,.centerY))
		addConstraint(BXLayoutConstraintMake(logoImgView, .width,  .equal,nil,.width,88))
		addConstraint(BXLayoutConstraintMake(logoImgView, .height, .equal,nil,.height,88))
		
		addConstraint(BXLayoutConstraintMake(nameLabel, .centerX, .equal,self,.centerX))
		addConstraint(BXLayoutConstraintMake(nameLabel, .top,  .equal,logoImgView,.bottom,20))
		
	}
}




